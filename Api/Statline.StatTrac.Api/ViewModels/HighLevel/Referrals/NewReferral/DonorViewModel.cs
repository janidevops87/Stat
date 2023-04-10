using Statline.StatTrac.Api.ViewModels.HighLevel.Common;
using Statline.StatTrac.Domain.Referrals;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public class DonorViewModel
{
    public DonorPersonViewModel DonorPerson { get; init; } = default!;

    [MaxLength(30)]
    public string? MedicalRecordNumber { get; init; }

    [Range(typeof(DateTimeOffset), ValueLimits.MinSmallDateTimeFormatted, ValueLimits.MaxSmallDateTimeFormatted, ErrorMessage = ValidationMessages.DateTimeOutOfRange)]
    public DateTimeOffset? CardiacTimeOfDeath { get; init; }
    
    [Range(typeof(DateTimeOffset), ValueLimits.MinSmallDateTimeFormatted, ValueLimits.MaxSmallDateTimeFormatted, ErrorMessage = ValidationMessages.DateTimeOutOfRange)]
    public DateTimeOffset? AdmittedOn { get; init; }

    [Range(1, int.MaxValue)]
    public int? CauseOfDeathId { get; init; }

    [MaxLength(950)]
    public string? MedicalHistory { get; init; }

    [Range(typeof(DateTimeOffset), ValueLimits.MinDateTimeFormatted, ValueLimits.MaxDateTimeFormatted, ErrorMessage = ValidationMessages.DateTimeOutOfRange)]
    public DateTimeOffset? ExtubationAt { get; init; }

    public HeartbeatType Heartbeat { get; init; }
    public VentilatorType Ventilator { get; init; }
    public DonorHighRiskViewModel HighRisk { get; init; } = default!;
}
