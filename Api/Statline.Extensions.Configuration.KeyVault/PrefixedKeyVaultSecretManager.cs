using System;
using Microsoft.Azure.KeyVault.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.AzureKeyVault;

namespace Statline.Extensions.Configuration.AzureKeyVault
{
    internal class PrefixedKeyVaultSecretManager : DefaultKeyVaultSecretManager
    {
        private readonly string prefixSection;

        public PrefixedKeyVaultSecretManager(string prefixSection = null)
        {
            if (string.IsNullOrWhiteSpace(prefixSection))
            {
                this.prefixSection = string.Empty;
            }
            else
            {
                if (prefixSection.Contains(ConfigurationPath.KeyDelimiter))
                {
                    throw new ArgumentException(
                        "Prefix must not contain section key delimiter.",
                        nameof(prefixSection));
                }

                this.prefixSection = prefixSection + ConfigurationPath.KeyDelimiter;
            }
        }

        public override string GetKey(SecretBundle secret)
        {
            var key = base.GetKey(secret);

            if (key.StartsWith(prefixSection, StringComparison.OrdinalIgnoreCase))
            {
                key = key.Substring(prefixSection.Length);
            }

            return key;
        }
    }
}
