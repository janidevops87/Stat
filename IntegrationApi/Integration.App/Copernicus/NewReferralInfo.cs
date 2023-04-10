using Statline.StatTrac.Api.Client.Dto.Referrals.Common;

namespace Statline.StatTrac.Integration.App.Copernicus;

public class NewReferralInfo
{
	public string Sourcecode { get; set; } = default!;
	public string ContactFirstName { get; set; } = default!;
	public string ContactLastName { get; set; } = default!;
	public string CallbackPhoneNumber { get; set; } = default!;
	public string? CallbackPhoneNumberExtension { get; set; }
	public DateTimeOffset? CardiacDeathDateTime { get; set; }
	public HeartbeatType HeartbeatId { get; set; }
	public VentilatorType VentilatorId { get; set; }
	public int ReferralFacility { get; set; }
	public string? HospitalUnitId { get; set; }
	public string? MedicalRecordNumber { get; set; }
	public string? LegalFirstName { get; set; }
	public string? LegalLastName { get; set; }
	public DateTimeOffset? AdmitDateTime { get; set; }
	public DateOnly Dob { get; set; }
	public int? Age { get; set; }
	public AgeUnit? AgeUnitId { get; set; }
	public int RaceId { get; set; }
	public PersonGender SexId { get; set; }
	public float? Weight { get; set; }
	public WeightUnit? WeightUnitId { get; set; }
	public DateTimeOffset? ExtubationDateTime { get; set; }
	
	public string? MedicalHistory { get; set; }
	public App.Copernicus.DonorHighRiskValue? Hiv { get; set; }
	public App.Copernicus.DonorHighRiskValue? HepB { get; set; }
	public App.Copernicus.DonorHighRiskValue? HepC { get; set; }
	public int CauseOfDeathId { get; set; }
}
