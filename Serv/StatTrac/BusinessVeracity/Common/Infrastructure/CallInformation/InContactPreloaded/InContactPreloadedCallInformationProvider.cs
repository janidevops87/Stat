using DotNext.Threading;
using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.CallInformation.InContactPreloaded;

public class InContactPreloadedCallInformationProvider : ICallInformationProvider
{
    private readonly AsyncLazy<InContactDataContext> LazyDataContext;
    private readonly IInContactApiClient inContactApiClient;

    public InContactPreloadedCallInformationProvider(
        IInContactApiClient inContactApiClient,
        ILogger<InContactPreloadedCallInformationProvider> logger)
    {
        this.inContactApiClient = Check.NotNull(inContactApiClient, nameof(inContactApiClient));

        LazyDataContext = new(async () =>
        {
            logger.LogLoadingInformationFromInContact();
            return await InContactDataContext.LoadFromApiAsync(inContactApiClient).ConfigureAwait(false);
        });
    }

    public async Task<string> DownloadRecordingFileAsync(string filePath, CancellationToken cancellationToken = default)
    {
        var fileResponse = await inContactApiClient.DownloadFileAsync(filePath, cancellationToken).ConfigureAwait(false);
        // TODO: Return Stream instead
        return fileResponse.files.file;
    }

    public async Task<IReadOnlyCollection<Agent>> FindAgentsByFullNameAsync(
        string fullName,
        CancellationToken cancellationToken = default)
    {
        var dataContext = await LazyDataContext.ConfigureAwait(false);

        return dataContext.AllAgentsByFullName[fullName].ToArray();
    }

    public async Task<Contact?> FindContactByIdAsync(
        long contactId,
        CancellationToken cancellationToken)
    {
        var contactDto = await inContactApiClient.GetContactAsync(contactId, cancellationToken).ConfigureAwait(false);

        return contactDto?.ToContact();
    }

    public async Task<IReadOnlyCollection<ContactInfo>> GetCompletedContactsAsync(
        DateTimeOffset startDateTime,
        DateTimeOffset endDateTime,
        int agentId,
        CancellationToken cancellationToken)
    {
        var contactDtos = await inContactApiClient.GetCompletedContactsAsync(
            startDateTime,
            endDateTime,
            agentId,
            cancellationToken).ConfigureAwait(false);

        return contactDtos.Select(DtoTranslationExtensions.ToContactInfo).ToArray();
    }

    public async Task<IReadOnlyCollection<string>> GetContactRecordingFilesAsync(long contactId, CancellationToken cancellationToken = default)
    {
        var dataContext = await LazyDataContext.ConfigureAwait(false);
        return dataContext.FilesByContactId[contactId].ToArray();
    }

    public async Task<Disposition?> FindDispositionByIdAsync(int dispositionId)
    {
        var dataContext = await LazyDataContext.ConfigureAwait(false);
        return dataContext.DispositionsById.GetValueOrDefault(dispositionId);
    }
}
