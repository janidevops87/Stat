using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;

namespace Statline.StatTrac.Domain.LogEvents.Factory;

public class RawLogEventInfo
{
    public int CallId { get; }
    public LogEventTypeId Type { get; }
    public bool CallbackPending { get; }
    public PersonName? FromToPersonName { get; }
    public PersonId? FromToPersonId { get; }
    public OrganizationId OrganizationId { get; }
    // Historically, we store organization name in LogEvent
    // in addition to OrganizationId. Currently this is redundant,
    // but needed for compatibility (e.g. I believe StatTrac
    // shows this field).
    public string OrganizationName { get; }
    public string? Description { get; }
    // TODO: Consider naming it in more meaningful way,
    // e.g. CoordinatorEmployeeId.
    public int? StatEmployeeId { get; }

    public RawLogEventInfo(
        int callId,
        LogEventTypeId type,
        bool callbackPending,
        PersonName? fromToPersonName,
        PersonId? fromToPersonId,
        OrganizationId organizationId,
        string organizationName,
        string? description,
        int? statEmployeeId)
    {
        CallId = Check.Bigger(callId, 0);
        Type = type;
        CallbackPending = callbackPending;
        FromToPersonName = fromToPersonName;
        FromToPersonId = fromToPersonId;
        OrganizationId = organizationId;
        Description = description;
        StatEmployeeId = statEmployeeId;
        OrganizationName = Check.NotEmpty(organizationName);
    }
}
