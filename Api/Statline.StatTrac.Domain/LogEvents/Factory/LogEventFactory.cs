using Statline.Common.Services;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Domain.LogEvents.Factory;

public class LogEventFactory
{
    private record CallInfo(int CallId, int? StatEmployeeId);

    private readonly IPersonRepository personRepository;
    private readonly ICallRepository callRepository;
    private readonly IOrganizationRepository organizationRepository;
    private readonly IReferralRepository referralRepository;
    private readonly IDateTimeService dateTimeService;

    public LogEventFactory(
        IPersonRepository personRepository,
        ICallRepository callRepository,
        IOrganizationRepository organizationRepository,
        IReferralRepository referralRepository,
        IDateTimeService dateTimeService)
    {
        this.personRepository = Check.NotNull(personRepository);
        this.callRepository = Check.NotNull(callRepository);
        this.organizationRepository = Check.NotNull(organizationRepository);
        this.referralRepository = Check.NotNull(referralRepository);
        this.dateTimeService = Check.NotNull(dateTimeService);
    }

    public LogEvent CreateWithDefaultValues()
    {
        // Some of properties of log event are expected to have
        // default non-null values when values are not provided.
        // So unless client explicitly assigns such property with null
        // it will have default value.
        return new LogEvent
        {
            LogEventCallbackPending = IntegerBoolean.ZeroFalse,
            LogEventDeleted = false,
            LogEventContactConfirmed = DefaultValues.Zero,
            ScheduleGroupId = DefaultValues.MinusOne,
            PhoneId = DefaultValues.MinusOne
        };
    }

    public async Task<LogEvent> CreateFromLogEventInfoAsync(
        LogEventInfo logEventInfo,
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(logEventInfo);
        Check.Bigger(onBehalfOfEmployeeId, 0);

        await personRepository.ValidateEmployeeIdAsync(onBehalfOfEmployeeId);

        var rawLogEventInfo = await BuildRawLogEventInfoAsync(logEventInfo);

        return CreateFromRawLogEventInfo(
            rawLogEventInfo,
            onBehalfOfEmployeeId);
    }

    public async Task<LogEvent> CreateFromReferralLogEventInfoAsync(
        ReferralId referralId,
        ReferralLogEventInfo logEventInfo,
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(referralId);
        Check.NotNull(logEventInfo);
        Check.Bigger(onBehalfOfEmployeeId, 0);

        await personRepository.ValidateEmployeeIdAsync(onBehalfOfEmployeeId);

        var rawLogEventInfo = await BuildRawLogEventInfo(referralId, logEventInfo, onBehalfOfEmployeeId);

        return CreateFromRawLogEventInfo(
            rawLogEventInfo,
            onBehalfOfEmployeeId);
    }

    public LogEvent CreateFromRawLogEventInfo(
       RawLogEventInfo logEventInfo,
       int onBehalfOfEmployeeId)
    {
        Check.NotNull(logEventInfo);
        Check.Bigger(onBehalfOfEmployeeId, 0);

        var logEvent = CreateWithDefaultValues();
        
        // NOTE: LogEventNumber and LastModified
        // are assigned automatically by the
        // repository.
        #pragma warning disable format
        logEvent.CallId                     = logEventInfo.CallId;
        logEvent.LogEventTypeId             = logEventInfo.Type;
        logEvent.LogEventCallbackPending    = logEventInfo.CallbackPending ? IntegerBoolean.MinusOneTrue : IntegerBoolean.ZeroFalse;
        logEvent.LogEventName               = logEventInfo.FromToPersonName?.ToString();
        logEvent.PersonId                   = logEventInfo.FromToPersonId;
        logEvent.OrganizationId             = logEventInfo.OrganizationId;
        logEvent.LogEventOrg                = logEventInfo.OrganizationName;
        logEvent.LogEventDesc               = logEventInfo.Description;
        logEvent.StatEmployeeId             = logEventInfo.StatEmployeeId;
        logEvent.LastStatEmployeeId         = onBehalfOfEmployeeId;
        // NOTE: For some log events StatTrac uses Call's date/time,
        // and for some - current date/time. For now, here we use
        // current date/time for all events. This can be changed in future.
        logEvent.LogEventDateTime           = dateTimeService.GetCurrent();
        #pragma warning restore format

        return logEvent;
    }

    private async Task<RawLogEventInfo> BuildRawLogEventInfoAsync(
        LogEventInfo logEventInfo)
    {
        var organizationName = await GetOrganizationName(logEventInfo.OrganizationId);

        var callInfo = await GetCallById(logEventInfo.CallId);

        PersonId? fromToPersonId = null;

        if (logEventInfo.FromToPersonName is not null)
        {
            fromToPersonId = await personRepository.FindPersonIdByNameAsync(
              logEventInfo.FromToPersonName,
              logEventInfo.OrganizationId);
        }

        var rawLogEventInfo = new RawLogEventInfo(
            logEventInfo.CallId,
            logEventInfo.Type,
            logEventInfo.CallbackPending,
            logEventInfo.FromToPersonName,
            fromToPersonId,
            logEventInfo.OrganizationId,
            organizationName,
            logEventInfo.Description,
            statEmployeeId: callInfo.StatEmployeeId);

        return rawLogEventInfo;
    }

    private async Task<RawLogEventInfo> BuildRawLogEventInfo(
        ReferralId referralId,
        ReferralLogEventInfo logEventInfo,
        int onBehalfOfEmployeeId)
    {
        var referralInfo = await referralRepository.GetReferralByIdAsync(
            referralId,
            r => new
            {
                CallId = r.CallId!.Value,
                OrganizationId = new OrganizationId(r.ReferralCallerOrganizationId!.Value)
            });

        var organizationId = logEventInfo.OrganizationId ?? referralInfo.OrganizationId;

        var organizationName = await GetOrganizationName(organizationId);

        PersonId? fromToPersonId = null;

        if (logEventInfo.FromToPersonName is not null)
        {
            fromToPersonId = await personRepository.FindPersonIdByNameAsync(
              logEventInfo.FromToPersonName,
              organizationId);
        }

        var factoryLogEventInfo = new RawLogEventInfo(
            callId: referralInfo.CallId,
            type: logEventInfo.Type,
            callbackPending: logEventInfo.CallbackPending,
            fromToPersonName: logEventInfo.FromToPersonName,
            fromToPersonId: fromToPersonId,
            organizationId: organizationId,
            organizationName: organizationName,
            description: logEventInfo.Description,
            statEmployeeId: onBehalfOfEmployeeId);

        return factoryLogEventInfo;
    }

    private async Task<CallInfo> GetCallById(int callId)
    {
        var callInfo = await callRepository.FindCallAsync(
            callId,
            call => new CallInfo(call.CallId, call.StatEmployeeId));

        if (callInfo is null)
        {
            throw new InvalidInputDataException(
                $"Can't find call with id='{callId}'");
        }

        return callInfo;
    }

    private async Task<string> GetOrganizationName(OrganizationId organizationId)
    {
        // Not using GetOrganizationByIdAsync because it throws different exception.
        var organizationName = await organizationRepository.FindOrganizationByIdAsync(
            organizationId,
            org => org.OrganizationName!);

        return organizationName ?? throw new InvalidInputDataException(
                $"Organization with id '{organizationId}' doesn't exist");
    }
}
