using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Referrals;

public enum ApproachType
{
    Unassigned = DefaultValues.MinusOne,
    NotApproached = 1,
    PreRefCoupled = 2,
    PreRefDecoupled = 3,
    PostRefCoupled = 4,
    PostRefDecoupled = 5,
    FamilyInitiated = 6,
    Unknown = 7,
    Registry = 8,
}