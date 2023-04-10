using System;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace Statline.Extensions.Configuration.AzureKeyVault
{
    /// <summary>
    /// Provides settings for client assertion certificate.
    /// </summary>
    /// <remarks>
    /// Read more about client assertion authentication here 
    /// https://azure.microsoft.com/en-us/documentation/articles/guidance-multitenant-identity-client-assertion/.
    /// </remarks>
    public class AzureKeyVaultCertificateSettings
    {
        /// <summary>
        /// Gets or sets the certificate store name.
        /// </summary>
        public StoreName StoreName { get; set; } = StoreName.My;

        /// <summary>
        /// Gets or sets the certificate store location.
        /// </summary>
        public StoreLocation StoreLocation { get; set; } = StoreLocation.CurrentUser;

        /// <summary>
        /// Gets or sets the certificate thumb-print used to 
        /// identify and find the certificate to be used for
        /// application authentication.
        /// </summary>
        public string Thumbprint { get; set; }

        /// <summary>
        /// Gets or sets the value which indicates whether the 
        /// certificate must be validated. Basically, that means
        /// that for self-signed certificates validation should 
        /// be disabled, and for trusted authority signed certificates
        /// should be enabled.
        /// </summary>
        public bool ShouldValidate { get; set; }
    }
}
