namespace Statline.StatTrac.Domain.Referrals.Factory;

public class ReferralInfo
{
    public CallInfo CallInformation { get; }
    public DonorInfo DonorInformation { get; }

    public ReferralInfo(
        CallInfo callInformation,
        DonorInfo donorInformation)
    {
        CallInformation = Check.NotNull(callInformation);
        DonorInformation = Check.NotNull(donorInformation);
    }
}
