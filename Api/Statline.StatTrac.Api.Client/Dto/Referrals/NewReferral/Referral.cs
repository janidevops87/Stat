namespace Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

public class Referral
{
    public Call CallInformation { get; }
    public Donor DonorInformation { get; }

    public Referral(Call callInformation, Donor donorInformation)
    {
        CallInformation = Check.NotNull(callInformation);
        DonorInformation = Check.NotNull(donorInformation);
    }
}
