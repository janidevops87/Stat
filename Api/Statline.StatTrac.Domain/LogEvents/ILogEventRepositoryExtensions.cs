namespace Statline.StatTrac.Domain.LogEvents;

public static class ILogEventRepositoryExtensions
{
    public static async Task<LogEvent?> FindLogEventAsync(this ILogEventRepository logEventRepository, int id)
    {
        Check.NotNull(logEventRepository, nameof(logEventRepository));
        return await logEventRepository.FindLogEventAsync(id, logEvent => logEvent).ConfigureAwait(false);
    }
}
