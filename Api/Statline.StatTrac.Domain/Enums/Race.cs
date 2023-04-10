namespace Statline.StatTrac.Domain.Enums;

public class Race
{
    internal Race() { }

    public int RaceId { get; private set; }
    public string? RaceName { get; private set; }
    public short? Verified { get; private set; }
    public short? Inactive { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public short? UpdatedFlag { get; private set; }
    public int? LastStatEmployeeId { get; private set; }
    public int? AuditLogTypeId { get; private set; }
}
