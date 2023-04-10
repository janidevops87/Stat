using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Referrals.Factory.Criteria;

public class CriteriaCalculatorInputData
{
    public PersonAge? DonorAge { get; }
    public PersonGender? DonorGender { get; }
    public PersonWeight? DonorWeight { get; }
    public HeartbeatType Heartbeat { get; }
    public VentilatorType Ventilator { get; }
    public DonorHighRiskInfo HighRisk { get; }

    public int OrganizationId { get; }
    public int SourceCodeId { get; }

    public CriteriaCalculatorInputData(
        PersonAge? donorAge,
        PersonGender? donorGender,
        PersonWeight? donorWeight,
        DonorHighRiskInfo highRisk,
        HeartbeatType heartbeat,
        VentilatorType ventilator,
        int organizationId,
        int sourceCodeId)
    {
        DonorAge = donorAge;
        DonorGender = donorGender;
        DonorWeight = donorWeight;
        HighRisk = Check.NotNull(highRisk);
        OrganizationId = organizationId;
        SourceCodeId = sourceCodeId;
        Heartbeat = heartbeat;
        Ventilator = ventilator;
    }
}
