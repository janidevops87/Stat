namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Common;

#pragma warning disable IDE1006 // Naming Styles

public class Error
{
    public string message { get; set; } = default!;
    public ErrorLocation[] locations { get; set; } = default!;
    public string[] path { get; set; } = default!;
    public ErrorExtension? extensions { get; set; }
}
