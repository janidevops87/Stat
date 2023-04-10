namespace Statline.StatTrac.Domain.Calls;

/// <dev>
/// This entity resembles corresponding DB table. 
/// </dev>
public sealed class CallType
{
    public int CallTypeId { get; set; }
    public string? CallTypeName { get; set; }
    public short? Inactive { get; set; }
    public short? Verified { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public short? UpdatedFlag { get; set; }
}
