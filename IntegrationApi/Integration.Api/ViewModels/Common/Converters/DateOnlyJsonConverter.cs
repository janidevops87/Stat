using System.Text.Json;
using System.Text.Json.Serialization;

namespace Statline.StatTrac.Integration.Api.ViewModels.Common.Converters;

// While DateOnly type was introduced in .Net 6.0, support
// of it in System.Text.Json will be added only in .Net 7.0.
// Details:
// https://github.com/dotnet/runtime/issues/51302
// https://github.com/dotnet/runtime/issues/53539
// This is a workaround for meanwhile.
#if NET7_0_OR_GREATER
#warning Switch to in-box DateOnly JSON Serializer support.
#endif
public sealed class DateOnlyJsonConverter : JsonConverter<DateOnly>
{
    public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        if (reader.GetString() is string str)
        {
            try
            {
                return DateOnly.Parse(str);
            }
            catch (FormatException ex)
            {
                throw new JsonException(ex.Message, ex);
            }
        }

        return default;
    }

    public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
    {
        var isoDate = value.ToString("O");
        writer.WriteStringValue(isoDate);
    }
}
