using System.Globalization;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.Extensions.Logging;
using Statline.Common.Infrastructure.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model.Events;
using Statline.Statrac.IdentityServerIntegration.App;

namespace Statline.Statrac.IdentityServerIntegration.DomainEventHandlers
{
    public class ClaimAddedDomainEventHandler :
        INotificationHandler<IMediatrDomainEventNotification<ClaimAddedEvent>>,
        INotificationHandler<IMediatrDomainEventNotification<ClientClaimAddedEvent>>
    {
        private readonly IdentityServerIntegrationApplication application;
        private readonly ILogger logger;

        public ClaimAddedDomainEventHandler(
            IdentityServerIntegrationApplication application,
            ILogger<ClaimAddedDomainEventHandler> logger)
        {
            Check.NotNull(application, nameof(application));
            Check.NotNull(logger, nameof(logger));
            this.application = application;
            this.logger = logger;
        }


        public async Task Handle(
            IMediatrDomainEventNotification<ClaimAddedEvent> notification,
            CancellationToken cancellationToken)
        {
            var domainEvent = notification.DomainEvent;

            var addedClaim = domainEvent.AddedClaim;

            await HandleCoreAsync(
                new System.Security.Claims.Claim(addedClaim.Type, addedClaim.Value));
        }

        public async Task Handle(
            IMediatrDomainEventNotification<ClientClaimAddedEvent> notification, 
            CancellationToken cancellationToken)
        {
            var domainEvent = notification.DomainEvent;

            var addedClaim = domainEvent.AddedClaim;

            await HandleCoreAsync(
                new System.Security.Claims.Claim(addedClaim.Type, addedClaim.Value));
        }
       
        private async Task HandleCoreAsync(System.Security.Claims.Claim addedClaim)
        {
            var isClaimOfInterest =
                addedClaim.Type == StatlineClaimTypes.WebReportGroupIdClaim;

            if (!isClaimOfInterest)
            {
                logger.LogClaimIsOutOfInterest(addedClaim);
                return;
            }
            else
            {
                logger.LogExpectedClaim(addedClaim);
            }

            if (TryParseId(addedClaim.Value, out int webReportGroupId))
            {
                logger.LogExtractedWebReportGroupId(webReportGroupId);

                await application.RegisterConfiguration(webReportGroupId);
            }
            else
            {
                logger.LogFailedToParseWebReportGroupId(addedClaim);
            }
        }

        private static bool TryParseId(string str, out int id)
        {
            return int.TryParse(
                str,
                // This does not allow signs (+/-)
                NumberStyles.AllowLeadingWhite | NumberStyles.AllowTrailingWhite,
                CultureInfo.InvariantCulture,
                out id);
        }
    }
}
