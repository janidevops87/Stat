using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public class DonorHighRiskViewModel
{
	public DonorHighRiskValue Hiv { get; init; } = DonorHighRiskValue.Unknown;
	public DonorHighRiskValue HepB { get; init; } = DonorHighRiskValue.Unknown;
	public DonorHighRiskValue HepC { get; init; } = DonorHighRiskValue.Unknown;
}
