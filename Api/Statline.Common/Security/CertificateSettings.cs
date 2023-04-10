using System.Security.Cryptography.X509Certificates;

namespace Statline.Common.Security
{
    public class CertificateSettings
    {
        public StoreName StoreName { get; set; }
        public StoreLocation StoreLocation { get; set; }
        public string Thumbprint { get; set; }
        public bool ShouldValidate { get; set; }
    }
}