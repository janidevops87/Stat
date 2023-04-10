using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Services;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

namespace Microsoft.Extensions.Hosting;

public static class IHostExtensions
{
    public static async Task RunApplicationAsync(this IHost host)
    {
        var sp = host.Services;

        var logger = sp.GetRequiredService<ILogger<IHost>>();

        try
        {
            await RunAsync(host).ConfigureAwait(false);
        }
        catch (Exception ex)
        {
            logger.LogCritical(ex, "Unhandled exception, the program will exit now");
            throw;
        }
    }

    private static async Task RunAsync(IHost host)
    {
        var sp = host.Services;

        var stateStorage = sp.GetRequiredService<IApplicationStateStorage<ProgramState>>();
        var dateTimeService = sp.GetRequiredService<IDateTimeService>();

        var appState = await stateStorage.LoadStateOrDefaultAsync(
            () => new ProgramState(LastRunTime: dateTimeService.GetCurrent())).ConfigureAwait(false);

        var currDateTime = dateTimeService.GetCurrent();
        var prevDateTime = appState.LastRunTime;
        
        var app = sp.GetRequiredService<IReferralProcessorApplication>();

        await app.RunAsync(new ApplicationRunContext(prevDateTime, currDateTime)).ConfigureAwait(false);

        appState = appState with { LastRunTime = currDateTime };

        await stateStorage.SaveStateAsync(appState).ConfigureAwait(false);
    }
}
