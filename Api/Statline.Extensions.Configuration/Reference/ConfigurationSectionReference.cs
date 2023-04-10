using System.ComponentModel;
using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Statline.Extensions.Configuration.Reference
{
    [TypeConverter(typeof(ConfigurationSectionReferenceTypeConverter))]
    public class ConfigurationSectionReference
    {
        public string SectionPath { get; }

        public ConfigurationSectionReference(string sectionPath)
        {
            Check.NotEmpty(sectionPath, nameof(sectionPath));
            SectionPath = sectionPath;
        }

        public IConfigurationSection Resolve(IConfiguration parent)
        {
            Check.NotNull(parent, nameof(parent));
            return parent.GetSection(SectionPath);
        }
    }
}
