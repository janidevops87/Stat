namespace Statline.StatTrac.Domain.Enums;

public class CauseOfDeath
{
    internal CauseOfDeath() { }
    public int CauseOfDeathId { get; private set; }
    public string? CauseOfDeathName { get; private set; }
    public short? CauseOfDeathOrganPotential { get; private set; }
    public short? CauseOfDeathCoronerCase { get; private set; }
    public short? Verified { get; private set; }
    public short? Inactive { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public short? UpdatedFlag { get; private set; }
}
