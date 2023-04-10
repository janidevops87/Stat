using Statline.StatTracUploader.Infrastructure.FileParsers.Common;
using System;
using System.Collections.Generic;
using System.Globalization;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel.Extensions
{
    internal static class NamedValuesDictionaryExtensions
    {
        public static int GetRequiredInteger(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            int? intValue = definedNameValues.GetOptionalInteger(valueName);

            if (intValue is null)
            {
                throw new ReferralFileParserException(
                    $"Required integer value with name '{valueName}' is not defined.");
            }

            return intValue.Value;
        }

        public static int? GetOptionalInteger(
          this Dictionary<string, string?> definedNameValues,
          string valueName)
        {
            var formattedInt = definedNameValues.GetValueOrDefault(valueName);

            if (formattedInt is null)
            {
                return null;
            }

            if (!int.TryParse(
                    formattedInt,
                    NumberStyles.Integer,
                    NumberFormatInfo.InvariantInfo,
                    out var intValue))
            {
                throw new ReferralFileParserException(
                    $"Can't parse value '{formattedInt}' with name '{valueName}' as integer number.");
            }
            else
            {
                return intValue;
            }
        }

        public static float? GetOptionalFloat(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            var formattedFloat = definedNameValues.GetValueOrDefault(valueName);

            if (formattedFloat is null)
            {
                return null;
            }

            if (!float.TryParse(
                    formattedFloat,
                    NumberStyles.Float,
                    NumberFormatInfo.InvariantInfo,
                    out var floatValue))
            {
                throw new ReferralFileParserException(
                    $"Can't parse value '{formattedFloat}' with name '{valueName}' as floating point number.");
            }
            else
            {
                return floatValue;
            }
        }

        public static string GetRequiredString(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            string? stringValue = definedNameValues.GetOptionalString(valueName);

            if (stringValue is null)
            {
                throw new ReferralFileParserException(
                    $"Required string value with name '{valueName}' is not defined.");
            }

            return stringValue;
        }

        public static string? GetOptionalString(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            return definedNameValues.GetValueOrDefault(valueName);
        }

        /// <summary>
        /// Gets date and time from separate values, where either date, time 
        /// or both are optional.
        /// </summary>
        public static DateTime? GetOptionalDateOptionalTime(
            this Dictionary<string, string?> definedNameValues,
            string dateValueName,
            string timeValueName)
        {
            return MergeDateTime(
                date: definedNameValues.GetOptionalDateTime(dateValueName),
                time: definedNameValues.GetOptionalDateTime(timeValueName));
        }

        /// <summary>
        /// Gets date and time from separate values, where date and time 
        /// must be BOTH present to get non-null value.
        /// </summary>
        public static DateTime? GetOptionalDateTime(
            this Dictionary<string, string?> definedNameValues,
            string dateValueName,
            string timeValueName)
        {
            var date = definedNameValues.GetOptionalDateTime(dateValueName);

            if (date is null)
            {
                return null;
            }

            var time = definedNameValues.GetOptionalDateTime(timeValueName);

            if (time is null)
            {
                return null;
            }

            return MergeDateTime(date, time);
        }

        /// <summary>
        /// Gets date and time from separate values. Date and time 
        /// can be BOTH be absent, otherwise at least date must be present.
        /// If only time is provided, it's ignored and <c>null</c> is returned.
        /// </summary>
        public static DateTime? GetOptionalDateTimeWithIgnoringTimeOnly(
            this Dictionary<string, string?> definedNameValues,
            string dateValueName,
            string timeValueName)
        {
            var date = definedNameValues.GetOptionalDateTime(dateValueName);
            var time = definedNameValues.GetOptionalDateTime(timeValueName);

            if (time is null)
            {
                return date;
            }

            if (date is null)
            {
                return null;
            }

            return MergeDateTime(date, time);
        }

        public static DateTime GetRequiredDateTime(
            this Dictionary<string, string?> definedNameValues,
            string dateValueName,
            string timeValueName)
        {
            return MergeDateTime(
                date: definedNameValues.GetRequiredDateTime(dateValueName),
                time: definedNameValues.GetRequiredDateTime(timeValueName));
        }

        public static DateTime GetRequiredDateTime(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            DateTime? dateTimeValue = definedNameValues.GetOptionalDateTime(valueName);

            if (dateTimeValue is null)
            {
                throw new ReferralFileParserException(
                    $"Required date/time value with name '{valueName}' is not defined.");
            }

            return dateTimeValue.Value;
        }

        public static DateTime? GetOptionalDateTime(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            var formattedOADate = definedNameValues.GetValueOrDefault(valueName);

            if (formattedOADate is null)
            {
                return null;
            }

            try
            {
                return ConvertHelper.ParseDateTime(formattedOADate);
            }
            catch (ReferralFileParserException ex)
            {
                throw new ReferralFileParserException(
                    $"Can't parse value '{formattedOADate}' with name '{valueName}' as date/time.", ex);
            }
        }

        public static bool GetOptionalBoolean(
           this Dictionary<string, string?> definedNameValues,
           string valueName,
           bool defaultValue = default)
        {
            return
                definedNameValues.GetOptionalBoolean(valueName) ?? defaultValue;
        }


        public static bool GetRequiredBoolean(
            this Dictionary<string, string?> definedNameValues,
            string valueName)
        {
            bool? booleanValue = definedNameValues.GetOptionalBoolean(valueName);

            if (booleanValue is null)
            {
                throw new ReferralFileParserException(
                    $"Required boolean value with name '{valueName}' is not defined.");
            }

            return booleanValue.Value;
        }

        public static bool? GetOptionalBoolean(
          this Dictionary<string, string?> definedNameValues,
          string valueName)
        {
            var formattedBoolean = definedNameValues.GetValueOrDefault(valueName);

            if (formattedBoolean is null)
            {
                return null;
            }

            if (formattedBoolean.Equals("Yes", StringComparison.OrdinalIgnoreCase))
            {
                return true;
            }
            else
            if (formattedBoolean.Equals("No", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }
            else
            if (!bool.TryParse(formattedBoolean, out var booleanValue))
            {
                throw new ReferralFileParserException(
                    $"Can't parse value '{formattedBoolean}' with name '{valueName}' as boolean");
            }
            else
            {
                return booleanValue;
            }
        }

        private static DateTime? MergeDateTime(DateTime? date, DateTime? time)
        {
            return time is null ? date : date + time?.TimeOfDay;
        }

        private static DateTime MergeDateTime(DateTime date, DateTime time)
        {
            return date + time.TimeOfDay;
        }
    }
}
