using System;
using System.Collections.Generic;
using IdentityServer4.EntityFramework.Entities;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model
{
    public static class ClientExtensions
    {
        public static readonly string TenantIdPropertyKey = "TenantId";

        /// <summary>
        /// Provides a shortcut to obtain Tenant Id from <see cref="Client.Properties"/>.
        /// </summary>
        /// <param name="client">The client.</param>
        /// <returns>The Tenant Id.</returns>
        public static TenantId GetTenantId(this Client client)
        {
            Check.NotNull(client, nameof(client));

            var tenantIdProperty = client.FindTenantIdProperty();

            if (tenantIdProperty == null)
            {
                throw new InvalidOperationException(
                    $"Tenant ID is not assigned to client '{client.ClientName}'.");
            }

            // TODO: Replace with something like TenantId.Parse(id).
            return Convert.ToInt32(tenantIdProperty.Value);
        }

        /// <summary>
        /// Provides a shortcut to set Tenant Id to <see cref="Client.Properties"/>.
        /// </summary>
        /// <param name="client">The client.</param>
        /// <param name="tenantId">The Tenant Id.</param>
        public static void SetTenantId(this Client client, TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            Check.NotNull(client, nameof(client));

            if (client.Properties == null)
            {
                client.Properties = new List<ClientProperty>(capacity: 1);
            }

            var tenantIdProperty = client.FindTenantIdProperty();

            if (tenantIdProperty == null)
            {
                tenantIdProperty = new ClientProperty
                {
                    Key = TenantIdPropertyKey,
                    Client = client
                };

                client.Properties.Add(tenantIdProperty);
            }

            tenantIdProperty.Value = tenantId.ToString();
        }

        private static ClientProperty FindTenantIdProperty(this Client client)
        {
            return client.Properties.Find(p =>
                            string.Equals(p.Key, TenantIdPropertyKey, StringComparison.Ordinal));
        }
    }
}
