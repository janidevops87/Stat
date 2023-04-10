using Statline.Common.Utilities;

namespace Statline.StatTracUploader.Domain.Common
{
    public record PersonName
    {
        public string? FirstName { get; private set; }
        public string? LastName { get; private set; }

        public PersonName(string? firstName, string? lastName)
        {
            if (lastName is null)
            {
                FirstName = Check.NotEmpty(firstName, nameof(firstName));
            }
            else
            {
                FirstName = firstName is not null ? Check.NotEmpty(firstName, nameof(firstName)) : firstName;
            }

            if (firstName is null)
            {
                LastName = Check.NotEmpty(lastName, nameof(lastName));
            }
            else
            {
                LastName = lastName is not null ? Check.NotEmpty(lastName, nameof(lastName)) : lastName;
            }
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
}
