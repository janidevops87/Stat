using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;
using Statline.StatTrac.Api.Infrastructure.Http;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class AuthenticationProviderServiceCollectionExtensions
    {
        public static void AddClientCredentialsAuthenticationProvider(
            this IServiceCollection services,
            IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            services.Configure<ClientCredentialsAuthenticationOptions>(config);
            services.AddSingleton<
                IAuthenticationProvider, 
                ClientCredentialsAuthenticationProvider>();
        }
    }
}
