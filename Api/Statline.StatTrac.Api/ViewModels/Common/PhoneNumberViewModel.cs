using System.ComponentModel;

namespace Statline.StatTrac.Api.ViewModels.Common;

[TypeConverter(typeof(PhoneNumberViewModelTypeConverter))]
public class PhoneNumberViewModel
{
    public PhoneNumberViewModel(
        string areaCode,
        string prefix,
        string number)
    {
        AreaCode = areaCode;
        Prefix = prefix;
        Number = number;
    }

    public string AreaCode { get; }
    public string Prefix { get; }
    public string Number { get; }
}
