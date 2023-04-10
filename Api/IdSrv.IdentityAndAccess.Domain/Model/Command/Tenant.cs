using System;
using System.Collections.Generic;
using Statline.Common.Domain.Entities;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public sealed class Tenant : Entity
    {
        private readonly List<Claim> userClaims = new List<Claim>();

        // NOTE: The id is stored as a primitive type 
        // instead of strong type (TenantId) because
        // storage technologies (as of now) don't support
        // mapping complex types to primary keys.
        // Things are expected to change with EF Core 2.1 release:
        // https://docs.microsoft.com/en-us/ef/core/modeling/value-conversions
        public int Id { get; private set; }

        public string OrganizationName { get; private set; }
        public IEnumerable<Claim> UserClaims => userClaims.AsReadOnly();

        public Tenant(
            TenantId id,
            string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));

            Id = id?.Value ?? default;
            OrganizationName = organizationName;
        }

        private Tenant()
        {
        }

        public void RegisterUser(User user)
        {
            Check.NotNull(user, nameof(user));

            if (user.TenantId == Id)
            {
                throw new InvalidOperationException(
                    $"The user with id '{user.Id}' is already " +
                    $"in the tenant with id '{Id}'.");
            }

            user.AssignTenantId(this.Id);
        }

        public void AddUserClaim(Claim userClaim)
        {
            Check.NotNull(userClaim, nameof(userClaim));

            userClaims.Add(userClaim);

            AddDomainEvent(new TenantClaimAdded(Id, userClaim));
        }

        public void RemoveUserClaim(Claim userClaim)
        {
            Check.NotNull(userClaim, nameof(userClaim));

            userClaims.Remove(userClaim);

            AddDomainEvent(new TenantClaimRemoved(Id, userClaim));
        }
    }
}
