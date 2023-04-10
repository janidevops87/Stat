namespace Statline.StatTrac.Domain.Referrals.Factory;

public class ReferralCriteria
{
    public AppropriateType? OrganAppropriateId { get; init; }
    public AppropriateType? BoneAppropriateId { get; init; }
    public AppropriateType? SoftTissueAppropriateId { get; init; }
    public AppropriateType? SkinAppropriateId { get; init; }
    public AppropriateType? ValvesAppropriateId { get; init; }
    public AppropriateType? EyesAppropriateId { get; init; }
    public AppropriateType? OtherAppropriateId { get; init; }
    public ReferralType? PreviousReferralTypeId { get; init; }
    public ReferralType? CurrentReferralTypeId { get; init; }
}