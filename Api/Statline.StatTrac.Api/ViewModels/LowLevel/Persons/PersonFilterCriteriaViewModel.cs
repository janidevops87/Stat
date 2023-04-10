using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Persons;

public class PersonFilterCriteriaViewModel : IValidatableObject
{
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public int? OrganizationId { get; set; }
    public bool? Inactive { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (FirstName is null && LastName is null)
        {
            yield return new ValidationResult(
                $"At least {nameof(FirstName)} or {nameof(LastName)} " +
                $"filter criteria must be provided.",
                new[] { nameof(FirstName), nameof(LastName) });
        }

    }
}
