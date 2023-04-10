using Statline.StatTrac.Api.Client.Dto.Referrals.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Integration.Api.ViewModels.Copernicus;

// NOTE: Most value-type fields are nullable here even when
// they are not allowed to be null. Instead, they are
// marked with [Required] attribute. That is because
// a view model deserialized via a formatter (e.g. for POST requests)
// is validated AFTER all values are assigned by the formatter.
// Formatter creates a new instance of the view model, and all
// non-nullable value-type fields of the VM get default values.
// after that, default values are indistinguishable from explicitly
// assigned values, so model validation thinks that such a property
// does have value and all is OK. When value-typed field is nullable,
// its default (unassigned) value is null, and can be "caught"
// by [Required] attribute.
public class NewReferralViewModel : IValidatableObject
{
    [MinLength(1)]
	public string Sourcecode { get; set; } = default!;

	[MaxLength(50)]
	public string ContactFirstName { get; set; } = default!;

	[MaxLength(50)]
	[MinLength(1)]
	public string ContactLastName { get; set; } = default!;

	[MaxLength(10)]
	[MinLength(1)]
	public string CallbackPhoneNumber { get; set; } = default!;

	[MaxLength(5)]
	[MinLength(1)]
	public string? CallbackPhoneNumberExtension { get; set; }
	public DateTimeOffset? CardiacDeathDateTime { get; set; }

	[Required]
	public HeartbeatType? HeartbeatId { get; set; }

	[Required]
	public VentilatorType? VentilatorId { get; set; }

	[Range(1, int.MaxValue)]
	public int ReferralFacility { get; set; }

	[StringLength(maximumLength: 50, MinimumLength = 1)]
	public string? HospitalUnitId { get; set; }

	[MaxLength(30)]
	public string? MedicalRecordNumber { get; set; }

	[MaxLength(40)]
	[MinLength(1)]
	public string? LegalFirstName { get; set; }

	[MaxLength(40)]
	[MinLength(1)]
	public string? LegalLastName { get; set; }

	public DateTimeOffset? AdmitDateTime { get; set; }

    [Required]	
	public DateOnly? Dob { get; set; }

	[Range(minimum: 1, int.MaxValue, ErrorMessage = "Age must be positive value.")]
	public int? Age { get; set; }

	public AgeUnit? AgeUnitId { get; set; }

	[Range(1, int.MaxValue)]
	public int RaceId { get; set; }

    [Required]
	public App.Copernicus.PersonGender? SexId { get; set; }

	[Range(double.Epsilon, double.MaxValue, ErrorMessage = "Weight must be positive value.")]
	public float? Weight { get; set; }
	public App.Copernicus.WeightUnit? WeightUnitId { get; set; }
	public DateTimeOffset? ExtubationDateTime { get; set; }
	
	[MaxLength(950)]
	public string? MedicalHistory { get; set; }

	public App.Copernicus.DonorHighRiskValue? Hiv { get; set; }
	public App.Copernicus.DonorHighRiskValue? HepB { get; set; }
	public App.Copernicus.DonorHighRiskValue? HepC { get; set; }

	[Range(1, int.MaxValue)]
	public int CauseOfDeathId { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
		if (LegalFirstName is null && LegalLastName is null)
		{
			yield return new ValidationResult(
				"At least legal first or last name must be provided.",
				new[] { nameof(LegalFirstName), nameof(LegalLastName) });
		}

		if (Age is not null && AgeUnitId is null)
		{
			yield return new ValidationResult(
				"Age Unit is not specified while Age is specified.",
				new[] { nameof(AgeUnitId) });
		}

		if (Weight is not null && WeightUnitId is null)
		{
			yield return new ValidationResult(
				"Weight Unit is not specified while Weight is specified.",
				new[] { nameof(WeightUnitId) });
		}
	}
}
