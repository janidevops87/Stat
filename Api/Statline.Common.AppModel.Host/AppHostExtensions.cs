using System;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Statline.Common.AppModel.Host
{
    public static class AppHostExtensions
    {
        public static async Task RunAppAsync<TApp>(
            this IAppHost host,
            Func<TApp, Task> runCallback)
        {
            Check.NotNull(host, nameof(host));

            await host.RunAppAsync(async ctx =>
            {
                // Use separate scope for each app run.
                using (var scope = ctx.ServiceProvider.CreateScope())
                {
                    var app = scope.ServiceProvider.GetRequiredService<TApp>();
                    await runCallback(app);
                }
            });
        }
    }
}
