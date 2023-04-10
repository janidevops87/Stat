namespace Statline.StatTrac.Domain.Referrals.Factory;

public class RawReferralInfo
{
    public RawCallInfo CallInformation { get; }
    public RawDonorInfo DonorInformation { get; }
    public ReferralCriteria Criteria { get; }

    public RawReferralInfo(
        RawCallInfo callInformation,
        RawDonorInfo donorInformation,
        ReferralCriteria criteria)
    {
        CallInformation = Check.NotNull(callInformation);
        DonorInformation = Check.NotNull(donorInformation);
        Criteria = Check.NotNull(criteria);
    }
}
