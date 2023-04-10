using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.Extensions.Options;
using Statline.Common.Infrastructure.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.DomainEventHandlers
{
    // TODO: Think how to get rid of MediatR dependency here.
    // This dependency brings other infrastructural dependencies
    // to this project, which is not good.
    public class UserRegistrationConfirmedEventHandler :
        INotificationHandler<IMediatrDomainEventNotification<UserRegistrationConfirmed>>
    {
        private readonly INotificationService notificationService;
        private readonly UserManagementApplicationOptions options;

        public UserRegistrationConfirmedEventHandler(
            INotificationService notificationService,
            IOptions<UserManagementApplicationOptions> options)
        {
            Check.NotNull(notificationService, nameof(notificationService));
            Check.NotNull(options, nameof(options));
            this.notificationService = notificationService;
            this.options = options.Value;
            this.options.Validate(nameof(options));
        }

        public async Task Handle(
            IMediatrDomainEventNotification<UserRegistrationConfirmed> notification, 
            CancellationToken cancellationToken)
        {
            await notificationService.SendNotificationAsync(
                notification.DomainEvent.UserEmail,
                options.UserActivatedNotification.Message,
                options.UserActivatedNotification.Subject);
        }
    }
}
