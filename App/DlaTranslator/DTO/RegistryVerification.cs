using System;
using System.Linq;

namespace Registry.Common.DTO
{
    public class RegistryVerification
    {
        public string VerificationFullName { get; set; }
        public string VerificationDOB { get; set; }
        public string VerificationResidentialAddress { get; set; }
        public string VerificationCityStateZip { get; set; }
        public string VerificationLimitations { get; set; }
        public string VerificationSignatureDate { get; set; }
        public string VerificationStateID { get; set; }
        public string VerificationComment { get; set; }

        public string VerificationDate => VerificationSignatureDate.Split(new[] { ": " }, StringSplitOptions.RemoveEmptyEntries).Last().Split(' ').First();

        public string VerificationID => VerificationStateID.Split(new[] { "# " }, StringSplitOptions.RemoveEmptyEntries).Last();
    }
}
