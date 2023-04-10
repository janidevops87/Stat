using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb;
using Statline.Common.Utilities;
using Statline.StatTrac.App.ReferralProcessor;

namespace Statline.StatTrac.Infrastructure.Persistence.DocumentDb;

public static class ServiceCollectionExtensions
{
    public static void AddDocumentDbUpdatedReferralRepository(
        this IServiceCollection services,
        IConfiguration config)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(config, nameof(config));

        services.Configure<DocumentDbOptions>(config);

        services.AddDocumentDbUpdatedReferralRepository();
    }

    public static void AddDocumentDbUpdatedReferralRepository(
       this IServiceCollection services,
       Action<DocumentDbOptions> configureOptions)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(configureOptions, nameof(configureOptions));

        services.Configure(configureOptions);

        services.AddDocumentDbUpdatedReferralRepository();
    }

    private static void AddDocumentDbUpdatedReferralRepository(this IServiceCollection services)
    {
        // Its important to share the context between the requests
        // for sharing connections and other stuff.
        services.AddSingleton<IDocumentDbContext<ReferralDto>, DocumentDbContext<ReferralDto>>();

        // The repository is added as scoped in particular to force
        // calling IWebReportGroupIdAccessor no rarer than on 
        // every request (which creates a scope) so every request
        // gets correct WebReportGroupId.
        services.AddScoped<IUpdatedReferralRepository, DocumentDbUpdatedReferralRepository>();
    }
}
