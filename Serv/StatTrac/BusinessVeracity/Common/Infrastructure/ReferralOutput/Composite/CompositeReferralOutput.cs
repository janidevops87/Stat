using Statline.StatTrac.BusinessVeracity.Common.Application;
using System.Text.Json;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.Composite;

/// <summary>
/// Represents an <see cref="IReferralOutput{TReferral}"/> which
/// aggregates multiple other outputs so they can be used as one single
/// output.
/// </summary>
/// <typeparam name="TReferral">The type of referral object.</typeparam>
public class CompositeReferralOutput<TReferral> : IReferralOutput<TReferral>
{
    private readonly IEnumerable<IReferralOutput<TReferral>> innerOutputs;
    private readonly ILogger logger;

    public CompositeReferralOutput(
        IEnumerable<IReferralOutput<TReferral>> innerOutputs,
        ILogger<CompositeReferralOutput<TReferral>> logger)
    {
        this.innerOutputs = Check.NotNull(innerOutputs, nameof(innerOutputs));
        this.logger = Check.NotNull(logger, nameof(logger));
    }

    public async Task PublishAsync(IAsyncEnumerable<TReferral> referrals, ApplicationRunContext runContext)
    {
        Check.NotNull(referrals, nameof(referrals));
        Check.NotNull(runContext, nameof(runContext));

        using TempFile tempFile = Path.GetTempFileName();

        logger.LogInformation("Created temporary file at path '{TempFilePath}'", tempFile);

        var tempFileStream = tempFile.FileInfo.Open(FileMode.Open);

        await using (tempFileStream.ConfigureAwait(false))
        {
            logger.LogInformation("Writing to temporary file...");

            await JsonSerializer.SerializeAsync(tempFileStream, referrals).ConfigureAwait(false);

            await tempFileStream.FlushAsync().ConfigureAwait(false);

            logger.LogInformation(
                "Writing to temporary file finished. " +
                "Starting forwarding file data to inner referral outputs.");

            foreach (var innerOutput in innerOutputs)
            {
                tempFileStream.Seek(0, SeekOrigin.Begin);

                referrals = JsonSerializer.DeserializeAsyncEnumerable<TReferral>(tempFileStream)!;

                await innerOutput.PublishAsync(referrals, runContext).ConfigureAwait(false);
            }

            logger.LogInformation("Finished forwarding file data to inner referral outputs.");
        }
    }
}
