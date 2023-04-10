#nullable disable

namespace Statline.StatTrac.Domain.Referrals;

/// <dev>
/// This a "read" model, so it looks anemic.
/// </dev>
public sealed class LogEvent
{
    internal LogEvent() { }
    public string CallNumber { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public string LogEventCreatedBy { get; private set; }
    public DateTimeOffset? LogEventDateTime { get; private set; }
    public string LogEventDesc { get; private set; }
    public int LogEventId { get; private set; }
    public string LogEventName { get; private set; }
    public string LogEventOrg { get; private set; }
    public string LogEventPhone { get; private set; }
    public int? LogEventTypeId { get; private set; }
    public string LogEventTypeName { get; private set; }
    public int? OrganizationId { get; private set; }
    public int? PersonId { get; private set; }
    public string ReferralEventAttnTo { get; private set; }
    public string ReferralEventCalloutAfter { get; private set; }
    public int? ReferralEventCalloutMin { get; private set; }
    public short? ReferralEventContactConfirm { get; private set; }
    public string ReferralEventDocName { get; private set; }
    public string ReferralEventFaxNbr { get; private set; }
    public int ReferralId { get; private set; }
}
