using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;

public class DonorHighRiskInfo
{
    public DonorHighRiskValue Hiv { get; }
    public DonorHighRiskValue HepB { get; }
    public DonorHighRiskValue HepC { get; }

    public DonorHighRiskInfo(
        DonorHighRiskValue hiv,
        DonorHighRiskValue hepB,
        DonorHighRiskValue hepC)
    {
        Hiv = hiv;
        HepB = hepB;
        HepC = hepC;
    }
}
