using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Files;
using System.Globalization;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.CallInformation.InContactPreloaded;

public class InContactDataContext
{
    private static readonly CultureInfo StringComparisonCulture = CultureInfo.GetCultureInfo("en-US");

    public ILookup<string, Agent> AllAgentsByFullName { get; }
    public IReadOnlyDictionary<int, Disposition> DispositionsById { get; }
    public ILookup<long, string> FilesByContactId { get; }

    public static async Task<InContactDataContext> LoadFromApiAsync(IInContactApiClient inContactApiClient)
    {
        return new InContactDataContext(
                await LoadAgentsAsync(inContactApiClient).ConfigureAwait(false),
                await LoadDispositionsAsync(inContactApiClient).ConfigureAwait(false),
                await LoadFilesListAsync(inContactApiClient).ConfigureAwait(false));
    }

    private InContactDataContext(
        IReadOnlyList<Agent> agents,
        IReadOnlyList<Disposition> dispositions,
        IReadOnlyList<FolderItem> files)
    {
        AllAgentsByFullName = BuildAgentsByFullNameLookup(agents);
        DispositionsById = BuildDispositionsById(dispositions);
        FilesByContactId = BuildFilesByContactIdLookup(files.Where(item => !item.isFolder));
    }

    private static async Task<IReadOnlyList<FolderItem>> LoadFilesListAsync(IInContactApiClient inContactApiClient)
    {
        var folderItems = await inContactApiClient.GetFolderContentsAsync("/CallLog/Processed").ConfigureAwait(false);
        return folderItems.files;
    }

    private static async Task<IReadOnlyList<Disposition>> LoadDispositionsAsync(IInContactApiClient inContactApiClient)
    {
        var dispositionsResponse = await inContactApiClient.GetAllDispositionsAsync().ConfigureAwait(false);

        return dispositionsResponse.dispositions.Select(DtoTranslationExtensions.ToDisposition).ToArray();
    }

    private static async Task<IReadOnlyList<Agent>> LoadAgentsAsync(IInContactApiClient inContactApiClient)
    {
        var agentsResponse = await inContactApiClient.GetAllAgentsAsync().ConfigureAwait(false);

        return agentsResponse.agents.Select(DtoTranslationExtensions.ToAgent).ToArray();
    }

    private static Dictionary<int, Disposition> BuildDispositionsById(IReadOnlyList<Disposition> dispositions)
    {
        return dispositions.ToDictionary(d => d.DispositionId);
    }

    private static ILookup<string, Agent> BuildAgentsByFullNameLookup(IReadOnlyList<Agent> agents)
    {
        return agents.ToLookup(
            agent => agent.FirstName + " " + agent.LastName,
            StringComparer.Create(StringComparisonCulture, ignoreCase: true));
    }

    private static ILookup<long, string> BuildFilesByContactIdLookup(
       IEnumerable<FolderItem> fileItems)
    {
        return fileItems
            // This is a workaround for files with "multiple" extensions
            // (e.g. "recording.wav.previous"). We need to filter
            // them out. As Bret explained, "they will appear from
            // time to time. The issue comes from them [InContact] switching
            // over to a backup site". We could filter by extension,
            // but we can't be sure that only particular extensions will
            // always be used.
            // Files without an extension are filtered out as well,
            // as other application parts expect extension.
            // NOTE: This a slow, but readable implementation. The speed
            // doesn't matter here.
            .Where(fi => fi.fileName.Count(c => c == '.') == 1)
            // It turns out there can be multiple files for
            // single contact id, so using Lookup.
            .ToLookup(fi =>
            {
                // Trying to parse Contact ID from file path.

                var fileNameParts = fi.fileNameWithPath.Split('_');

                string contactIdString;

                if (fileNameParts.Length >= 2)
                {
                    contactIdString = fileNameParts[^2];
                }
                else
                {
                    contactIdString = Path.GetFileNameWithoutExtension(fi.fileName);
                }

                return Convert.ToInt64(contactIdString, CultureInfo.InvariantCulture);
            },
            fi => fi.fileNameWithPath);
    }
}
