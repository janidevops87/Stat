using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace Registry.Common.Extensions
{
    public static class EnumHelper
    {
        public static string DisplayValue<TEnum>(string enumName)
        {
            var displayValue = enumName;
            var field = typeof(TEnum).GetField(enumName);
            var display = ((DisplayAttribute[])field.GetCustomAttributes(typeof(DisplayAttribute), false)).FirstOrDefault();

            if (display != null)
            {
                displayValue = display.Name;
            }

            return displayValue;
        }

        public static string DisplayValue<TEnum>(this TEnum enumValue)
        {
            return DisplayValue<TEnum>(enumValue.ToString());
        }
    }

}
