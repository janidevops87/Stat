using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.LogEvents.Factory;

public class ReferralLogEventInfo
{
    public LogEventTypeId Type { get; }
    public bool CallbackPending { get; }
    public PersonName? FromToPersonName { get; }
    public string? Description { get; }

    /// <remarks>
    /// If <see cref="null"/>, referral's caller organization ID is used.
    /// </remarks>
    public OrganizationId? OrganizationId { get; }

    public ReferralLogEventInfo(
        LogEventTypeId type,
        bool callbackPending,
        PersonName? fromToPersonName,
        string? description,
        OrganizationId? organizationId)
    {
        Type = type;
        CallbackPending = callbackPending;
        FromToPersonName = fromToPersonName;
        Description = description;
        OrganizationId = organizationId;
    }
}
