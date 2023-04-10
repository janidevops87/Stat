using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.App.LowLevel.Organizations;

public class PhoneInfo
{
    public PhoneInfo(
        int id,
        PhoneNumber? phoneNumber)
    {
        Id = id;
        PhoneNumber = phoneNumber;
    }

    public int Id { get; }
    public PhoneNumber? PhoneNumber { get; }
}
