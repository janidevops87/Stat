namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Persons
{
    internal class StatEmployee
    {
        public StatEmployee(
            int id,
            int personId,
            string? firstName,
            string? lastName,
            string? email,
            bool inactive)
        {
            Id = id;
            PersonId = personId;
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            Inactive = inactive;
        }

        public int Id { get; }
        public int PersonId { get;  }
        public string? FirstName { get; }
        public string? LastName { get; }
        public string? Email { get;  }
        public bool Inactive { get; }
    }
}