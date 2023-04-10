using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Extensions.DependencyInjection;

namespace Statline.Statrac.IdentityServerIntegration.App
{
    public static class ServiceCollectionExtensions
    {
        public static void AddStatracIdentityServerIntegrationApplication(
            this IServiceCollection services)
        {
            services.AddScoped<IdentityServerIntegrationApplication>();
        }
    }
}
