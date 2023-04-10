using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Statline.StatTrac.Infrastructure.Persistence.Composite;

public static class ServiceCollectionExtensions
{
    public static void AddCompositeReferralRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));

        // TODO: Use Autofac to add this repository decorator as, well, a decorator.
        // services.AddScoped<IReferralRepository, CachingReferralRepositoryDecorator>();
        throw new NotImplementedException();
    }
}
