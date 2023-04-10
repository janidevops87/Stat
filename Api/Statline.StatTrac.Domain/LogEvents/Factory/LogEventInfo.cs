using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.LogEvents.Factory;

public class LogEventInfo
{
    public int CallId { get; }
    public LogEventTypeId Type { get; }
    public bool CallbackPending { get; }
    public PersonName? FromToPersonName { get; }
    public OrganizationId OrganizationId { get; }
    public string? Description { get; }

    public LogEventInfo(
        int callId,
        LogEventTypeId type,
        bool callbackPending,
        PersonName? fromToPersonName,
        OrganizationId organizationId,
        string? description)
    {
        CallId = Check.Bigger(callId, 0);
        Type = type;
        CallbackPending = callbackPending;
        FromToPersonName = fromToPersonName;
        OrganizationId = organizationId;
        Description = description;
    }
}
