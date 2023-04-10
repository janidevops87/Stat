using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Phones;

public class Phone
{
    internal Phone() { }

    public PhoneId PhoneId { get; set; }
    public string? PhoneAreaCode { get; set; }
    public string? PhonePrefix { get; set; }
    public string? PhoneNumber { get; set; }
    public string? PhonePin { get; set; }
    public PhoneTypeId? PhoneTypeId { get; set; }
    public IntegerBoolean? Verified { get; set; }
    public IntegerBoolean? Inactive { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public string? Unused { get; set; }
    public short? UpdatedFlag { get; set; }
    public int? LastStatEmployeeId { get; set; }
    public AuditLogType? AuditLogTypeId { get; set; }
}
