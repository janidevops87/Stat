using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using Statline.StatTracUploader.Infrastructure.FileParsers.Common;
using System.Globalization;
using System.Linq;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel.Extensions
{
    internal static class WorkbookPartExtensions
    {
        /// <summary>
        /// Does some cell value massaging 
        /// so it can be easier consumed by higher level code. 
        /// </summary>
        /// <param name="workbookPart">The workbook part.</param>
        /// <param name="cell">The cell.</param>
        /// <param name="useCellStyleFormat">
        /// <c>true</c> if the method should try using cell style format
        /// for converting its value to representation it has in Excel.
        /// For example, the document can define date/time format for a cell,
        /// while the raw value is just a number (an "OADate").
        /// </param>
        /// <returns>Cell value.</returns>
        /// <remarks>
        /// While <paramref name="useCellStyleFormat"/> option looks quite useful, 
        /// it seems to work unreliably.
        /// E.g. while you define standard time format for a cell in Excel, 
        /// in the code the format ID can be returned as currency. Maybe,
        /// there is just some undiscovered knowledge about that, but for now
        /// it's safer to do further conversion in higher level code where you
        /// know expected cell data type from the context 
        /// (e.g. from a class property to be assigned with the parsed value).
        /// </remarks>
        public static string? GetFormattedCellValue(
            this WorkbookPart workbookPart,
            Cell cell,
            bool useCellStyleFormat = false)
        {
            // The value of the DataType property is null for 
            // numeric and date types. It contains the value 
            // CellValues.SharedString for strings, and 
            // CellValues.Boolean for Boolean values.
            // More on this here https://stackoverflow.com/a/43050199.
            if (cell.DataType is null) // number & dates
            {
                if (!useCellStyleFormat)
                {
                    return cell.InnerText;
                }

                int styleIndex = (int)cell.StyleIndex.Value;

                var cellFormat =
                    (CellFormat)workbookPart.WorkbookStylesPart.Stylesheet.CellFormats.ElementAt(styleIndex);

                var formatId = (FormatId)cellFormat.NumberFormatId.Value;

                switch (formatId)
                {
                    case FormatId.DateShort:
                    case FormatId.DateLong:
                    case FormatId.Time:
                        {
                            // Dates in ECMA-376 (Office Open XML File Formats) are 
                            // stored as numeric values(serial dates).
                            // In.Net terms this is called an "OADate"(OLE Automation Date).
                            // So we're transforming the date/time from OpenXML format to
                            // ".Net" format, so the outer code can consume the value easier.
                            var dateTime = ConvertHelper.ParseDateTime(cell.InnerText);

                            return dateTime.ToString(
                               formatId == FormatId.Time ? "t" : "d",
                               CultureInfo.InvariantCulture);
                        }

                    default:
                        return cell.InnerText;
                }
            }
            else // Shared string or boolean
            {
                return cell.DataType.Value switch
                {
                    CellValues.SharedString => workbookPart.GetSharedString(
                        int.Parse(cell.CellValue.InnerText, CultureInfo.InvariantCulture)),
                    CellValues.Boolean => cell.CellValue.InnerText == "0" ? bool.FalseString : bool.TrueString,
                    _ => cell.CellValue.InnerText
                };
            }
        }

        private static string GetSharedString(this WorkbookPart workbookPart, int index)
        {
            if (workbookPart.SharedStringTablePart is null)
            {
                throw new ReferralFileParserException(
                    "No shared string table part was found, but there is a reference to it.");
            }

            SharedStringItem ssi = workbookPart.SharedStringTablePart.SharedStringTable
                .Elements<SharedStringItem>()
                .ElementAt(index);

            return ssi.Text.Text;
        }
    }
}
