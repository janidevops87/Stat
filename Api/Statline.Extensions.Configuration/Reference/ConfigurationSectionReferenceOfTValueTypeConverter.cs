using System;
using System.ComponentModel;
using System.Globalization;
using Statline.Common.Utilities;

namespace Statline.Extensions.Configuration.Reference
{
    public class ConfigurationSectionReferenceOfTValueTypeConverter : TypeConverter
    {
        private readonly Type targetType;

        public ConfigurationSectionReferenceOfTValueTypeConverter(
            Type targetType)
        {
            if (targetType.IsGenericType &&
                targetType.IsConstructedGenericType &&
                targetType.GetGenericTypeDefinition() == typeof(ConfigurationSectionReference<>))
            {
                this.targetType = targetType;
            }
            else
            {
                throw new ArgumentException("Incompatible type", nameof(targetType));
            }
        }

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
                return Activator.CreateInstance(targetType, str);
            }

            return base.ConvertFrom(context, culture, value);
        }

    }
}
