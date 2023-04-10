using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Phones.Factory;

public class PhoneInfo
{
    public PhoneNumber PhoneNumber { get; }
    public PhoneTypeId? Type { get; }
    public HospitalSubLocationInfo? Location { get; }

    public PhoneInfo(
        PhoneNumber phoneNumber,
        PhoneTypeId? type,
        HospitalSubLocationInfo? location)
    {
        PhoneNumber = Check.NotNull(phoneNumber);
        Type = type;
        Location = location;
    }
}
