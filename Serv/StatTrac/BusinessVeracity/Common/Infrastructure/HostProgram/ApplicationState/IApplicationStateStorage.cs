namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

public interface IApplicationStateStorage<TState> where TState : class
{
    Task<TState?> LoadStateAsync();
    Task SaveStateAsync(TState state);
}
