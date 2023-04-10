using Statline.StatTrac.Domain.Common;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Statline.StatTrac.Api.ViewModels.TypeConveters;

public class PhoneExtensionJsonConverter : JsonConverter<PhoneExtension>
{
    public override PhoneExtension? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        var str = reader.GetString();

        try
        {
            return str is null ? default : new PhoneExtension(str);
        }
        catch (FormatException ex)
        {
            throw new JsonException(ex.Message, ex);
        }
    }

    public override void Write(Utf8JsonWriter writer, PhoneExtension value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString());
    }
}
