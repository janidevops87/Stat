using Statline.StatTracUploader.Infrastructure.FileParsers.Common;
using System;
using System.Globalization;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    internal static class ConvertHelper
    {
        public static DateTime ParseDateTime(string cellTextValue)
        {
            if (double.TryParse(
                cellTextValue,
                NumberStyles.Float |
                NumberStyles.AllowThousands,
                NumberFormatInfo.InvariantInfo,
                out double oaDate))
            {
                try
                {
                    return DateTime.FromOADate(oaDate);
                }
                catch (ArgumentException ex)
                {
                    throw new ReferralFileParserException(
                        $"Can't convert an OADate '{oaDate}' to date/time.", ex);
                }
            }
            else
            {
                throw new ReferralFileParserException(
                    $"Can't parse OADate from '{cellTextValue}', expected OADate format");
            }
        }
    }
}
