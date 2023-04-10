using Statline.Common.Notification;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto;
using System.Runtime.CompilerServices;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi;

public abstract class StatTracApiReferralSourceBase<TReferral> : IReferralSource<TReferral>
    where TReferral : Domain.ReferralDetails
{
    protected IStatTracApiClient StatTracApiClient { get; }
    protected ILogger Logger { get; }
    protected INotificationService NotificationService { get; }

    protected StatTracApiReferralSourceBase(
        IStatTracApiClient statTracApiClient,
        INotificationService notificationService,
        ILogger<StatTracApiReferralSourceBase<TReferral>> logger)
    {
        StatTracApiClient = Check.NotNull(statTracApiClient, nameof(statTracApiClient));
        Logger = Check.NotNull(logger, nameof(logger));
        NotificationService = Check.NotNull(notificationService, nameof(notificationService));
    }

    public abstract IAsyncEnumerable<TReferral> GetReferralsAsync(DateTimeOffset from, DateTimeOffset to);

    protected IAsyncEnumerable<ReferralDetails> GetReferralDetailsForIdsAsync(
       IEnumerable<int> referralIds,
       CancellationToken cancellationToken = default)
    {
        return GetReferralDetailsForIdsAsync<int>(
            referralIds,
            id => id,
            cancellationToken).Select(item => item.Referral);
    }

    protected async IAsyncEnumerable<(TIdContainer IdContainer, ReferralDetails Referral)>
        GetReferralDetailsForIdsAsync<TIdContainer>(
            IEnumerable<TIdContainer> idContainers,
            Func<TIdContainer, int> idSelector,
            [EnumeratorCancellation]
            CancellationToken cancellationToken = default)
    {
        foreach (var referralIdContainer in idContainers)
        {
            int referralId = idSelector(referralIdContainer);

            var referralDetail = await StatTracApiClient.GetReferralDetailsAsync(
                referralId, 
                cancellationToken).ConfigureAwait(false);

            if (referralDetail is not null)
                yield return (referralIdContainer, referralDetail);
            else
            {
                Logger.LogReferralNotFound(referralId);
                await NotificationService.NotifyReferralNotFoundAsync(referralId).ConfigureAwait(false);
            }
        }
    }
}
