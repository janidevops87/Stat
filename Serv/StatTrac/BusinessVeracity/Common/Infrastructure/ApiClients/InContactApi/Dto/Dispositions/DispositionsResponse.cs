namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Dispositions;
#pragma warning disable IDE1006 // Naming Styles

public class DispositionsResponse
{
    public int businessUnitId { get; set; }
    public int totalRecords { get; set; }
    public Disposition[] dispositions { get; set; } = default!;
}
