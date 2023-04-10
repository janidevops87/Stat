using System.Text.Json;

namespace Statline.StatTrac.Integration.Api.ViewModels.Common.Converters;

internal static class JsonSerializerOptionsExtensions
{
    public static void AddCustomConverters(this JsonSerializerOptions jsonOptions)
    {
        jsonOptions.Converters.Add(new DateOnlyJsonConverter());
    }
}
