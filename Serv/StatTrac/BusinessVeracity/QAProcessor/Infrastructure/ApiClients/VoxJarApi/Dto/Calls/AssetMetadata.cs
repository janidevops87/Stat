namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;

#pragma warning disable IDE1006 // Naming Styles

public class AssetMetadata
{
    public string data { get; set; } = default!;
    public bool requiresSpeechRecognition { get; set; }
}
