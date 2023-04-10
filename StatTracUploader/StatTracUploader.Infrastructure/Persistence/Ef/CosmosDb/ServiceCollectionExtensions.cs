using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Options;
using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.CosmosDb
{
    public static class ServiceCollectionExtensions
    {
        public static void AddEfCosmosDbReferralUploadRepository(
            this IServiceCollection services,
            IConfiguration config)
        {
            services.Configure<CosmosDbContextOptions>(config);

            services.AddDbContext<CosmosReferralDbContext>(
                (sp, o) =>
                {
                    var options = sp.GetRequiredService<IOptionsMonitor<CosmosDbContextOptions>>();

                    var optionsValue = options.CurrentValue;
                    var cosmosDbOptions = optionsValue.CosmosDbOptions;

                    o.UseCosmos(
                        cosmosDbOptions.AccountEndpoint.ToString(),
                        cosmosDbOptions.AccountKey,
                        cosmosDbOptions.DatabaseName)
                    .EnableDetailedErrors(optionsValue.EnableDetailedErrors)
                    .EnableSensitiveDataLogging(optionsValue.EnableSensitiveDataLogging);
                });

            services.TryAddScoped<IReferralUploadRepository, ReferralUploadRepository<CosmosReferralDbContext>>();
        }
    }
}
