namespace Statline.Extensions.Configuration.AzureKeyVault
{
    /// <summary>
    /// Holds settings for Azure KeyVault configuration source.
    /// This class can be conveniently bound to a configuration section
    /// of any other configuration source.
    /// </summary>
    public class AzureKeyVaultSettings
    {
        /// <summary>
        /// Gets or sets the application ID obtained after
        /// registering the application in the Azure Active Directory.
        /// </summary>
        public string AppClientId { get; set; }
        
        /// <summary>
        /// Gets or sets the name of the Azure KeyVault.
        /// </summary>
        public string VaultName { get; set; }
        
        /// <summary>
        /// Gets or sets the settings for a client certificate used to 
        /// authenticate the application to the Azure AD.
        /// </summary>
        public AzureKeyVaultCertificateSettings Certificate { get; set; }
    }
}
