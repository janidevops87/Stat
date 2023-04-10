using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Statline.Common.Services;
using Statline.StatTrac.Api.Func.Infrastructure;
using Statline.StatTrac.Api.Func.Model;
using Statline.StatTrac.Api.Infrastructure.RestClient;
using Statline.StatTrac.Api.Infrastructure.RestClient.Model;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Func
{
    public class QueueProcessingFunction : FunctionBase
    {
        private static QueueProcessingFunction functionInstance;

        static QueueProcessingFunction()
        {
            // TODO: Verify this is called when function is unloaded.
            AppDomain.CurrentDomain.DomainUnload += (s, e) =>
            {
                functionInstance?.Dispose();
            };
        }

        public QueueProcessingFunction(
                   Microsoft.Azure.WebJobs.ExecutionContext executionContext)
                   : base(executionContext)
        {
        }

        [FunctionName("ReferralQueueProcessingFunction")]
        [return: Queue("referral-recycled")]
        public static async Task<ReferralQueueDto> Run(
            [QueueTrigger("referral")]ReferralQueueDto referralQueueDto,
            TraceWriter funcLogger,
            Microsoft.Azure.WebJobs.ExecutionContext context)
        {
            funcLogger.Info("Function started executing");

            LazyInitializer.EnsureInitialized(ref functionInstance, () =>
            {
                funcLogger.Info("Creating function singleton instance.");
                return new QueueProcessingFunction(context);
            });

            return await functionInstance.RunAsync(referralQueueDto);
        }

        private async Task<ReferralQueueDto> RunAsync(
            ReferralQueueDto referralQueueDto)
        {
            ReferralQueueDto referralQueueDtoToReturn = null;

            await RunAsync(async (config, serviceProvide) =>
            {
                var logger =
                    serviceProvide.GetRequiredService<ILogger<QueueProcessingFunction>>();

                var apiClient =
                    serviceProvide.GetRequiredService<IStatTracApiClient>();

                logger.LogQueueItem(referralQueueDto);

                // Forward received queue message to 
                // StatTrac referral processor API.
                //
                // TODO: Consider adding retry logic. Note however,
                // that on a crash Azure Function runtime will retry to
                // execute the function several times.
                var result = await apiClient.ProcessReferralAsync(
                    new ReferralInfo
                    {
                        ReferralId = referralQueueDto.ReferralId,
                        WebReportGroupId = referralQueueDto.WebReportGroupId
                    });

                logger.LogProcessingResult(result, referralQueueDto);

                if (result.ProcessingStatus == ReferralProcessingStatus.Recycled)
                {
                    referralQueueDtoToReturn = referralQueueDto;
                }
            });

            return referralQueueDtoToReturn;
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
        }
    }
}
