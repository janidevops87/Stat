using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage;
using System.Text.Json;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.JsonFile;

public class JsonFileReferralOutput<TReferral> : IReferralOutput<TReferral>
{
    private readonly string outputNameFormat;

    private readonly IFileStorage fileStorage;
    private readonly JsonSerializerOptions jsonSerializerOptions;
    private readonly ILogger logger;

    public JsonFileReferralOutput(
        IOptions<JsonFileReferralOutputOptions> options,
        IFileStorage fileStorage,
        ILogger<JsonFileReferralOutput<TReferral>> logger)
    {
        this.fileStorage = Check.NotNull(fileStorage, nameof(fileStorage));
        this.logger = Check.NotNull(logger, nameof(logger));

        var optionsValue = Check.NotNull(options, nameof(options)).Value;

        jsonSerializerOptions =
            new JsonSerializerOptions(JsonSerializerDefaults.General)
            {
                WriteIndented = optionsValue.WriteIdented
            };

        outputNameFormat = optionsValue.OutputNameFormat;
    }

    public async Task PublishAsync(
        IAsyncEnumerable<TReferral> referrals,
        ApplicationRunContext runContext)
    {
        var fileName = string.Format(outputNameFormat, runContext.EndDateTime);

        logger.LogInformation("Starting outputting referrals to file '{FileName}'.", fileName);

        await fileStorage.OpenAndWriteAsync(
            async storageStream =>
            {
                await JsonSerializer.SerializeAsync(
                    storageStream,
                    referrals,
                    jsonSerializerOptions).ConfigureAwait(false);
            },
            fileName).ConfigureAwait(false);

        logger.LogInformation("Finished outputting referrals to file '{FileName}'.", fileName);
    }
}
