using System.Collections.Generic;
using System.Xml.Serialization;

namespace Registry.Common.Idology
{
    public class DifferentiatorQuestion
    {
        [XmlElement("prompt")]
        public string Prompt { get; set; }

        [XmlElement("type")]
        public string Type { get; set; }

        [XmlElement("answer")]
        public List<string> Answer { get; set; }

        public string SelectedAnswer { get; set; }
    }
}
