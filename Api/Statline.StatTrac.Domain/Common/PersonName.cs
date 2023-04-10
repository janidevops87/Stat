namespace Statline.StatTrac.Domain.Common;

public record PersonName
{
    private static readonly PersonNameValidator Validator = new();

    public string? FirstName { get; private set; }
    public string? LastName { get; private set; }

    public PersonName(string? firstName, string? lastName)
    {
        Validator.Validate(firstName, lastName);

        FirstName = firstName;
        LastName = lastName;
    }

    public override string ToString()
    {
        if (FirstName is null)
        {
            return LastName!;
        }

        if (LastName is null)
        {
            return FirstName!;
        }

        return $"{FirstName} {LastName}";
    }
}
