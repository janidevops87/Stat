// NOTE: This is commented out to remove dependency on SqlServer-related 
// packages while we're not using this code. Still I want to preserve this code
// for now as a sample.

//using Microsoft.Extensions.Configuration;
//using Microsoft.Extensions.DependencyInjection;
//using Microsoft.Extensions.DependencyInjection.Extensions;
//using Statline.Common.Services;
//using Statline.Common.Utilities;
//using Statline.StatTracUploader.App.Processor;
//using Statline.StatTracUploader.Infrastructure.Services;

//namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.DirectDbConnection.SqlServer
//{
//    public static class ServiceCollectionExtensions
//    {
//        public static void AddSqlMainRepositoryStatusProvider(
//          this IServiceCollection services,
//           IConfiguration config,
//           string mainRepositorySettings)
//        {
//            Check.NotNull(services, nameof(services));
//            Check.NotNull(config, nameof(config));

//            // TODO: Think how to make all this configuration
//            // more straightforward. Consider using additional 
//            // aggregating options class.

//            services.Configure<HostServiceWorkerOptions>(config.GetSection(mainRepositorySettings));

//            services
//                .AddOptions<DirectDbConnectionMainRepositoryStatusProviderOptions>()
//                .ValidateDataAnnotations()
//                .Configure(opt =>
//                    {
//                        var dbSettings = config.GetSqlDatabaseSettings(
//                            mainRepositorySettings + ConfigurationPath.KeyDelimiter + "Database");
//                        opt.ConnectionString = dbSettings.ConnectionString;
//                    });

//            services.AddHostedService<HostServiceWorker>();
//            services.TryAddSingleton<IDatabaseHealthChecker, SqlServerHealthChecker>();
//            services.TryAddSingleton<IMainRepositoryStatusProvider, DirectDbConnectionMainRepositoryStatusProvider>();
//            services.TryAddSingleton<IDateTimeService, DateTimeService>();
//        }
//    }
//}
