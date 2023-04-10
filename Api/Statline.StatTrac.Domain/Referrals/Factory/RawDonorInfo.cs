namespace Statline.StatTrac.Domain.Referrals.Factory;

public class RawDonorInfo
{
    public RawDonorPersonInfo DonorPerson { get; }
    public string? MedicalRecordNumber { get; }
    public DateTimeOffset? CardiacTimeOfDeath { get; }
    public DateTimeOffset? AdmittedOn { get; }
    public int? CauseOfDeathId { get; }
    public string? MedicalHistory { get; }
    public DateTimeOffset? ExtubationAt { get; }
    public HeartbeatType Heartbeat { get; }
    public VentilatorType Ventilator { get; }
    public DonorHighRiskInfo HighRisk { get; }

    public RawDonorInfo(
        RawDonorPersonInfo donorPerson,
        DateTimeOffset? cardiacTimeOfDeath,
        DateTimeOffset? admittedOn,
        int? causeOfDeathId,
        string? medicalHistory,
        DateTimeOffset? extubationAt,
        HeartbeatType heartbeat,
        VentilatorType ventilator,
        string? medicalRecordNumber,
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
