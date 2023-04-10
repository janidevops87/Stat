using Statline.StatTrac.Api.Client.Dto.Referrals.Common;

namespace Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

public class DonorHighRisk
{
    public DonorHighRiskValue Hiv { get; }
    public DonorHighRiskValue HepB { get; }
    public DonorHighRiskValue HepC { get; }

    public DonorHighRisk(
        DonorHighRiskValue hiv,
        DonorHighRiskValue hepB,
        DonorHighRiskValue hepC)
    {
        Hiv = hiv;
        HepB = hepB;
        HepC = hepC;
    }
}
