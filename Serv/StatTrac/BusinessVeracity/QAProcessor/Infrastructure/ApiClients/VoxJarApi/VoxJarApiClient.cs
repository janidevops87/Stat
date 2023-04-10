using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Common;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Users;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi;

#pragma warning disable IDE0037 // Use inferred member name

internal class VoxJarApiClient :
    RestServiceClient<VoxJarApiClient>,
    IVoxJarApiClient
{
    public VoxJarApiClient(
        HttpClient httpClient,
        IOptions<RestServiceClientOptions<VoxJarApiClient>> options) :
        base(httpClient, basePath: "", options)
    {
    }

    public async Task UploadUsersAsync(UserMetadataContainer[] users, CancellationToken cancellationToken)
    {
        var body = new
        {
            query = @"mutation($users: [CreateOrUpdateUserInput!]!){
                    createOrUpdateUsers(users:$users){
                        id
                    }
                  }",
            variables = new { users }
        };

        var voxJarResponse = await HttpClient.SendAndUnwrapResultContentAsync<VoxJarResponse<object>>(
            new Uri("", UriKind.Relative),
            HttpMethod.Post,
            content: body,
            cancellationToken: cancellationToken).ConfigureAwait(false);

        voxJarResponse.EnsureNoErrors();
    }

    public async Task UploadCallsAsync(CallMetadataContainer[] calls, CancellationToken cancellationToken)
    {
        Check.NotNull(calls, nameof(calls));

        var body = new
        {
            query = @"mutation($calls: [CreateCallInput!]!){
                      createCalls(calls: $calls) {
                              identifier
                              timestamp
                              participants{
                                  agents{
                                      edges{
                                          node{
                                              id
                                          }
                                      }
                                  }
                                  customers{
                                      edges{
                                          node{
                                              id
                                          }
                                      }
                                  }
                                  channel
                              }
                              direction
                              type
                              disposition
                              metadata
                              language
                          }
                      }",

            variables = new { calls }
        };

        var voxJarResponse = await HttpClient.SendAndUnwrapResultContentAsync<VoxJarResponse<object>>(
            new Uri("", UriKind.Relative),
            HttpMethod.Post,
            content: body,
            cancellationToken: cancellationToken).ConfigureAwait(false);

        voxJarResponse.EnsureNoErrors();
    }
}
