using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.LogEvents;
using Statline.StatTrac.Domain.LogEvents.Factory;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.HighLevel.LogEvents;

public class LogEventsHighLevelApplication
{
    private readonly ILogEventRepository logEventRepository;
    private readonly IReferralRepository referralRepository;
    private readonly IPersonRepository personRepository;
    private readonly IOrganizationRepository organizationRepository;
    private readonly LogEventFactory logEventFactory;

    public LogEventsHighLevelApplication(
        ILogEventRepository logEventRepository,
        IReferralRepository referralRepository,
        IPersonRepository personRepository,
        IOrganizationRepository organizationRepository,
        LogEventFactory logEventFactory)
    {
        this.logEventRepository = Check.NotNull(logEventRepository);
        this.referralRepository = Check.NotNull(referralRepository);
        this.personRepository = Check.NotNull(personRepository);
        this.logEventFactory = Check.NotNull(logEventFactory);
        this.organizationRepository = Check.NotNull(organizationRepository);
    }

    public async Task<int> AddReferralLogEventAsync(
       ReferralId referralId,
       ReferralLogEventInfo newLogEvent,
       int statEmployeeId)
    {
        Check.NotNull(referralId);
        Check.NotNull(newLogEvent);
        Check.Bigger(statEmployeeId, 0);

        var logEvent = await logEventFactory.CreateFromReferralLogEventInfoAsync(
            referralId,
            newLogEvent,
            statEmployeeId);

        await logEventRepository.AddLogEventAsync(logEvent);

        return logEvent.LogEventId;
    }

    public async Task<int> AddLogEventAsync(
          LogEventInfo newLogEvent,
          int statEmployeeId)
    {
        Check.NotNull(newLogEvent);
        Check.Bigger(statEmployeeId, 0);

        var logEvent = await logEventFactory.CreateFromLogEventInfoAsync(
            newLogEvent,
            statEmployeeId);

        await logEventRepository.AddLogEventAsync(logEvent);

        return logEvent.LogEventId;
    }

    // TODO: For now, we're creating e-referral events for every new
    // referral. But the need for that actually depends on which
    // application asks to create a referral.
    //
    // It would be nice if a referral contained information about it's
    // source (application). This could be used to make that decision.
    //
    // Here are some ideas:
    //
    // - Approach 1: We could probably use default user ID (StatEmployeeId)
    // for that. For e-referral event
    // in particular we could check if the user is a real user or a
    // "synthetic" user. The latter would mean we need to create an e-referral
    // event. This approach, however, implies that the user is authenticated
    // via the IdentityServer, which e.g. in case of StatTrac can be
    // problematic, as it has it's own authentication. But nothing
    // is impossible.
    //
    // - Approach 2: Check for particular well-know
    // synthetic users (e.g. "StatTrac Desktop"). We know that
    // particular app(s) always create referrals on behalf of a user,
    // so e-referral event is not needed for it.
    //
    // I would prefer Approach 1, since OAuth2.0/OIDC
    // authentication/authorization naturally integrates
    // with choosing actions depending on the
    // user operating.
    //
    // We also have Referral.IsERferralCase, which could be evolved to
    // something like ReferralSource. However, to assign it we still
    // need to detect how referral is being created, so the problem
    // above still needs to be solved.
    public async Task AddLogEventsOnNewReferralAsync(ReferralId referralId)
    {
        Check.NotNull(referralId);

        var referralInfo = await referralRepository.GetReferralByIdAsync(
            referralId,
            r => new
            {
                r.CallId,
                CallerPersonId = (PersonId?)r.ReferralCallerPersonId,
                CallerOrganizationId = (OrganizationId?)r.ReferralCallerOrganizationId,
                r.LastStatEmployeeId,
                r.CurrentReferralTypeId,
                // This computed property forces pulling all properties 
                // from DB. Think how to optimize this.
                r.IsIncomplete
            });

        (int Id, PersonName Name)? personInfo =
            referralInfo.CallerPersonId is null ?
            null :
            await GetPersonInfoAsync(referralInfo.CallerPersonId.Value);

        // We expect caller organization id to always be not null.
        OrganizationId organizationId = referralInfo.CallerOrganizationId!.Value;

        var organizationName = await GetOrganizationName(organizationId);

        var incomingEReferralLogEventInfo = new RawLogEventInfo(
            callId: referralInfo.CallId!.Value,
            type: LogEventTypeId.IncomingEReferral,
            callbackPending: false,
            fromToPersonName: personInfo?.Name,
            fromToPersonId: personInfo?.Id,
            organizationId: organizationId,
            organizationName: organizationName,
            description: "Incoming E-Referral",
            statEmployeeId: referralInfo.LastStatEmployeeId);

        var incomingEReferralLogEvent = logEventFactory.CreateFromRawLogEventInfo(
            incomingEReferralLogEventInfo,
            onBehalfOfEmployeeId: referralInfo.LastStatEmployeeId!.Value);

        await logEventRepository.AddLogEventAsync(incomingEReferralLogEvent);

        if (referralInfo.CurrentReferralTypeId != ReferralType.Ruleout ||
            referralInfo.IsIncomplete)
        {
            var pendingEReferralLogEventInfo = new RawLogEventInfo(
                callId: referralInfo.CallId!.Value,
                type: LogEventTypeId.PendingEReferral,
                callbackPending: true,
                fromToPersonName: personInfo?.Name,
                fromToPersonId: personInfo?.Id,
                organizationId: organizationId,
                organizationName: organizationName,
                description: "Pending E-Referral",
                statEmployeeId: referralInfo.LastStatEmployeeId);

            var pendingEReferralLogEvent = logEventFactory.CreateFromRawLogEventInfo(
                pendingEReferralLogEventInfo,
                onBehalfOfEmployeeId: referralInfo.LastStatEmployeeId!.Value);

            await logEventRepository.AddLogEventAsync(pendingEReferralLogEvent);
        }
    }

    private async Task<(int Id, PersonName Name)> GetPersonInfoAsync(int personId)
    {
        var personInfo = await personRepository.GetPersonByIdAsync(
            personId,
            p => new // Can't use tuples in expression
            {
                Id = p.PersonId,
                Name = new PersonName(p.PersonFirst, p.PersonLast)
            });

        return (personInfo.Id, personInfo.Name);
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
