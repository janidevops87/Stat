using System;
using System.Security.Cryptography.X509Certificates;
using Statline.Common.Utilities;

namespace Statline.Common.Security
{
    /// <summary>
    /// Utility class to find certs and export them into byte arrays.
    /// </summary>
    public static class CertificateUtility
    {
        /// <summary>
        /// Finds the cert having thumbprint supplied from store location specified 
        /// in the <paramref name="certificateSettings"/>.
        /// </summary>
        public static X509Certificate2 FindCertificateByThumbprint(
            CertificateSettings certificateSettings)
        {
            Check.NotNull(certificateSettings, nameof(certificateSettings));

            return FindCertificateByThumbprint(
                certificateSettings.StoreName,
                certificateSettings.StoreLocation,
                certificateSettings.Thumbprint,
                certificateSettings.ShouldValidate);
        }

        /// <summary>
        /// Finds the cert having thumbprint supplied from store location supplied.
        /// </summary>
        public static X509Certificate2 FindCertificateByThumbprint(
            StoreName storeName,
            StoreLocation storeLocation,
            string thumbprint,
            bool validationRequired)
        {
            Check.NotEmpty(thumbprint, nameof(thumbprint));

            using (var store = new X509Store(storeName, storeLocation))
            {
                store.Open(OpenFlags.ReadOnly);

                var certs = store.Certificates.Find(
                    X509FindType.FindByThumbprint,
                    thumbprint,
                    validationRequired);

                if (certs == null || certs.Count == 0)
                {
                    throw new ArgumentException(
                        $"Certificate with thumbprint '{thumbprint}' was not found in store.");
                }

                return certs[0];
            }
        }
    }
}
