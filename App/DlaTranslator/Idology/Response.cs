using System.Collections.Generic;
using System.Xml.Serialization;
using Registry.Common.Enums;

namespace Registry.Common.Idology
{
    [XmlRoot(ElementName = "response")]
    public class Response
    {
        private const string SUCCESS = "id.success";
        private const string PASS = "pass";

        [XmlElement(ElementName = "id-number")]
        public string IdNumber { get; set; }

        [XmlElement(ElementName = "summary-result")]
        public SummaryResult SummaryResult { get; set; }

        [XmlElement("results")]
        public Results Results { get; set; }

        [XmlElement("qualifiers")]
        public Qualifiers Qualifiers { get; set; }

        [XmlElement("differentiator-question")]
        public DifferentiatorQuestion DifferentiatorQuestion { get; set; }

        [XmlElement("questions")]
        public Questions Questions { get; set; }

        [XmlElement("error")]
        public List<string> error { get; set; }

        [XmlElement(ElementName = "iq-summary-result")]
        public string IqSummaryResult { get; set; }

        public RegistryApiError ResponseType
        {
            get
            {
                if (DifferentiatorQuestion != null)
                {
                    return RegistryApiError.DifferentiatorQuestion;
                }
                if ((Questions != null) && (Questions.Question != null) && (Questions.Question.Count > 0))
                {
                    return RegistryApiError.SecurityQuestion;
                }
                if ((SummaryResult != null) && (!SummaryResult.key.Equals(SUCCESS, System.StringComparison.OrdinalIgnoreCase)))
                {
                    return RegistryApiError.VerificationFailed;
                }
                if ((IqSummaryResult != null) && (!IqSummaryResult.Equals(PASS, System.StringComparison.OrdinalIgnoreCase)))
                {
                    return RegistryApiError.VerificationFailed;
                }

                return RegistryApiError.NoError;
            }
        }
    }
}
