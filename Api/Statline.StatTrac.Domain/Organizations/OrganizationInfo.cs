namespace Statline.StatTrac.Domain.Organizations;

public class OrganizationInfo
{
    public OrganizationInfo(int id, string? name)
    {
        Id = id;
        Name = name;
    }

    public int Id { get; }
    public string? Name { get; }
}
