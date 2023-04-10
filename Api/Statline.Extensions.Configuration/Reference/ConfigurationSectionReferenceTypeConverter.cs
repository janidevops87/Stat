using System;
using System.ComponentModel;
using System.Globalization;
using Statline.Common.Utilities;

namespace Statline.Extensions.Configuration.Reference
{
    public class ConfigurationSectionReferenceTypeConverter : TypeConverter
    {
        public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
        {
            Check.NotNull(sourceType, nameof(sourceType));

            if (sourceType == typeof(string))
            {
                return true;
            }

            return base.CanConvertFrom(context, sourceType);
        }

        public override object ConvertFrom(
            ITypeDescriptorContext context,
            CultureInfo culture,
            object value)
        {
            if (value is string str)
            {
                return new ConfigurationSectionReference(str);
            }

            return base.ConvertFrom(context, culture, value);
        }
    }
}
