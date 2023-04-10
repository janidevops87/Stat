namespace Statline.StatTrac.Domain.TimeZones;

public sealed class TimeZone
{
    internal TimeZone() { }

    public int TimeZoneId { get; private set; }
    public string? TimeZoneName { get; private set; }
    public string? TimeZoneAbbreviation { get; private set; }
    public bool? ObservesDaylightSavings { get; private set; }
    public TimeSpan? DayLightSavingsStartTime { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public int? LastStatEmployeeId { get; private set; }
    public int? AuditLogTypeId { get; private set; }
    public string IanaTimeZoneId { get; private set; } = default!;
}
