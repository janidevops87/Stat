using System.Collections.Generic;
using System.Xml.Serialization;

namespace Registry.Common.Idology
{
	public class Questions
	{
		[XmlElement("question")]
		public List<Question> Question { get; set; }
	}
}