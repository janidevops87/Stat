namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage.Local;

public class LocalFileStorage : IFileStorage
{
    private readonly LocalFileStorageOptions options;

    public LocalFileStorage(
        IOptions<LocalFileStorageOptions> options,
        ILogger<LocalFileStorage> logger)
    {
        this.options = Check.NotNull(options, nameof(options)).Value;
        
        Check.NotNull(logger, nameof(logger));

        logger.LogInformation(
            "Local file storage base path is set to '{LocalStoragePath}'",
            Path.GetFullPath(this.options.BaseFolderPath));
    }

    public async Task OpenAndWriteAsync(Func<Stream, Task> writeCallback, string name)
    {
        Check.NotNull(writeCallback, nameof(writeCallback));
        Check.NotEmpty(name, nameof(name));

        var filePath = GetStorageFilePath(name);

        Directory.CreateDirectory(Path.GetDirectoryName(filePath)!);

        var fileStream = File.Create(filePath);

        try
        {
            await using (fileStream.ConfigureAwait(false))
            {
                await writeCallback(fileStream).ConfigureAwait(false);
            }
        }
        catch (Exception)
        {
            File.Delete(filePath);
            throw;
        }
    }

    private string GetStorageFilePath(string fileName)
    {
        var baseFolderPath = Environment.ExpandEnvironmentVariables(options.BaseFolderPath);
        return Path.Combine(baseFolderPath, fileName);
    }
}
