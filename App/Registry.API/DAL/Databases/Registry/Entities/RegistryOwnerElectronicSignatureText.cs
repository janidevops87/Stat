using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Registry.Entities
{
    [Table("RegistryOwnerElectronicSignatureText")]
    public class RegistryOwnerElectronicSignatureText
    {
        [Key]
        public int Id { get; set; }

        public string EmailFrom { get; set; }

        public string EmailMailboxAccount { get; set; }

        public string LanguageCode { get; set; }

        public int RegistryOwnerID { get; set; }

        public string CertificateAuthority { get; set; }

        [ForeignKey("RegistryOwnerID")]
        public RegistryOwner RegistryOwner { get; set; }
    }
}
