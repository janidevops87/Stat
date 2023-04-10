using System;

namespace Statline.StatTracUploader.Domain.Main.LogEvents
{
    public class LogEvent
    {
        public int Id { get; set; }
        public int? CallId { get; set; }
        public LogEventType? Type { get; set; }
        public DateTimeOffset? DateTime { get; set; }
        public int? Number { get; set; }
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
        public int? AuditLogTypeId { get; set; }
    }
}
