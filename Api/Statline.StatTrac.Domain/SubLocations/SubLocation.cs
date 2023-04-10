namespace Statline.StatTrac.Domain.SubLocations;

public class SubLocation
{
    internal SubLocation() { }

    public int SubLocationId { get; private set; }
    public string? SubLocationName { get; private set; }
    public short? Verified { get; private set; }
    public short? Inactive { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public short? UpdatedFlag { get; private set; }
}
