using System;
using IdentityServer4.Models;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.Common.Security
{
    internal static class ClientExtensions
    {
        public static readonly string TenantIdPropertyKey =
            IdentityServerConfig.Domain.Model.ClientExtensions.TenantIdPropertyKey;

        /// <summary>
        /// Provides a shortcut to obtain Tenant Id from <see cref="Client.Properties"/>.
        /// </summary>
        /// <param name="client">The client.</param>
        /// <returns>The Tenant Id.</returns>
        public static int GetTenantId(this Client client)
        {
            Check.NotNull(client, nameof(client));

            var tenantIdProperty = client.FindTenantIdProperty();

            if (tenantIdProperty == null)
            {
                throw new InvalidOperationException(
                    $"Tenant ID is not assigned to client '{client.ClientName}'.");
            }

            return Convert.ToInt32(tenantIdProperty);
        }

        private static string FindTenantIdProperty(this Client client)
        {
            client.Properties.TryGetValue(TenantIdPropertyKey, out var value);
            return value;
        }
    }
}
