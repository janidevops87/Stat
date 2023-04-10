using Statline.StatTrac.Domain.Common;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Statline.StatTrac.Api.ViewModels.TypeConveters;

public class PhoneNumberJsonConverter : JsonConverter<PhoneNumber>
{
    public override PhoneNumber? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        var str = reader.GetString();

        try
        {
            return str is null ? default : PhoneNumber.Parse(str);

        }
        catch (FormatException ex)
        {
            throw new JsonException(ex.Message, ex);
        }
    }

    public override void Write(Utf8JsonWriter writer, PhoneNumber value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString());
    }
}
