using Microsoft.Extensions.Logging;
using Polly;
using Statline.Common.Repository;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.ReferralProcessor;

public class ReferralProcessorApplication
{
    private const int ConcurrencyRetryCount = 5;
    private static readonly TimeSpan ConcurrencyMaxDelay = TimeSpan.FromSeconds(1);

    private readonly IUpdatedReferralRepository updatedReferralRepository;
    private readonly IReferralRepository mainReferralRepository;
    private readonly ILogger logger;
    private readonly AsyncPolicy concurrenRetryPolicy;
    private readonly Random random = new Random();

    public ReferralProcessorApplication(
        IUpdatedReferralRepository updatedReferralRepository,
        IReferralRepository mainReferralRepository,
        ILogger<ReferralProcessorApplication> logger)
    {
        Check.NotNull(updatedReferralRepository, nameof(updatedReferralRepository));
        Check.NotNull(mainReferralRepository, nameof(mainReferralRepository));
        Check.NotNull(logger, nameof(logger));

        this.updatedReferralRepository = updatedReferralRepository;
        this.mainReferralRepository = mainReferralRepository;
        this.logger = logger;

        // TODO: Move all this concurrency
        // handling to a separate class.
        concurrenRetryPolicy = Policy
           .Handle<ConcurrencyViolationException>()
           .Or<EntityAlreadyExistsException>()
           .WaitAndRetryAsync(
               ConcurrencyRetryCount,
               retryAttempt => TimeSpan.FromMilliseconds(random.Next(
                   (int)ConcurrencyMaxDelay.TotalMilliseconds * retryAttempt)),
               new Action<Exception, TimeSpan, int, Context>(OnConcurrentRetry));
    }

    private void OnConcurrentRetry(Exception ex, TimeSpan delay, int retry, Context context)
    {
        var referralId = (ReferralId)context["referralId"];

        switch (ex)
        {
            case ConcurrencyViolationException _:
                // Another app instance running concurrently
                // could be faster and already updated the referral
                // after we read it. Repeating will re-read and try to 
                // update again.
                logger.LogReferralAlreadyExists(referralId);
                break;
            case EntityAlreadyExistsException _:
                // Another app instance running concurrently
                // could be faster and already created the referral
                // in the repository. Repeating will try to update 
                // instead of create.
                logger.LogReferralIsOutdated(referralId);
                break;
        }

        logger.LogRetry(referralId, delay, retry, ConcurrencyRetryCount);
    }

    public async Task<ReferralProcessingResult> ProcessUpdatedReferralAsync(ReferralId referralId)
    {
        Check.NotNull(referralId, nameof(referralId));

        var context = new Context(nameof(ProcessUpdatedReferralCore))
        {
            ["referralId"] = referralId
        };

        // Here we handle optimistic concurrency.
        // Note that this is for "updated" repository only,
        // since "main" repository is used only for reads.
        var status = await concurrenRetryPolicy.ExecuteAsync(async _ =>
        {
            return await ProcessUpdatedReferralCore(referralId);
        },
        context);

        return new ReferralProcessingResult(status);
    }

    private async Task<ReferralProcessingStatus> ProcessUpdatedReferralCore(ReferralId referralId)
    {
        var existingReferral =
            await updatedReferralRepository.GetDetailsByIdAsync(referralId);

        // Its important to read from "main" repository AFTER
        // reading from "updated" repository to be sure
        // that referral read from main is not "older" than one
        // read from updated. This allows to avoid concurrency issues
        // like overwriting "fresh" referral in the updated repository
        // with "old" one from main. Its possible because
        // these two repositories don't have unified referral version 
        // tracking.
        var updatedReferral =
            await GetReferralFromMainRepository(referralId);

        logger.LogReferralStatus(referralId, (ReferralStatus)updatedReferral.ReferralStatusId);

        if (updatedReferral.ReferralStatusId == (int)ReferralStatus.Recycled)
        {
            bool existed = existingReferral != null;

            if (existed)
            {
                await updatedReferralRepository.DeleteAsync(existingReferral);
            }

            logger.LogReferralRecycled(referralId, existed);

            return ReferralProcessingStatus.Recycled;
        }

        if (existingReferral == null)
        {
            await updatedReferralRepository.AddAsync(updatedReferral);

            logger.LogReferralAdded(referralId);

            return ReferralProcessingStatus.Added;
        }
        else
        {
            bool hasChanges = !AreEqual(existingReferral, updatedReferral);

            if (hasChanges)
            {
                // We can't just pass updatedReferral to the UpdateAsync,
                // because this instance comes from different repository and is 
                // not tracked by this one (in terms of versioning and concurrency).
                // Instead we just copy fresh state to the existing instance and
                // then update it in the repository.
                CopyReferral(source: updatedReferral, target: existingReferral);

                await updatedReferralRepository.UpdateAsync(existingReferral);

                logger.LogReferralUpdated(referralId);

                return ReferralProcessingStatus.Updated;
            }
            else
            {
                logger.LogReferralNotChanged(referralId);

                return ReferralProcessingStatus.NoChanges;
            }
        }
    }

    private async Task<ReferralDetails> GetReferralFromMainRepository(ReferralId referralId)
    {
        ReferralDetails? updatedReferral =
            await mainReferralRepository.GetDetailsByIdAsync(referralId);

        if (updatedReferral == null)
        {
            throw new EntityDoesntExistException(
                $"Referral with id '{referralId}' can't be found in main repository.");
        }

        return updatedReferral;
    }

    private static bool AreEqual(ReferralDetails left, ReferralDetails right)
    {
        return ReferralEqualityComparer.Instance.Equals(left, right);
    }

    /// <summary>
    /// Copies one <see cref="ReferralDetails"/>'s state to another.
    /// </summary>
    /// <remarks>
    /// This is a fast to implement solution which should not 
    /// be used widely. Consider using AutoMapper instead.
    /// </remarks>
    private static void CopyReferral(ReferralDetails source, ReferralDetails target)
    {
        // This is an ad-hoc workaround for replacing "get-only"
        // collection's content. More generic approach can be 
        // used as described here https://stackoverflow.com/a/42167029.
        target.ReferralLogEvents.Clear();

        if (target.SecondaryData != null)
        {
            target.SecondaryData.Medications.Clear();
            target.SecondaryData.Antibiotics.Clear();
            target.SecondaryData.Steroids.Clear();
        }

        // TODO: Implement using AutoMapper. Don't want to keep dependency on
        // Json.NET, and System.Text.Json serializer doesn't support populating objects.
        //var serializedSource = JsonConvert.SerializeObject(source);
        //JsonConvert.PopulateObject(serializedSource, target, serializerSettings);

        throw new NotImplementedException();
    }
}

