using Microsoft.Extensions.Configuration;
using Statline.Common.Security;
using Statline.Common.Utilities;

namespace Statline.Extensions.Configuration.AzureKeyVault
{
    public static class AzureKeyVaultConfigurationExtensions
    {
        /// <summary>
        /// Add Azure KeyVault configuration provider to the 
        /// configuration builder.
        /// </summary>
        /// <param name="configurationBuilder">The configuration builder.</param>
        /// <param name="settings">
        /// The Azure KeyVault settings providing
        /// KeyVault name, authentication certificate information etc.
        /// </param>
        /// <param name="prefixSection">
        /// Specifies a prefix section which can be used to
        /// distinguish secret names by application in a shared key vault.
        /// </param>
        /// <remarks>
        /// <para>
        /// About <paramref name="prefixSection"/>.
        /// 
        /// For example, you may have a secret name (configuration path)
        /// like "Azure--DocumentDB--AuthKey". First, this name doesn't help
        /// to identify the application which uses it. Second, several 
        /// applications, sharing the same key vault, may have the same path 
        /// for the secret in their configurations, but with different values.
        /// In this case, within app's config such path is pretty clear,
        /// but in the key vault there will be secret name collision.
        /// And adding some root section in each app config is not good
        /// way to solve this, since it will make configs less readable.
        /// 
        /// Solution: For each secret name in the key vault add a prefix
        /// section like this: "MyApp--Azure--DocumentDB--AuthKey".
        /// "MyApp" is the prefix, and it clearly scopes the secret to a particular
        /// application. Then, when adding the key vault provider to the 
        /// configuration builder, specify the prefix section to be used, 
        /// and that's it.
        /// </para>
        /// </remarks>
        public static IConfigurationBuilder AddAzureKeyVault(
           this IConfigurationBuilder configurationBuilder,
           AzureKeyVaultSettings settings,
           string prefixSection = null)
        {
            Check.NotNull(configurationBuilder, nameof(configurationBuilder));
            Check.NotNull(settings, nameof(settings));
            Check.NotNull(settings.Certificate, nameof(settings), nameof(settings.Certificate));

            var cert = CertificateUtility.FindCertificateByThumbprint(
                settings.Certificate.StoreName,
                settings.Certificate.StoreLocation,
                settings.Certificate.Thumbprint,
                settings.Certificate.ShouldValidate);

            configurationBuilder.AddAzureKeyVault(
                settings.VaultName,
                settings.AppClientId,
                cert,
                new PrefixedKeyVaultSecretManager(prefixSection));

            return configurationBuilder;
        }
    }
}
