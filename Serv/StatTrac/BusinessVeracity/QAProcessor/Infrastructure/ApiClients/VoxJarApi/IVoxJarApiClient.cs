using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Users;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi;

public interface IVoxJarApiClient
{
    Task UploadCallsAsync(CallMetadataContainer[] calls, CancellationToken cancellationToken = default);
    Task UploadUsersAsync(UserMetadataContainer[] users, CancellationToken cancellationToken = default);
}
