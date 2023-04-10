namespace Statline.StatTrac.Domain.Persons;

public class StatEmployee
{
    internal StatEmployee() { }
    public int StatEmployeeId { get; private set; }
    public string? StatEmployeeFirstName { get; private set; }
    public string? StatEmployeeLastName { get; private set; }
    public string? StatEmployeeUserId { get; private set; }
    public string? StatEmployeePassword { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public short? AllowCallDelete { get; private set; }
    public short? AllowMaintainAccess { get; private set; }
    public short? AllowSecurityAccess { get; private set; }
    public short? AllowLicenseAccess { get; private set; }
    public PersonId? PersonId { get; private set; }
    public string? StatEmployeeEmail { get; private set; }
    public short? AllowStopTimerAccess { get; private set; }
    public short? AllowIncompleteAccess { get; private set; }
    public short? AllowScheduleAccess { get; private set; }
    public short? UpdatedFlag { get; private set; }
    public short? AllowRecoveryAccess { get; private set; }
    public short? AllowInternetAccess { get; private set; }
    public short? IntranetSecurityLevel { get; private set; }
    public short? AllowEmployeeMaintTc { get; private set; }
    public short? AllowEmployeeMaintFs { get; private set; }
    public short? AllowEmployeeMaintAdmin { get; private set; }
    public short? AllowEmployeeScheduleTc { get; private set; }
    public short? AllowEmployeeScheduleFs { get; private set; }
    public short? AllowQareview { get; private set; }
    public short? AllowRecycleCase { get; private set; }
    public short? AllowCloseReferral { get; private set; }
    public int? AllowAspsave { get; private set; }
    public short? AllowViewDeletedLogEvents { get; private set; }
    public int? LastStatEmployeeId { get; private set; }
    public int? AuditLogTypeId { get; private set; }
}
