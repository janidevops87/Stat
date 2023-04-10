using Statline.StatTrac.Api.Client.Dto.Common;
using Statline.StatTrac.Api.Client.Dto.Phones.Common;

namespace Statline.StatTrac.Api.Client.Dto.Phones.NewPhone;

public class OrganizationPhone : Phone
{
    public HospitalSubLocation? Location { get; }

    public OrganizationPhone(
        string phoneNumber,
        PhoneType? type,
        HospitalSubLocation? location)
        : base(phoneNumber, type)
    {
        Location = location;
    }
}
