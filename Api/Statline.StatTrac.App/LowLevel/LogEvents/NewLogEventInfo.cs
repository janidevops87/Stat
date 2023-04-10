namespace Statline.StatTrac.App.LowLevel.LogEvents;

public class NewLogEventInfo
{
    public int? CallId { get; set; }
    public int? TypeId { get; set; }
    public DateTimeOffset? DateTime { get; set; }
    public string? FromToPersonName { get; set; }
    public string? Phone { get; set; }
    public string? OrganizationName { get; set; }
    public int? OrganizationId { get; set; }
    public string? Description { get; set; }
    public int? StatEmployeeId { get; set; }
    public short? CallbackPending { get; set; }
    public int? ScheduleGroupId { get; set; }
    public int? FromToPersonId { get; set; }
    public int? PhoneId { get; set; }
    public short? ContactConfirmed { get; set; }
    public short? UpdatedFlag { get; set; }
    public DateTimeOffset? CalloutDateTime { get; set; }
    public int? LastStatEmployeeId { get; set; }
}
