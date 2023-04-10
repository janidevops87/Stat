namespace Statline.StatTrac.Api.ViewModels.LowLevel.Persons;

public class StatEmployeeViewModel
{
    public int Id { get; set; }
    public int PersonId { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? Email { get; set; }
    public bool Inactive { get; set; }
}
