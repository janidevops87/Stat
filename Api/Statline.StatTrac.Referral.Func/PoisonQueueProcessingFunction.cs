using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.WindowsAzure.Storage.Queue;
using Statline.Common.Services;
using Statline.StatTrac.Api.Func.Infrastructure;
using Statline.StatTrac.Api.Func.Model;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Func
{
    public class PoisonQueueProcessingFunction : FunctionBase
    {
        private static PoisonQueueProcessingFunction functionInstance;

        static PoisonQueueProcessingFunction()
        {
            // TODO: Verify this is called when function is unloaded.
            AppDomain.CurrentDomain.DomainUnload += (s, e) =>
            {
                functionInstance?.Dispose();
            };
        }

        public PoisonQueueProcessingFunction(
                   Microsoft.Azure.WebJobs.ExecutionContext executionContext)
                   : base(executionContext)
        {
        }

        [FunctionName("ReferralPoisonQueueProcessingFunction")]
        public static async Task Run(
            [QueueTrigger("referral-poison")]ReferralQueueDto poisonQueueItem,
            [Queue("referral-poison")]CloudQueue poisonQueue,
            [Queue("referral-retry")]CloudQueue failedQueue,
            [Queue("referral")]CloudQueue mainQueue,
            TraceWriter funcLogger,
            Microsoft.Azure.WebJobs.ExecutionContext context)
        {
            funcLogger.Info("Function started executing");

            LazyInitializer.EnsureInitialized(ref functionInstance, () =>
            {
                funcLogger.Info("Creating function singleton instance.");
                return new PoisonQueueProcessingFunction(context);
            });

            await functionInstance.RunAsync(
                poisonQueueItem,
                poisonQueue,
                mainQueue,
                failedQueue);
        }

        private async Task RunAsync(
            ReferralQueueDto poisonQueueItem,
            CloudQueue poisonQueue,
            CloudQueue mainQueue,
            CloudQueue failedQueue)
        {
            await RunAsync<PoisonQueueProcessingApp>(async app =>
            {
                await app.ProcessPoisonItemAsync(
                    poisonQueueItem,
                    poisonQueue,
                    mainQueue,
                    failedQueue);
            });
        }

        protected override void ConfigureServices(
            IServiceCollection services,
            IConfiguration config)
        {
            var statTracApiClientConfig = config.GetSection("StatTracApiClient");
            services.AddStatTracApiClient(statTracApiClientConfig);

            services.AddClientCredentialsAuthenticationProvider(
                statTracApiClientConfig.GetSection("Authentication"));

            services.AddSingleton<IDateTimeService, DateTimeService>();

            services.AddTransient<PoisonQueueProcessingApp>();

            services.Configure<PoisonQueueProcessingOptions>(
                config.GetSection("PoisonQueueProcessing"));
        }
    }
}
