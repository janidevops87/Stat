using Amazon;
using Amazon.S3.Transfer;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage;
using System.Diagnostics.CodeAnalysis;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.FileStorage.AmazonS3;

public class AmazonS3FileStorage : IFileStorage, IDisposable
{
    private readonly TransferUtility transferUtility;
    private readonly string bucketName;
    private readonly ILogger logger;

    public AmazonS3FileStorage(
        IOptionsSnapshot<AmazonS3FileStorageOptions> options,
        ILogger<AmazonS3FileStorage> logger)
    {
        this.logger = Check.NotNull(logger, nameof(logger));

        var optionsValue = Check.NotNull(options, nameof(options)).Value;

        transferUtility = new TransferUtility(
            optionsValue.AwsAccessKeyId,
            optionsValue.AwsSecretAccessKey,
            RegionEndpoint.GetBySystemName(optionsValue.RegionEndpointName));

        bucketName = optionsValue.BucketName;
    }

    public async Task OpenAndWriteAsync(Func<Stream, Task> writeCallback, string name)
    {
        Check.NotNull(writeCallback, nameof(writeCallback));
        Check.NotEmpty(name, nameof(name));

        // Here is the problem: calling code needs a stream to write to,
        // and Amazon's code needs a stream to read from. To solve this
        // a temporary file is used. Alternative (and better) approach
        // would be to use some mediator stream like
        // https://github.com/AArnott/Nerdbank.Streams/blob/main/doc/SimplexStream.md.
        // However, Amazon's code needs to know stream length afore head, which is
        // obviously not possible with such stream (because it holds only
        // small part of data written to it).

        using TempFile tempFile = Path.GetTempFileName();

        logger.LogInformation("Created temporary file at path '{TempFilePath}'", tempFile);

        var tempFileStream = tempFile.FileInfo.Open(FileMode.Open);

        await using (tempFileStream.ConfigureAwait(false))
        {
            logger.LogInformation("Writing to temporary file...");

            await writeCallback(tempFileStream).ConfigureAwait(false);

            await tempFileStream.FlushAsync().ConfigureAwait(false);

            logger.LogInformation("Writing to temporary file finished.");

            tempFileStream.Seek(0, SeekOrigin.Begin);

            logger.LogInformation(
                "Uploading temporary file to Amazon S3 bucket under name '{FileName}'.", name);

            await transferUtility.UploadAsync(tempFileStream, bucketName, name).ConfigureAwait(false);

            logger.LogInformation("Temporary file uploaded successfully.");
        }
    }

    [SuppressMessage("Usage", "CA1816:Dispose methods should call SuppressFinalize", Justification = "No finalizer")]
    public void Dispose()
    {
        transferUtility.Dispose();
    }
}
