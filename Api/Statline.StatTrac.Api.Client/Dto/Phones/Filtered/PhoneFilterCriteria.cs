using Statline.StatTrac.Api.Client.Dto.Common;

namespace Statline.StatTrac.Api.Client.Dto.Phones.Filtered;

public record class PhoneFilterCriteria(
    string PhoneNumber,
    ActiveStateFilter ActiveState = ActiveStateFilter.ActiveAndInactive);
