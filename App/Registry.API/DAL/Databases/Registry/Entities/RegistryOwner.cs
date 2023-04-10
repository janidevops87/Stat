using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Registry.Entities
{
    [Table("RegistryOwner")]
    public class RegistryOwner
    {
        public RegistryOwner()
        {
            RegistryOwnerUserOrgs = new HashSet<RegistryOwnerUserOrg>();
            RegistryOwnerElectronicSignatureTexts = new HashSet<RegistryOwnerElectronicSignatureText>();
            RegistryOwnerStateConfigs = new List<RegistryOwnerStateConfig>();
        }

        [Key]
        public int RegistryOwnerId { get; set; }
        [StringLength(255)]
        public string RegistryOwnerName { get; set; }
        [StringLength(50)]
        public string RegistryOwnerRouteName { get; set; }
        public bool? AllowDisplayNoDonors { get; set; }
        public bool IDologyActive { get; set; }
        public bool IdologyActiveInPortal { get; set; }
        [StringLength(200)]
        public string IDologyLogin { get; set; }
        [StringLength(200)]
        public string IDologyPassword { get; set; }
        [StringLength(200)]
        public string IDologySpLogin { get; set; }
        [StringLength(200)]
        public string IDologySpPassword { get; set; }
        [StringLength(50)]
        public string CertificateSigningHashAlgorithm { get; set; }
        [StringLength(200)]
        public string CertificateSubject { get; set; }
        public bool CaptchaOn { get; set; }

        public ICollection<RegistryOwnerUserOrg> RegistryOwnerUserOrgs { get; set; }
        public ICollection<RegistryOwnerElectronicSignatureText> RegistryOwnerElectronicSignatureTexts { get; set; }
        public ICollection<RegistryOwnerStateConfig> RegistryOwnerStateConfigs { get; set; }
    }
}
