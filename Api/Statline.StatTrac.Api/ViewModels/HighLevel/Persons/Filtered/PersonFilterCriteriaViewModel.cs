using Statline.StatTrac.Domain.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Persons.Filtered;

public class PersonFilterCriteriaViewModel : IValidatableObject
{
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public ActiveStateFilter ActiveState { get; set; } = ActiveStateFilter.ActiveAndInactive;

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
