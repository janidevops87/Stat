using System.Collections.Generic;
using System.Xml.Serialization;

namespace Registry.Common.Idology
{
	public class Qualifiers
	{
		[XmlElement("qualifier")]
		public List<Qualifier> Qualifier { get; set; }
	}
}