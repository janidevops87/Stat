using System.Collections.Generic;
using Registry.Common.Enums;

namespace Registry.Common.DTO
{
    public class RegistryVerificationRequest
    {
        private readonly Dictionary<VerificationSource, string> _enrollmentDateLabels = new Dictionary<VerificationSource, string>
        {
            {VerificationSource.Web, "Signature Date" },
            {VerificationSource.DLA, "Enrollment Date" },
            {VerificationSource.DMV, "Renewal Date" }
        };
        public int SourceID { get; set; }
        public VerificationSource Source { get; set; }
        public string EnrollmentDateLabel => _enrollmentDateLabels[Source];
        public string State { get; set; }
    }
}
