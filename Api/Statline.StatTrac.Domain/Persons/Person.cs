using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Enums;

namespace Statline.StatTrac.Domain.Persons;

public class Person
{
    internal Person() { }

    public PersonId PersonId { get; set; }
    public string? PersonFirst { get; set; }
    public string? PersonMi { get; set; }
    public string? PersonLast { get; set; }
    public int? PersonTypeId { get; set; }
    public int? OrganizationId { get; set; }
    public string? PersonNotes { get; set; }
    public IntegerBoolean? PersonBusy { get; set; }
    public IntegerBoolean? Verified { get; set; }
    public IntegerBoolean? Inactive { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public DateTimeOffset? PersonBusyUntil { get; set; }
    public short? PersonTempNoteActive { get; set; }
    public DateTimeOffset? PersonTempNoteExpires { get; set; }
    public string? PersonTempNote { get; set; }
    public string? Unused { get; set; }
    public short? UpdatedFlag { get; set; }
    public short? AllowInternetScheduleAccess { get; set; }
    public int? PersonSecurity { get; set; }
    public short? PersonArchive { get; set; }
    public int? LastStatEmployeeId { get; set; }
    public AuditLogType? AuditLogTypeId { get; set; }
    public PersonGender? GenderId { get; set; }
    public int? RaceId { get; set; }
    public string? Credential { get; set; }
    public int? TrainedRequestorId { get; set; }

    public Gender? Gender { get; private set; }
    public Race? Race { get; private set; }
    public StatEmployee? StatEmployee { get; private set; }
}
