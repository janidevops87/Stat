using MediatR;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Domain.Events;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model.Events;
using Statline.Statrac.IdentityServerIntegration.App;
using Statline.Statrac.IdentityServerIntegration.DomainEventHandlers;
using Statline.Statrac.IdentityServerIntegration.Infrastructure.Persistence.Ef;

namespace Statline.Statrac.IdentityServerIntegration
{
    public static class ServiceCollectionExtensions
    {
        public static void AddStatracIdentityServerIntegration(
            this IServiceCollection services,
            IConfiguration config,
            string databaseSettingsPath)
        {
            services.AddStatracIdentityServerIntegrationApplication();

            // Usually, MediatR handlers need not to be registered, 
            // they are found by assembly scanning. But we have
            // a complex event model with our own interfaces, so  
            // MediatR is not able to resolve them properly.
            // So we add our handler manually.
            //
            // TODO: investigate what to change in MediatR to support 
            // such scenario.
            services.AddTransient<
                INotificationHandler<MediatrDomainEventNotification<TenantClaimAdded>>,
                ClaimAddedDomainEventHandler>();

            services.AddTransient<
                INotificationHandler<MediatrDomainEventNotification<UserClaimAdded>>,
                ClaimAddedDomainEventHandler>();

            services.AddTransient<
               INotificationHandler<MediatrDomainEventNotification<ClientClaimAddedEvent>>,
               ClaimAddedDomainEventHandler>();

            services.AddEfConfigurationRepository(config, databaseSettingsPath);
        }
    }
}
