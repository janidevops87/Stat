namespace Statline.StatTrac.Domain.SubLocations;

public class SubLocationInfo
{
    public SubLocationInfo(int id, string? name, string? level)
    {
        Id = id;
        Name = name;
        Level = level;
    }

    public int Id { get; }
    public string? Name { get; }
    public string? Level { get; }
}
