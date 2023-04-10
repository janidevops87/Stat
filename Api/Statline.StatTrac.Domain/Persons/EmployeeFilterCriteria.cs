using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Persons;

public record class EmployeeFilterCriteria(
    string? FirstName,
    string? LastName,
    ActiveStateFilter ActiveState);
