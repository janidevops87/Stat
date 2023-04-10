using Statline.StatTrac.Api.Client.Dto.Phones.Common;

namespace Statline.StatTrac.Api.Client.Dto.Phones.NewPhone;

public class Phone
{
    public string PhoneNumber { get; }
    public PhoneType? Type { get; }

    internal Phone(
        string phoneNumber,
        PhoneType? type)
    {
        PhoneNumber = Check.NotEmpty(phoneNumber);
        Type = type;
    }
}