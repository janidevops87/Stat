using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Referrals;

public enum ReferralType
{
    Unassigned = DefaultValues.MinusOne,
    OrganTissueEye = 1,
    TissueEye = 2,
    EyesOnly = 3,
    Ruleout = 4,
    OrganTissue = 5,
    OrganEye = 6,
    Organ = 7,
    Tissue = 8
}
