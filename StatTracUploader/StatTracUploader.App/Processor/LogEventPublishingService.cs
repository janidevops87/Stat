using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Main.LogEvents;
using Statline.StatTracUploader.Domain.Temporary;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.App.Processor
{
    internal class LogEventPublishingService
    {
        private static readonly CultureInfo TextFormattingCulture =
            CultureInfo.GetCultureInfo("EN-us");

        private readonly ILogEventRepository logEventRepository;
        private readonly PersonLookupService personLookupService;

        public LogEventPublishingService(
            ILogEventRepository logEventRepository,
            PersonLookupService personLookupService)
        {
            this.logEventRepository = Check.NotNull(logEventRepository, nameof(logEventRepository));
            this.personLookupService = Check.NotNull(personLookupService, nameof(personLookupService)); ;
        }

        public async Task AddReferralCreateLogEvent(
            Referral referral,
            ReferralExtraInfo referralExtraInfo,
            CancellationToken cancellationToken)
        {
            var callerPerson = await personLookupService.GetCallerPersonOrDefaultPerson(
                referral,
                referralExtraInfo,
                cancellationToken);

            var logEvent = await GetLogEventPrototypeAsync(referral, referralExtraInfo, cancellationToken);

            logEvent.Type = LogEventType.IncomingCalll;
            logEvent.FromToPersonId = callerPerson.Id;
            logEvent.FromToPersonName = callerPerson.Name?.ToString();
            logEvent.Description =
                $"Incoming Referral by StatTrac Uploader. " +
                $"Contact: {referral.CallerInformation.CallerName}, " +
                $"Phone: {referral.CallerInformation.PhoneNumber}, " +
                $"Unit: {referral.CallerInformation.Unit}, " +
                $"Triage Coordinator: {referral.CoordinatorName}, " +
                $"Referral Facility: {referral.CallerInformation.HospitalName}.";

            await logEventRepository.AddLogEventAsync(logEvent, cancellationToken);
        }

        public async Task AddReferralUpdateLogEvent(
            Referral referral,
            ReferralExtraInfo referralExtraInfo,
            CancellationToken cancellationToken)
        {
            var logEvent = await GetLogEventPrototypeAsync(referral, referralExtraInfo, cancellationToken);

            var callerPerson = await personLookupService.GetDefaultPersonAsync(cancellationToken);

            logEvent.Type = LogEventType.Note;
            logEvent.Description = FormatReferralInformation(referral);
            logEvent.FromToPersonId = callerPerson.Id;
            logEvent.FromToPersonName = callerPerson.Name?.ToString();

            await logEventRepository.AddLogEventAsync(logEvent, cancellationToken);
        }

        public async Task AddPagingInformationEvent(
            Referral referral,
            ReferralExtraInfo referralExtraInfo,
            CancellationToken cancellationToken)
        {
            if (referral.PagingInformation is null)
            {
                return;
            }

            var logEvent = await GetLogEventPrototypeAsync(referral, referralExtraInfo, cancellationToken);

            logEvent.Type = LogEventType.Note;
            logEvent.Description = FormatPagingInformation(referral.PagingInformation);

            // Yes, person is set to TC coordinator person. Although it looks weird,
            // it is what the Call Center folks wanted.
            logEvent.FromToPersonId = referralExtraInfo.CoordinatorEmployee.PersonId;
            logEvent.FromToPersonName = referralExtraInfo.CoordinatorEmployee.Name?.ToString();

            await logEventRepository.AddLogEventAsync(logEvent, cancellationToken);
        }

        private async Task<LogEvent> GetLogEventPrototypeAsync(
            Referral referral,
            ReferralExtraInfo referralExtraInfo,
            CancellationToken cancellationToken)
        {
            return new LogEvent
            {
                CallId = referral.CallId, // Though it's nullable, it should always have value.
                DateTime = referral.CallReceivedOn,
                OrganizationId = referralExtraInfo.OrganizationId,
                OrganizationName = referralExtraInfo.OrganizationName,
                StatEmployeeId = referralExtraInfo.CoordinatorEmployee.Id,
                // TODO: GetDefaultEmployeeAsync (the backing repository, to be more precise) needs caching!
                LastStatEmployeeId = (await personLookupService.GetDefaultEmployeeAsync(cancellationToken))?.Id
            };
        }

        private static string FormatReferralInformation(Referral referral)
        {
            return
                $"Is update: {BoolToString(referral.IsUpdate) }, " +
                $"Caller source code: {referral.CallerSourceCode}, " +
                $"Caller received on: {referral.CallReceivedOn.ToString("g", TextFormattingCulture)}, " +
                $"Triage Coordinator: {referral.CoordinatorName}, " +

                $"Contact: {referral.CallerInformation.CallerName}, " +
                $"Phone: {referral.CallerInformation.PhoneNumber}, " +
                $"Unit: {referral.CallerInformation.Unit}, " +
                $"Floor: {referral.CallerInformation.Floor}, " +
                $"Extension: {referral.CallerInformation.Extension}, " +
                $"Referral Facility: {referral.CallerInformation.HospitalName}, " +

                $"Heartbeat: {BoolToString(referral.Heartbeat)}, " +
                $"Vent: {referral.Vent}, " +
                $"Extubation at: {referral.ExtubationAt?.ToString("g", TextFormattingCulture)}, " +

                $"Donor name: {referral.DonorPerson.Name}, " +
                $"Donor DOB: {referral.DonorPerson.DateOfBirth?.ToString("d", TextFormattingCulture)}, " +
                $"Donor age: {referral.DonorPerson.Age}, " +
                $"Donor race: {referral.DonorPerson.Race}, " +
                $"Donor gender: {referral.DonorPerson.Gender}, " +
                $"Donor weight: {referral.DonorPerson.Weight}, " +
                $"MRN: {referral.DonorPerson.MedicalRecordNumber}, " +

                $"Declared CTOD: {referral.DeclaredCardiacTimeOfDeath}, " +
                $"Admitted on: {referral.AdmittedOn?.ToString("g", TextFormattingCulture)}, " +
                $"Cause of death: {referral.CauseOfDeath}, " +
                $"Medical history: {referral.MedicalHistory}, " +

                (referral.PagingInformation is null ? string.Empty :
                    FormatPagingInformation(referral.PagingInformation) + ", ") +

                $"Referral #: {referral.ReferralNumer?.ToString(CultureInfo.InvariantCulture)}, " +
                $"Time entered: {referral.EnteredOn?.ToString("g", TextFormattingCulture)}.";
        }

        private static string FormatPagingInformation(PagingInformation pagingInfo)
        {
            return
                $"Paged to client: {BoolToString(pagingInfo.PagedToClient)}, " +
                $"Paged to client on: {pagingInfo.PagedToClientOn?.ToString("g", TextFormattingCulture)}, " +
                $"Re-paged to client on: {pagingInfo.RePagedToClientOn?.ToString("g", TextFormattingCulture)}, " +
                $"Received by: {pagingInfo.ReceivedBy}, " +
                $"Paged by: {pagingInfo.PagedBy}, " +
                $"Referral paged to hospital: {BoolToString(pagingInfo.ReferralPagedToHospital)}";
        }

        private static string BoolToString(bool? value) =>
              value is null ? "N/A" : (value.Value ? "Y" : "N");
    }
}
