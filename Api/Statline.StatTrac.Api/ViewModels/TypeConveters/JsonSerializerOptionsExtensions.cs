using System.Text.Json;

namespace Statline.StatTrac.Api.ViewModels.TypeConveters;

internal static class JsonSerializerOptionsExtensions
{
    public static void AddCustomConverters(this JsonSerializerOptions jsonOptions)
    {
        jsonOptions.Converters.Add(new PhoneNumberJsonConverter());
        jsonOptions.Converters.Add(new PhoneExtensionJsonConverter());
        jsonOptions.Converters.Add(new DateOnlyJsonConverter());
    }
}
