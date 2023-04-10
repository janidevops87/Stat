using Autofac;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.JsonFile;

public static class AutofacContainerBuilderExtensions
{
    public static void AddJsonFileReferralOutputNamed(
        this ContainerBuilder container,
        IConfiguration configuration,
        string name)
    {
        // Options DI is based on IServiceProvider, so we have to mix it with Autofac.
        container.PopulateFromServices(services =>
        {
            services.ConfigureWithDataAnnotationValidation<JsonFileReferralOutputOptions>(
                configuration,
                name);
        });

        // Autofac has way more flexible support for open generics,
        // so using Autofac here.
        container
            .RegisterGenericWithNamedOptions<JsonFileReferralOutputOptions>(
                typeof(JsonFileReferralOutput<>), name)
            .As(typeof(IReferralOutput<>))
            .InstancePerDependency();
    }
}