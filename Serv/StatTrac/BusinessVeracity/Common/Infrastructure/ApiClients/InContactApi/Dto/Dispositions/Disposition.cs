namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Dispositions;
#pragma warning disable IDE1006 // Naming Styles

public class Disposition
{
    public int dispositionId { get; set; }
    public string dispositionName { get; set; } = default!;
    public string? notes { get; set; } = default!;
    public DateTime lastUpdated { get; set; }
    public string? classificationId { get; set; } = default!;
    public string systemOutcome { get; set; } = default!;
    public bool isPreviewDisposition { get; set; }
}
