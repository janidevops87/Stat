using System.Diagnostics.CodeAnalysis;

namespace Statline.StatTrac.Domain.Common;

public sealed class PersonNameValidator
{
    public static readonly int MaxFirstNameLength = 50;
    public static readonly int MaxLastNameLength = 50;

    private const string AtLeastOneMustBeSpecified =
        "Either first name, last name, or both must be specified.";

    private const string NoEmptyStringsAllowed =
        "First/last name can't be an empty string.";

    private static readonly string FirstNameTooLong =
        $"First name length can be maximum {MaxFirstNameLength} characters.";

    private static readonly string LastNameTooLong =
        $"Last name length can be maximum {MaxLastNameLength} characters.";

    public void Validate(string? firstName, string? lastName)
    {
        if (lastName is null)
        {
            CheckNotEmpty(firstName, AtLeastOneMustBeSpecified);
            CheckLength(firstName, FirstNameTooLong, MaxFirstNameLength);
        }
        else if (firstName is not null)
        {
            CheckNotEmpty(firstName, NoEmptyStringsAllowed);
            CheckLength(firstName, FirstNameTooLong, MaxFirstNameLength);
        }

        if (firstName is null)
        {
            CheckNotEmpty(lastName, AtLeastOneMustBeSpecified);
            CheckLength(lastName, LastNameTooLong, MaxLastNameLength);
        }
        else if (lastName is not null)
        {
            CheckNotEmpty(lastName, NoEmptyStringsAllowed);
            CheckLength(lastName, LastNameTooLong, MaxLastNameLength);
        }
    }

    private void CheckLength(string str, string message, int maxLength)
    {
        if (str.Length > maxLength)
        {
            throw new InvalidInputDataException(message);
        }
    }

    private void CheckNotEmpty([NotNull] string? name, string message)
    {
        if (string.IsNullOrWhiteSpace(name))
        {
            throw new InvalidInputDataException(message);
        }
    }
}
