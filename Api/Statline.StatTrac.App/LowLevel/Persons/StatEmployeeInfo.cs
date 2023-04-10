namespace Statline.StatTrac.App.LowLevel.Persons;

public class StatEmployeeInfo
{
    public StatEmployeeInfo(
        int id,
        string? firstName,
        string? lastName,
        string? email,
        int personId,
        bool inactive)
    {
        Id = id;
        FirstName = firstName;
        LastName = lastName;
        Email = email;
        PersonId = personId;
        Inactive = inactive;
    }

    public int Id { get; }
    public int PersonId { get; }
    public string? FirstName { get; }
    public string? LastName { get; }
    public string? Email { get; }
    public bool Inactive { get; }
}
