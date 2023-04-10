using System.Text.Json;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Common;

#pragma warning disable IDE1006 // Naming Styles

public class VoxJarResponse<TData> where TData : class
{
    public TData? data { get; set; }
    public Error[] errors { get; set; } = Array.Empty<Error>();

    internal void EnsureNoErrors()
    {
        if (errors.Any())
        {
            throw new InvalidOperationException(
                "Errors occurred while making request:" + Environment.NewLine +
                JsonSerializer.Serialize(errors, new JsonSerializerOptions { WriteIndented = true }));
        }
    }
}
