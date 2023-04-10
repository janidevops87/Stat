using IdentityServer4.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;

namespace Statline.IdentityServer.Helper
{
    public static class IdentityServerBuilderExtensionsInMemory
    {
        private class ClaimDto
        {
            public string Type { get; set; }
            public string Value { get; set; }
            public string ValueType { get; set; }
            public string Issuer { get; set; }
            public string OriginalIssuer { get; set; }
        }

        /// <summary>
        /// Adds the in memory clients from a configuration.
        /// This particular method handles loading claims while <see cref="Claim"/>
        /// type is immutable and cant be deserialized implicitly.
        /// </summary>
        /// <param name="builder">The builder.</param>
        /// <param name="section">The configuration section containing the configuration data.</param>
        /// <returns>The builder.</returns>
        public static IIdentityServerBuilder AddInMemoryClientsWithClamis(
            this IIdentityServerBuilder builder,
            IConfigurationSection section)
        {
            Check.NotNull(builder, nameof(builder));

            var clients = GetClientsWithClaimsFromConfig(section);

            if (clients == null)
            {
                return builder;
            }

            builder.AddInMemoryClients(clients);

            return builder;
        }

        internal static IEnumerable<Client> GetClientsWithClaimsFromConfig(
            IConfigurationSection section)
        {
            Check.NotNull(section, nameof(section));

            var clients = section.Get<Client[]>();

            if (clients == null)
            {
                return null;
            }

            for (int i = 0; i < clients.Length; i++)
            {
                var claimDtos = section.GetSection(
                    FormattableString.Invariant($"{i}:Claims")).Get<ClaimDto[]>();

                if (claimDtos == null)
                {
                    // No Claims section.
                    continue;
                }

                var claims = claimDtos.Select(dto => new Claim(
                    dto.Type,
                    dto.Value,
                    dto.ValueType,
                    dto.Issuer,
                    dto.OriginalIssuer));

                clients[i].Claims.Add(claims);
            }

            return clients;
        }
    }
}
