using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.Persons;

public record class PersonFilterCriteria(
    string? FirstName,
    string? LastName,
    OrganizationId? OrganizationId,
    ActiveStateFilter ActiveState);
