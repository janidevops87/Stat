using Statline.Common.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events
{
    public class UserRegistrationConfirmed : DomainEvent
    {
        public UserRegistrationConfirmed(
            TenantId tenantId,
            UserId userId, 
            string userEmail)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            Check.NotNull(userId, nameof(userId));
            Check.NotEmpty(userEmail, nameof(userEmail));
            TenantId = tenantId;
            UserId = userId;
            UserEmail = userEmail;
        }

        public TenantId TenantId { get; }
        public UserId UserId { get; }
        public string UserEmail { get; }
    }
}
