using Statline.StatTracUploader.Domain.Common;

namespace Statline.StatTracUploader.Domain.Main.Persons
{
    public class StatEmployee
    {
        public StatEmployee(
            int id,
            int personId,
            PersonName? name,
            string? email,
            bool inactive)
        {
            Id = id;
            PersonId = personId;
            Name = name;
            Email = email;
            Inactive = inactive;
        }

        public int Id { get; }
        public int PersonId { get;  }
        public PersonName? Name { get; }
        public string? Email { get;  }
        public bool Inactive { get; }
    }
}