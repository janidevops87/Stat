namespace Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;

public interface ICallInformationProvider
{
    Task<IReadOnlyCollection<Agent>> FindAgentsByFullNameAsync(string fullName, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<ContactInfo>> GetCompletedContactsAsync(DateTimeOffset startDateTime, DateTimeOffset endDateTime, int agentId, CancellationToken cancellationToken = default);
    Task<Contact?> FindContactByIdAsync(long contactId, CancellationToken cancellationToken = default);
    Task<IReadOnlyCollection<string>> GetContactRecordingFilesAsync(long contactId, CancellationToken cancellationToken = default);
    Task<string> DownloadRecordingFileAsync(string filePath, CancellationToken cancellationToken = default);
    Task<Disposition?> FindDispositionByIdAsync(int dispositionId);
}
