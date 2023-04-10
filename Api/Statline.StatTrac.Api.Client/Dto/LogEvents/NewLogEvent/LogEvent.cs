using Statline.StatTrac.Api.Client.Dto.Common;
using Statline.StatTrac.Api.Client.Dto.LogEvents.Common;

namespace Statline.StatTrac.Api.Client.Dto.LogEvents.NewLogEvent;

public class LogEvent
{
    public int CallId { get; }
    public LogEventType Type { get; }
    public bool CallbackPending { get; }
    public PersonName? FromToPersonName { get; }
    public int OrganizationId { get; }
    public string? Description { get; }

    public LogEvent(
        int callId,
        LogEventType type,
        bool callbackPending,
        PersonName? fromToPersonName,
        int organizationId,
        string? description)
    {
        CallId = Check.Bigger(callId, 0);
        Type = type;
        CallbackPending = callbackPending;
        FromToPersonName = fromToPersonName;
        OrganizationId = Check.Bigger(organizationId, 0);
        Description = description;
    }
}
