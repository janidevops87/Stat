namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Users;

#pragma warning disable IDE1006 // Naming Styles

public class AgentMetadataContainer : UserMetadataContainer
{
    public string? name { get; set; }
    public IDictionary<string, object?>? metadata { get; set; }
}
