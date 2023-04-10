using Statline.StatTrac.Domain.Referrals;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Referrals;

public class DuplicateReferralsFilterCriteriaViewModel : IValidatableObject
{
    public DuplicateReferralsFilterType FilterType { get; set; }

    public string? ReferralDonorLastName { get; set; }
    public int? SourceCodeId { get; set; }
    public string? TimeZone { get; set; }
    public string? MedicalRecordNumber { get; set; }
    public int? CallCoordinatorOrganizationId { get; set; }
    public int? ReferralCallerOrganizationId { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (FilterType == DuplicateReferralsFilterType.LastNameOrMedicalRecordNumber)
        {
            if (ReferralDonorLastName is null &&
                SourceCodeId is null &&
                TimeZone is null &&
                MedicalRecordNumber is null &&
                CallCoordinatorOrganizationId is null &&
                ReferralCallerOrganizationId is null)
            {
                yield return new ValidationResult(
                    $"At least some filter criteria must be provided.",
                    new[]
                    {
                        nameof(ReferralDonorLastName),
                        nameof(SourceCodeId),
                        nameof(TimeZone),
                        nameof(MedicalRecordNumber),
                        nameof(CallCoordinatorOrganizationId),
                        nameof(ReferralCallerOrganizationId),
                    });
            }
        }
        else if (FilterType == DuplicateReferralsFilterType.MedicalRecordNumber)
        {
            if (SourceCodeId is null &&
                MedicalRecordNumber is null &&
                ReferralCallerOrganizationId is null)
            {
                yield return new ValidationResult(
                    $"At least some filter criteria must be provided.",
                    new[]
                    {
                        nameof(SourceCodeId),
                        nameof(MedicalRecordNumber),
                        nameof(ReferralCallerOrganizationId),
                    });
            }
        }
        else
        {
            yield return new ValidationResult(
                $"Unknown filter type.",
                new[] { nameof(FilterType) });
        }
    }
}