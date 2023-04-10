namespace Statline.StatTrac.App.LowLevel.Persons;

public class PersonInfo
{
    public PersonInfo(
        int id,
        string? firstName,
        string? lastName,
        string? gender,
        string? race,
        bool inactive)
    {
        Id = id;
        FirstName = firstName;
        LastName = lastName;
        Gender = gender;
        Race = race;
        Inactive = inactive;
    }

    public int Id { get; }
    public string? FirstName { get; }
    public string? LastName { get; }
    public string? Gender { get; }
    public string? Race { get; }
    public bool Inactive { get; }
}
