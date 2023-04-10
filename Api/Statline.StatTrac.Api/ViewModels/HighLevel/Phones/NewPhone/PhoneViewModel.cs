using Statline.StatTrac.Api.ViewModels.HighLevel.Common;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Phones;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Phones.NewPhone;

public class PhoneViewModel
{
    public PhoneNumber PhoneNumber { get; init; } = default!;
    public PhoneTypeId? Type { get; init; }
    public HospitalSubLocationViewModel? Location { get; init; }
}
