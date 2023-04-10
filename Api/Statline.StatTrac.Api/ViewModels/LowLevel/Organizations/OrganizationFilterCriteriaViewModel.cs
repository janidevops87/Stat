using Statline.StatTrac.Api.ViewModels.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Organizations;

public class OrganizationFilterCriteriaViewModel : IValidatableObject
{
    public PhoneNumberViewModel? PhoneNumber { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (PhoneNumber is null)
        {
            yield return new ValidationResult(
                $"At least some filter criteria must be provided.",
                new[] { nameof(PhoneNumber) });
        }
    }
}
