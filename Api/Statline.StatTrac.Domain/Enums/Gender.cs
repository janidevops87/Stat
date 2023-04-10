using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Enums;

public class Gender
{
    internal Gender() { }

    public PersonGender GenderId { get; private set; }
    public string? GenderName { get; private set; }
    public string? GenderAbbreviation { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public int? LastStatEmployeeId { get; private set; }
    public int? AuditLogTypeId { get; private set; }
}
