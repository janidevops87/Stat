namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Contacts;
#pragma warning disable IDE1006 // Naming Styles

public class CompletedContactsResponse
{
    public int businessUnitId { get; set; }
    public DateTime lastPollTime { get; set; }
    public int totalRecords { get; set; }
    public CompletedContact[] completedContacts { get; set; } = default!;
}
