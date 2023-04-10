using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Processor;
using Statline.StatTracUploader.App.Uploader;
using Statline.StatTracUploader.Infrastructure.FileParsers.Excel;
using Statline.StatTracUploader.Infrastructure.Hosting.Processor;
using Statline.StatTracUploader.Infrastructure.Persistence.Ef.SqlServer;
using Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.StatTracApi;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi;
using Statline.StatTracUploader.Infrastructure.Services;
using Statline.StatTracUploader.Infrastructure.Services.Notification.MailKit;

namespace Statline.StatTracUploader
{
    public static class ServiceCollectionExtensions
    {
        public static void AddCommonAppServices(
            this IServiceCollection services,
            IConfiguration rootConfig)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(rootConfig, nameof(rootConfig));

            services.TryAddSingleton<IDateTimeService, DateTimeService>();

            services.AddEfSqlServerTempReferralRepository(rootConfig, "ReferralTempStorage:EfSqlServer");

            // Uncomment to switch to Cosmos
            // repository implementation. Also comment out
            // SQL Server implementation registration above.
            // TODO: Consider checking config section existence to decide
            // which implementation to add.
            //services.AddEfCosmosDbTempReferralRepository(rootConfig.GetSection("ReferralTempStorage:EfCosmosDb"));

            services.AddStatTracApiMainRepositoryStatusProvider(rootConfig.GetSection("ReferralMainStorage"));
        }

        public static void AddPendingReferralsProcessorAppAndDependencies(
            this IServiceCollection services,
            IConfiguration rootConfig)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(rootConfig, nameof(rootConfig));

            services.AddMailKitNotificationService(rootConfig, "ReferralProcessor:Notification");
            services.AddStatTracApiMainRepositories();
            services.AddPendingReferralsProcessorBackgroundService(rootConfig.GetSection("ReferralProcessor"));
            services.AddPendingReferralsProcessorApp(rootConfig.GetSection("ReferralProcessor"));
        }


        public static void AddReferralUploaderAppAndDependencies(
            this IServiceCollection services,
            IConfiguration rootConfig)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(rootConfig, nameof(rootConfig));
           
            services.AddExcelReferralFileParser(rootConfig.GetSection("ExcelReferralFileParser"));

            services.AddScoped<ReferralUploaderApp>();
        }
    }
}
