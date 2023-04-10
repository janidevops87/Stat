using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Phones.Factory;

public class RawPhoneInfo
{
    public PhoneNumber PhoneNumber { get; }
    public PhoneTypeId? PhoneType { get; }
    public RawHospitalSubLocationInfo? Location { get; }

    public RawPhoneInfo(
        PhoneNumber phoneNumber,
        PhoneTypeId? phoneType,
        RawHospitalSubLocationInfo? location)
    {
        PhoneNumber = Check.NotNull(phoneNumber);
        PhoneType = phoneType;
        Location = location;
    }
}
