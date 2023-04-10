namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

public static class IApplicationStateStorageExtensions
{
    public static async Task<TState> LoadStateOrDefaultAsync<TState>(
        this IApplicationStateStorage<TState> stateStorage,
        TState defaultState) where TState : class
    {
        Check.NotNull(stateStorage, nameof(stateStorage));
        return await stateStorage.LoadStateOrDefaultAsync(() => defaultState).ConfigureAwait(false);
    }

    public static async Task<TState> LoadStateOrDefaultAsync<TState>(
        this IApplicationStateStorage<TState> stateStorage,
        Func<TState> defaultStateFactory) where TState : class
    {
        Check.NotNull(stateStorage, nameof(stateStorage));
        Check.NotNull(defaultStateFactory, nameof(defaultStateFactory));
        return await stateStorage.LoadStateAsync().ConfigureAwait(false) ?? defaultStateFactory();
    }
}
