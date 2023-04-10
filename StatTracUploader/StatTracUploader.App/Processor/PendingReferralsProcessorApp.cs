using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Common.Notification;
using Statline.StatTracUploader.Domain.Main.Calls;
using Statline.StatTracUploader.Domain.Main.Enums;
using Statline.StatTracUploader.Domain.Main.LogEvents;
using Statline.StatTracUploader.Domain.Main.Organizations;
using Statline.StatTracUploader.Domain.Main.Persons;
using Statline.StatTracUploader.Domain.Main.Referrals;
using Statline.StatTracUploader.Domain.Main.SourceCodes;
using Statline.StatTracUploader.Domain.Temporary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.App.Processor
{
    public class PendingReferralsProcessorApp
    {
        private readonly IMainRepositoryStatusProvider mainRepositoryStatusProvider;
        private readonly INotificationService notificationService;
        private readonly PendingReferralsProcessorAppOptions options;
        private readonly NotificationMessageBuilder notificationBuilder = new();
        private readonly ILogger logger;

        private readonly IReferralUploadRepository tempReferralRepository;
        private readonly IReferralRepository mainReferralRepository;
        private readonly IOrganizationRepository organizationRepository;
        private readonly ILogEventRepository logEventRepository;
        private readonly IPersonRepository personRepository;
        private readonly ISourceCodeRepository sourceCodeRepository;
        private readonly IEnumRepository enumRepository;
        private readonly ICallRepository callRepository;

        private readonly PersonLookupService personLookupService;
        private readonly LogEventPublishingService logEventPublishingService;

        private const int StatlineOrganizationId = 194;

        public PendingReferralsProcessorApp(
            IOptions<PendingReferralsProcessorAppOptions> options,
            IReferralUploadRepository tempReferralRepository,
            IReferralRepository mainReferralRepository,
            ICallRepository callRepository,
            IOrganizationRepository organizationRepository,
            IPersonRepository personRepository,
            ISourceCodeRepository sourceCodeRepository,
            IEnumRepository enumRepository,
            ILogEventRepository logEventRepository,
            IMainRepositoryStatusProvider mainRepositoryStatusProvider,
            INotificationService notificationService,
            ILogger<PendingReferralsProcessorApp> logger)
        {
            this.tempReferralRepository = Check.NotNull(tempReferralRepository, nameof(tempReferralRepository));
            this.mainReferralRepository = Check.NotNull(mainReferralRepository, nameof(mainReferralRepository));
            this.mainRepositoryStatusProvider = Check.NotNull(mainRepositoryStatusProvider, nameof(mainRepositoryStatusProvider)); ;
            this.notificationService = Check.NotNull(notificationService, nameof(notificationService));
            this.options = Check.NotNull(options, nameof(options)).Value;
            this.organizationRepository = Check.NotNull(organizationRepository, nameof(organizationRepository));
            this.logEventRepository = Check.NotNull(logEventRepository, nameof(logEventRepository));
            this.logger = Check.NotNull(logger, nameof(logger));
            this.personRepository = Check.NotNull(personRepository, nameof(personRepository));
            this.sourceCodeRepository = Check.NotNull(sourceCodeRepository, nameof(sourceCodeRepository));
            this.enumRepository = Check.NotNull(enumRepository, nameof(enumRepository));
            this.callRepository = Check.NotNull(callRepository, nameof(callRepository));

            personLookupService = new(personRepository);
            logEventPublishingService = new(logEventRepository, personLookupService);
        }

        public async Task ProcessAsync(CancellationToken cancellationToken)
        {
            var repositoryStatus = mainRepositoryStatusProvider.GetRepositoryStatus();

            if (repositoryStatus.Availability != RepositoryAvailability.Available)
            {
                return;
            }

            var pendingReferrals = tempReferralRepository.GetPendingReferralUploads();

            await foreach (var referralUpload in pendingReferrals.WithCancellation(cancellationToken))
            {
                try
                {
                    var referral = referralUpload.Referral;

                    await ProcessReferralAsync(referralUpload.Referral, cancellationToken);

                    referralUpload.ProcessingStatus = ReferralProcessingStatus.Success();
                }
                catch (Exception ex)
                {
                    string errorMessage = ex.Message;

                    if (ex is ReferralProcessingException)
                    {
                        logger.LogReferralProcessingError(referralUpload, ex);
                    }
                    else
                    {
                        // We're not publishing error message for unexpected errors.
                        // User won't be able to understand it and fix it. We rely on logging
                        // in such cases.
                        errorMessage = "System error";

                        logger.LogUnexpectedReferralRepositoryError(referralUpload, ex);
                    }

                    referralUpload.ProcessingStatus = ReferralProcessingStatus.Failure(errorMessage);
                }

                await tempReferralRepository.SaveChangesAsync();

                var notification = notificationBuilder.BuildNotificationMessage(referralUpload);

                await notificationService.SendAsync(notification);
            }
        }


        private async Task ProcessReferralAsync(
            Domain.Temporary.Referral referral,
            CancellationToken cancellationToken)
        {
            if (referral.IsUpdate)
            {
                await ProcessReferralUpdateAsync(referral, logEventPublishingService, cancellationToken);
            }
            else
            {
                await ProcessNewReferralAsync(referral, logEventPublishingService, cancellationToken);
            }
        }

        private async Task ProcessReferralUpdateAsync(
            Domain.Temporary.Referral tempReferral,
            LogEventPublishingService logEventPublishingService,
            CancellationToken cancellationToken)
        {
            // Referral number is actually a call ID.
            tempReferral.CallId = tempReferral.ReferralNumer;

            var referralExtraInfo = await BuildReferralExtraInfo(tempReferral, cancellationToken);

            await logEventPublishingService.AddReferralUpdateLogEvent(
                tempReferral,
                referralExtraInfo,
                cancellationToken);

            await logEventPublishingService.AddPagingInformationEvent(
                tempReferral,
                referralExtraInfo,
                cancellationToken);
        }

        private async Task ProcessNewReferralAsync(
            Domain.Temporary.Referral tempReferral,
            LogEventPublishingService logEventPublishingService,
            CancellationToken cancellationToken)
        {
            var referralExtraInfo = await BuildReferralExtraInfo(tempReferral, cancellationToken);

            await CheckForDuplicates(tempReferral, referralExtraInfo, cancellationToken);

            var call = await CreateNewCallAsync(tempReferral, referralExtraInfo, cancellationToken);
            var referral = await CreateNewReferralAsync(tempReferral, referralExtraInfo, call, cancellationToken);

            tempReferral.Id = referral.Id;
            tempReferral.CallId = call.Id;

            await logEventPublishingService.AddReferralCreateLogEvent(
                tempReferral,
                referralExtraInfo,
                cancellationToken);

            await logEventPublishingService.AddPagingInformationEvent(
                tempReferral,
                referralExtraInfo,
                cancellationToken);
        }

        private async Task<Domain.Main.Referrals.Referral> CreateNewReferralAsync(
            Domain.Temporary.Referral tempReferral, 
            ReferralExtraInfo referralExtraInfo, 
            Call call, 
            CancellationToken cancellationToken)
        {
            var mainReferral = tempReferral.ToMainReferral(referralExtraInfo);

            mainReferral.LastStatEmployeeId = call.SaveLastById;
            mainReferral.CallId = call.Id;

            mainReferral.QaReviewComplete = 0;
            mainReferral.ApproachTypeId = 7; // Unknown ID.

            await mainReferralRepository.AddReferralAsync(mainReferral, cancellationToken);

            return mainReferral;
        }

        private async Task<Call> CreateNewCallAsync(Domain.Temporary.Referral tempReferral, ReferralExtraInfo referralExtraInfo, CancellationToken cancellationToken)
        {
            var call = CreateCall(tempReferral, referralExtraInfo);

            var defaultEmployee = await personLookupService.GetDefaultEmployeeAsync(cancellationToken);

            call.SaveLastById = defaultEmployee?.Id;

            await callRepository.AddCallAsync(call, cancellationToken);

            return call;
        }

        private static Call CreateCall(Domain.Temporary.Referral tempReferral, ReferralExtraInfo referralExtraInfo)
        {
            return new Call
            {
                Type = CallType.Referral,
                DateTime = tempReferral.CallReceivedOn,
                StatEmployeeId = (short)referralExtraInfo.CoordinatorEmployee.Id,
                TotalTime = TimeSpan.Zero,
                Seconds = 0,
                Temp = -1,
                SourceCodeId = referralExtraInfo.CallerSourceCodeId,
                OpenById = -1,
                TempExclusive = -1,
                RecycleNcFlag = -1,
                Active = -1,
            };
        }

        private async Task<ReferralExtraInfo> BuildReferralExtraInfo(Domain.Temporary.Referral referral, CancellationToken cancellationToken)
        {
            // TODO: I'd prefer to have null and a check.
            // it will be -1 if not found.
            var callerSourceCodeId = await sourceCodeRepository.FindSourceCodeIdByNameAsync(
                referral.CallerSourceCode,
                cancellationToken).ConfigureAwait(false);

            var coordinatorEmployee =
                await personLookupService.GetEmployeeOrDefaultEmployeeAsync(
                    referral.CoordinatorName,
                    cancellationToken);

            var hospitalFacility = await GetHospitalFacilityOrganizationAsync(
                referral.CallerInformation.PhoneNumber,
                cancellationToken);

            int callerPhoneId = await GetCallerPhoneIdAsync(
                hospitalFacility.Id,
                referral.CallerInformation.PhoneNumber,
                cancellationToken);

            int? callerPersonId = await personLookupService.FindPersonAsync(
                referral.CallerInformation.CallerName,
                hospitalFacility.Id,
                cancellationToken);

            var subLocation = await GetHospitalFacilitySubLocationAsync(
                hospitalFacility.Id,
                referral.CallerInformation.PhoneNumber,
                cancellationToken);

            var causeOfDeathId = await GetCauseOfDeathIdFromNameAsync(
                referral.CauseOfDeath,
                cancellationToken);

            var raceId = await GetRaceIdFromNameAsync(
                referral.DonorPerson.Race,
                cancellationToken);

            var referralExtraInfo = new ReferralExtraInfo(
                callerSourceCodeId,
                callerPersonId,
                callerPhoneId,
                coordinatorEmployee,
                hospitalFacility.Id,
                hospitalFacility.Name,
                ReferralFacilityUnitId: subLocation?.Id,
                ReferralFacilityFloor: subLocation?.Level,
                causeOfDeathId,
                raceId);

            return referralExtraInfo;
        }

        private async Task<SubLocation?> GetHospitalFacilitySubLocationAsync(
            int organizationId,
            PhoneNumber phoneNumber,
            CancellationToken cancellationToken)
        {
            var subLocations = await organizationRepository.GetFilteredOrganizationSubLocationsAsync(
                organizationId,
                new SubLocationFilterCriteria(phoneNumber.ToString()),
                cancellationToken);

            return subLocations.Count switch
            {
                1 => subLocations.First(),
                _ => null
            };
        }

        private async Task<Organization> GetHospitalFacilityOrganizationAsync(
            PhoneNumber phoneNumber,
            CancellationToken cancellationToken)
        {
            var organizations = await organizationRepository.GetFilteredOrganizationsAsync(
                               new OrganizationFilterCriteria(phoneNumber.ToString()),
                               cancellationToken);

            return organizations.Count switch
            {
                0 => throw new ReferralProcessingException($"Phone number '{phoneNumber}' or associated hospital wasn't found."),
                > 1 => throw new ReferralProcessingException($"Phone number '{phoneNumber}' is associated with more than one facility."),
                _ => organizations.First()
            };
        }

        private async Task<int> GetCallerPhoneIdAsync(
            int organizationId,
            PhoneNumber phoneNumber,
            CancellationToken cancellationToken)
        {
            var phoneIds = await organizationRepository.GetFilteredPhoneIds(
                organizationId,
                new PhoneFilterCriteria(phoneNumber.ToString()),
                cancellationToken);

            return phoneIds.Count switch
            {
                0 => throw new ReferralProcessingException($"Phone number '{phoneNumber}' wasn't found."),

                // I don't think duplicate phones are really possible for same organization.
                _ => phoneIds.First()
            };
        }

        private async Task<int?> GetRaceIdFromNameAsync(
            string? race,
            CancellationToken cancellationToken)
        {
            if (race is null)
            {
                return null;
            }

            // TODO: Consider adding caching decorator for this call
            // as races list changes rarely.
            // Alternatively we can consider doing search by name of race,
            // but that will not save us a lot.
            var races = await enumRepository.GetAllRacesAsync(cancellationToken);

            var raceId = races.FirstOrDefault(r =>
                race.Equals(r.Name, StringComparison.InvariantCultureIgnoreCase))?.Id;

            if (raceId is null)
            {
                throw new ReferralProcessingException($"Can't find race '{race}' among allowed values.");
            }

            return raceId;
        }

        private async Task<int?> GetCauseOfDeathIdFromNameAsync(
            string? causeOfDeath,
            CancellationToken cancellationToken)
        {
            if (causeOfDeath is null)
            {
                return null;
            }

            // TODO: Consider adding caching decorator for this call
            // as causes of death list changes rarely.
            // Alternatively we can consider doing search by name of COD,
            // but that will not save us a lot.
            var causesOfDeath = await enumRepository.GetAllCausesOfDeathAsync(cancellationToken);

            var causeOfDeathId = causesOfDeath.FirstOrDefault(ev =>
                causeOfDeath.Equals(ev.Name, StringComparison.InvariantCultureIgnoreCase))?.Id;

            if (causeOfDeathId is null)
            {
                throw new ReferralProcessingException($"Can't find cause of death '{causeOfDeath}' among allowed values.");
            }

            return causeOfDeathId;
        }

        private async Task CheckForDuplicates(
            Domain.Temporary.Referral referral,
            ReferralExtraInfo referralExtraInfo,
            CancellationToken cancellationToken)
        {
            var referralIds = await mainReferralRepository.GetDuplicateReferralIdsAsync(
                new DuplicateReferralsFilterCriteria(
                    sourceCodeId: referralExtraInfo.CallerSourceCodeId,
                    medicalRecordNumber: referral.DonorPerson.MedicalRecordNumber,
                    referralCallerOrganizationId: referralExtraInfo.OrganizationId),
                cancellationToken).ConfigureAwait(false);

            if (referralIds.Count > 0)
            {
                throw new ReferralProcessingException("Duplicate referral");
            }
        }
    }
}
