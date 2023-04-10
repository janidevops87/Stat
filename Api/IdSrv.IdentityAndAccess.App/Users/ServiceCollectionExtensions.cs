using MediatR;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Users.DomainEventHandlers;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users
{
    public static class ServiceCollectionExtensions
    {
        public static void AddUserManagementApplication(
            this IServiceCollection services,
            IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            var appConfig = config.GetSection("UserManagementOptions");

            services.Configure<UserManagementApplicationOptions>(appConfig);
            services.AddScoped<UserManagementApplication>();

            services.AddTransient<
                INotificationHandler<MediatrDomainEventNotification<UserRegistrationConfirmed>>,
                UserRegistrationConfirmedEventHandler>();
        }

        public static void AddUserQueryApplication(
           this IServiceCollection services)
        {
            Check.NotNull(services, nameof(services));
            services.AddScoped<UserQueryApplication>();
        }
    }
}
