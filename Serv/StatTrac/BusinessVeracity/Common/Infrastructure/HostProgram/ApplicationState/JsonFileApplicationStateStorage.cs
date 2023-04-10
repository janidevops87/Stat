using System.Text.Json;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

internal class JsonFileApplicationStateStorage<TState>
    : IApplicationStateStorage<TState> where TState : class
{
    private readonly JsonFileApplicationStateStorageOptions options;

    public JsonFileApplicationStateStorage(
        IOptions<JsonFileApplicationStateStorageOptions> options,
        ILogger<JsonFileApplicationStateStorage<TState>> logger)
    {
        this.options = Check.NotNull(options, nameof(options)).Value;

        logger.LogInformation(
            "Application state file path is set to '{StorageFilePath}'",
            Path.GetFullPath(GetStorageFilePath()));
    }

    public async Task<TState?> LoadStateAsync()
    {
        var storageFilePath = GetStorageFilePath();

        if (!File.Exists(storageFilePath))
        {
            return null;
        }

        using var stream = File.OpenRead(storageFilePath);

        return await JsonSerializer.DeserializeAsync<TState>(stream).ConfigureAwait(false);
    }

    public async Task SaveStateAsync(TState state)
    {
        var storageFilePath = GetStorageFilePath();

        Directory.CreateDirectory(Path.GetDirectoryName(storageFilePath)!);

        using var stream = File.Create(storageFilePath);

        await JsonSerializer.SerializeAsync(stream, state).ConfigureAwait(false);
    }

    private string GetStorageFilePath()
    {
        var baseFolderPath = Environment.ExpandEnvironmentVariables(options.BaseFolderPath);
        return Path.Combine(baseFolderPath, "ApplicationState.json");
    }
}
