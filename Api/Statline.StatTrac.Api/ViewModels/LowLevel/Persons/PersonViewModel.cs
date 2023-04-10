namespace Statline.StatTrac.Api.ViewModels.LowLevel.Persons;

public class PersonViewModel
{
    public int Id { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? Gender { get; set; }
    public string? Race { get; set; }
    public bool Inactive { get; set; }
}
