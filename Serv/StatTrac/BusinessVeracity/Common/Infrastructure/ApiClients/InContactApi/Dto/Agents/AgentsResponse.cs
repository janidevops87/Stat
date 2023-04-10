namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Agents;
#pragma warning disable IDE1006 // Naming Styles

public class AgentsResponse
{
    public int businessUnitId { get; set; }
    public DateTime lastPollTime { get; set; }
    public int totalRecords { get; set; }
    public int? hiddenAgents { get; set; }
    public Agent[] agents { get; set; } = default!;
}
