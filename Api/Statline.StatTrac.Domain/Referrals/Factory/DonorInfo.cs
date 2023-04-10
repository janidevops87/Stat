namespace Statline.StatTrac.Domain.Referrals.Factory;

public class DonorInfo
{
    public DonorPersonInfo DonorPerson { get; }
    public string? MedicalRecordNumber { get; }
    public DateTimeOffset? CardiacTimeOfDeath { get; }
    public DateTimeOffset? AdmittedOn { get; }
    public int? CauseOfDeathId { get; }
    public string? MedicalHistory { get; }
    public DateTimeOffset? ExtubationAt { get; }
    public HeartbeatType Heartbeat { get; }
    public VentilatorType Ventilator { get; }
    public DonorHighRiskInfo HighRisk { get; }

    public DonorInfo(
        DonorPersonInfo donorPerson,
        string? medicalRecordNumber,
        DateTimeOffset? cardiacTimeOfDeath,
        DateTimeOffset? admittedOn,
        int? causeOfDeathId,
        string? medicalHistory,
        DateTimeOffset? extubationAt,
        HeartbeatType heartbeat,
        VentilatorType ventilator,
        DonorHighRiskInfo highRisk)
    {
        DonorPerson = Check.NotNull(donorPerson);
        MedicalRecordNumber = medicalRecordNumber;
        CardiacTimeOfDeath = cardiacTimeOfDeath;
        AdmittedOn = admittedOn;
        CauseOfDeathId = causeOfDeathId;
        MedicalHistory = medicalHistory;
        ExtubationAt = extubationAt;
        Heartbeat = heartbeat;
        Ventilator = ventilator;
        HighRisk = Check.NotNull(highRisk);
    }
}
