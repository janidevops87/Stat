using Statline.StatTrac.Api.Client.Dto.Common;
using Statline.StatTrac.Api.Client.Dto.LogEvents.Common;

namespace Statline.StatTrac.Api.Client.Dto.LogEvents.NewLogEvent;

public class ReferralLogEvent
{
    public LogEventType Type { get; }
    public bool CallbackPending { get; }
    public PersonName? FromToPersonName { get; }
    public string? Description { get; }

    /// <remarks>
    /// If <c>null</c>, referral's caller organization ID is used.
    /// </remarks>
    public int? OrganizationId { get; }

    public ReferralLogEvent(
        LogEventType type,
        bool callbackPending,
        PersonName? fromToPersonName,
        int? organizationId,
        string? description)
    {
        Type = type;
        CallbackPending = callbackPending;
        FromToPersonName = fromToPersonName;
        OrganizationId = organizationId is null ? null : Check.Bigger(organizationId.Value, 0);
        Description = description;
    }
}
