using Statline.StatTrac.Domain.Common;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace Statline.StatTrac.Api.ViewModels.Common;

public class PersonNameViewModel : IValidatableObject
{
    private static readonly PersonNameValidator Validator = new();

    public string? FirstName { get; set; }
    public string? LastName { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        try
        {
            Validator.Validate(FirstName, LastName);
        }
        catch (InvalidInputDataException ex)
        {
            return new[]
            {
                new ValidationResult(ex.Message)
            };
        }

        return Enumerable.Empty<ValidationResult>();
    }
}
