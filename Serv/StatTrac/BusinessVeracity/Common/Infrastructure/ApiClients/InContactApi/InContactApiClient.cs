using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Agents;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Contacts;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Dispositions;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Files;
using System.Globalization;
using System.Net;

#pragma warning disable IDE0037 // Use inferred member name

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi;

internal class InContactApiClient :
    RestServiceClient<InContactApiClient>,
    IInContactApiClient
{
    private const string BasePath = "inContactAPI/services/v21.0/";

    public InContactApiClient(
        HttpClient httpClient,
        IOptions<RestServiceClientOptions<InContactApiClient>> options) :
        base(httpClient, BasePath, options)
    {
    }

    public async Task<AgentsResponse> GetAllAgentsAsync(CancellationToken cancellationToken)
    {
        return await HttpClient.SendAndUnwrapResultContentAsync<AgentsResponse>(
            new Uri("agents", UriKind.Relative),
            HttpMethod.Get,
            cancellationToken: cancellationToken).ConfigureAwait(false);
    }

    public async Task<DispositionsResponse> GetAllDispositionsAsync(CancellationToken cancellationToken)
    {
        return await HttpClient.SendAndUnwrapResultContentAsync<DispositionsResponse>(
            new Uri("dispositions", UriKind.Relative),
            HttpMethod.Get,
            cancellationToken: cancellationToken).ConfigureAwait(false);
    }

    public async Task<FolderItemsList> GetFolderContentsAsync(
        string folderPath,
        CancellationToken cancellationToken)
    {
        Check.NotEmpty(folderPath, nameof(folderPath));

        var uri = BuildRequestUri("folders", new { folderName = folderPath });

        return await HttpClient.SendAndUnwrapResultContentAsync<FolderItemsList>(
            uri,
            HttpMethod.Get,
            cancellationToken: cancellationToken).ConfigureAwait(false);
    }

    public async Task<FileResponse> DownloadFileAsync(
       string filePath,
       CancellationToken cancellationToken = default)
    {
        Check.NotEmpty(filePath, nameof(filePath));

        var uri = BuildRequestUri("files", new { fileName = filePath });

        var fileResponse = await HttpClient.SendAndUnwrapResultContentAsync<FileResponse>(
                uri,
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);

        fileResponse.files.fileNameWithPath = filePath;

        return fileResponse;
    }

    public async Task<CompletedContact[]> GetCompletedContactsAsync(
        DateTimeOffset startDateTime,
        DateTimeOffset endDateTime,
        int agentId,
        CancellationToken cancellationToken)
    {
        var uri = BuildRequestUri("contacts/completed",
            new
            {
                // Even though InContact API docs state it expects
                // dates in ISO 8601 format, it seems to be not supporting
                // time zone offsets and expects UTC date/time.
                startDate = startDateTime.ToUniversalTime(),
                endDate = endDateTime.ToUniversalTime(),
                agentId
            });

        var response = await HttpClient.SendAsync<CompletedContactsResponse>(
            uri,
            HttpMethod.Get,
            ensureSuccessStatusCode: true,
            cancellationToken: cancellationToken).ConfigureAwait(false);

        if (response.ResponseMessage.StatusCode == HttpStatusCode.NoContent)
        {
            return Array.Empty<CompletedContact>();
        }

        return response.GetContentOrThrow().completedContacts;
    }

    public async Task<Contact?> GetContactAsync(
        long contactId,
        CancellationToken cancellationToken)
    {
        var response = await HttpClient.SendAsync<Contact>(
            new Uri($"contacts/{contactId.ToString(CultureInfo.InvariantCulture)}", UriKind.Relative),
            HttpMethod.Get,
            ensureSuccessStatusCode: false,
            cancellationToken: cancellationToken).ConfigureAwait(false);

        if (response.ResponseMessage.StatusCode is 
            HttpStatusCode.NotFound or 
            HttpStatusCode.NoContent)
        {
            return null;
        }

        response.ResponseMessage.EnsureSuccessStatusCode();

        return response.GetContentOrThrow();
    }
}
