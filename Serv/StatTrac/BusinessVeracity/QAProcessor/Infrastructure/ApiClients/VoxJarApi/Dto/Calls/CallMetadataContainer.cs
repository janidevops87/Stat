namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;

#pragma warning disable IDE1006 // Naming Styles

public class CallMetadataContainer
{
    public long identifier { get; set; }
    public DateTimeOffset timestamp { get; set; }
    public ParticipantMetadata[] participants { get; set; } = default!;
    public string direction { get; set; } = default!;
    public string? disposition { get; set; }
    public AssetMetadata asset { get; set; } = default!;
    public string language { get; set; } = default!;
    public IDictionary<string, object?>? metadata { get; set; }
}
