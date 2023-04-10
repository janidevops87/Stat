using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Agents;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Contacts;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Dispositions;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Files;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi;

public interface IInContactApiClient
{
    Task<FileResponse> DownloadFileAsync(string filePath, CancellationToken cancellationToken = default);
    Task<AgentsResponse> GetAllAgentsAsync(CancellationToken cancellationToken = default);
    Task<DispositionsResponse> GetAllDispositionsAsync(CancellationToken cancellationToken = default);
    Task<CompletedContact[]> GetCompletedContactsAsync(DateTimeOffset startDateTime, DateTimeOffset endDateTime, int agentId, CancellationToken cancellationToken = default);
    Task<Contact?> GetContactAsync(long contactId, CancellationToken cancellationToken = default);
    Task<FolderItemsList> GetFolderContentsAsync(string folderPath, CancellationToken cancellationToken = default);
}
