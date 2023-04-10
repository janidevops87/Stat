namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public class ReferralViewModel
{
    public CallViewModel CallInformation { get; init; } = default!;
    public DonorViewModel DonorInformation { get; init; } = default!;
}
