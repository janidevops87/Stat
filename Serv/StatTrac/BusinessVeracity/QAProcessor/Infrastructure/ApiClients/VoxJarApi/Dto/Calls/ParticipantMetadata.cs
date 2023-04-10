namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;

#pragma warning disable IDE1006 // Naming Styles

public class ParticipantMetadata
{
    public int channel { get; set; }
    public string[] customers { get; set; } = default!;
    public string[] agents { get; set; } = default!;
}
