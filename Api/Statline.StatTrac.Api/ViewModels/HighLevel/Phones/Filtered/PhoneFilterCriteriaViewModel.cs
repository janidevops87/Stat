using Statline.StatTrac.Api.ViewModels.Common;
using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Phones.Filtered;

public class PhoneFilterCriteriaViewModel
{
    public PhoneNumber PhoneNumber { get; set; } = default!;
    public ActiveStateFilter ActiveState { get; set; } = ActiveStateFilter.ActiveAndInactive;
}
