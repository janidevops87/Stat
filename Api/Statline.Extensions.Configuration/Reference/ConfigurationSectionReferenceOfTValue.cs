using System.ComponentModel;
using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Statline.Extensions.Configuration.Reference
{
    [TypeConverter(typeof(ConfigurationSectionReferenceOfTValueTypeConverter))]
    public class ConfigurationSectionReference<TValue> : ConfigurationSectionReference
    {
        public ConfigurationSectionReference(string sectionPath)
            : base(sectionPath)
        {
        }

        public TValue GetValue(IConfiguration parent)
        {
            Check.NotNull(parent, nameof(parent));
            return Resolve(parent).Get<TValue>();
        }
    }
}
