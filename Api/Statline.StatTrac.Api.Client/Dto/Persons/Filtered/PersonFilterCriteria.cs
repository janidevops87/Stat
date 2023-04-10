using Statline.StatTrac.Api.Client.Dto.Common;

namespace Statline.StatTrac.Api.Client.Dto.Persons.Filtered;

public record class PersonFilterCriteria(
    string? FirstName,
    string? LastName,
    ActiveStateFilter ActiveState = ActiveStateFilter.ActiveAndInactive);
