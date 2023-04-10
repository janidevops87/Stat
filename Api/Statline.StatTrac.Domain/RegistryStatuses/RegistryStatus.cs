namespace Statline.StatTrac.Domain.RegistryStatuses;

public class RegistryStatus
{
    public int Id { get; set; }
    public RegistryStatusType? Status { get; set; }
    public int? CallId { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public int? LastStatEmployeeId { get; set; }
    public int? AuditLogTypeId { get; set; }
}
