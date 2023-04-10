using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using Statline.StatTracUploader.App.Uploader.ReferralFileParser;
using Statline.StatTracUploader.Infrastructure.FileParsers.Common;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel.Extensions
{
    internal static class SpreadsheetDocumentExtensions
    {
        // Retrieve the value of a cell, given a cell full address.
        public static string? GetCellValue(
            this SpreadsheetDocument document,
            string fullCellAddress)
        {
            (string sheetName, string cellColumn, string cellRow) addressParts;

            try
            {
                addressParts = ParseCellAddressParts(fullCellAddress);
            }
            catch (ArgumentException ex)
            {
                throw new ReferralFileParserException(
                    $"Can't parse full cell address '{fullCellAddress}' while getting cell value.", ex);       
            }
            
            return document.GetCellValue(
                addressParts.sheetName, 
                addressParts.cellColumn + addressParts.cellRow);
        }

        // Retrieve the value of a cell, given a sheet name and address name.
        public static string? GetCellValue(
            this SpreadsheetDocument document,
            string sheetName,
            string cellAddress)
        {
            // Retrieve a reference to the workbook part.
            var workbookPart = document.WorkbookPart;

            // Find the sheet with the supplied name, and then use that 
            // Sheet object to retrieve a reference to the first worksheet.
            Sheet? theSheet = workbookPart.Workbook.Descendants<Sheet>().
              Where(s => s.Name == sheetName).FirstOrDefault();

            // Throw an exception if there is no sheet.
            if (theSheet is null)
            {
                throw new ReferralFileParserException(
                    $"Sheet with name '{sheetName}' not found.");
            }

            // Retrieve a reference to the worksheet part.
            var worksheetPart = (WorksheetPart)workbookPart.GetPartById(theSheet.Id);

            // Use its Worksheet property to get a reference to the cell 
            // whose address matches the address you supplied.
            Cell? theCell = worksheetPart.Worksheet
                .Descendants<Cell>()
                .Where(c => c.CellReference == cellAddress)
                .FirstOrDefault();

            if (theCell is null)
            {
                throw new ReferralFileParserException(
                    $"Cell with address '{cellAddress}' not found.");
            }

            // If the cell is empty...
            if (theCell.InnerText?.Length is not > 0)
            {
                return null;
            }

            return workbookPart.GetFormattedCellValue(theCell);
        }

        public static Dictionary<string, string> GetDefinedNames(
            this SpreadsheetDocument document)
        {
            var wbPart = document.WorkbookPart;

            var definedNames = wbPart.Workbook.DefinedNames ?? new DefinedNames();

            return definedNames
                .Cast<DefinedName>()
                .ToDictionary(dn => dn.Name.Value, dn => dn.Text);
        }

        // NOTE: While this method does some checks for address correctness,
        // it far doesn't handle all possible cases. For example, if a sheet name contains
        // reserved characters like '!', Excel will add quotation marks around the sheet name,
        // and this won't be handled correctly here.
        // The goal is to handle real use cases and clearly report about any mistakes
        // the user made when adding defined names for cells.
        private static
            (string sheetName,
            string cellColumn,
            string cellRow)
            ParseCellAddressParts(string fullCellAddress)
        {
            var fullCellAddressSpan = fullCellAddress.AsSpan();

            const char SheetNameSeparator = '!';
            const char ColumnRowSeparator = '$';

            // Full cell address will look like "Sheet1!$H$12".
            // It can also contain ranges, like "Sheet1!$E$34:$F$36",
            // or multiple cells, like "Sheet1!$H$36,Sheet1!$H$38,Sheet1!$J$36,Sheet1!$J$38", 
            // but we don't support this.
            if (fullCellAddressSpan.IndexOfAny(':', ',') != -1)
            {
                throw new ArgumentException(
                    $"Cell address '{fullCellAddress}' contains range(s) or/and " +
                    $"multiple addresses, which is not supported.",
                    nameof(fullCellAddress));
            }


            var sheetNameSeparatorIndex =
                fullCellAddressSpan.IndexOf(SheetNameSeparator);

            if (sheetNameSeparatorIndex == -1)
            {
                throw new ArgumentException(
                    $"Sheet name separator '{SheetNameSeparator}' " +
                    $"not found in the cell address '{fullCellAddress}'.",
                    nameof(fullCellAddress));
            }

            var sheetNameSpan = fullCellAddressSpan[..sheetNameSeparatorIndex];

            if (sheetNameSpan.Length == 0)
            {
                throw new ArgumentException(
                    $"Sheet name is empty in the cell address '{fullCellAddress}'.",
                    nameof(fullCellAddress));
            }

            var cellAddressSpan = fullCellAddressSpan[(sheetNameSeparatorIndex + 1)..];

            if (cellAddressSpan.Length == 0)
            {
                throw new ArgumentException(
                    $"Column/row name is empty in the cell address '{fullCellAddress}'.",
                    nameof(fullCellAddress));
            }

            if (cellAddressSpan[0] != ColumnRowSeparator)
            {
                throw new ArgumentException(
                    $"Column name doesn't start with '{ColumnRowSeparator}' " +
                    $"in the cell address '{fullCellAddress}'.",
                    nameof(fullCellAddress));
            }

            var columnRowSeparatorIndex =
                cellAddressSpan.LastIndexOf(ColumnRowSeparator);

            switch (columnRowSeparatorIndex)
            {
                case -1:
                    throw new ArgumentException(
                         $"Column/row separator '{ColumnRowSeparator}' " +
                         $"not found in the cell address '{fullCellAddress}'.",
                         nameof(fullCellAddress));
                case 0:
                    throw new ArgumentException(
                        $"Column name is not found in the cell address '{fullCellAddress}'.",
                        nameof(fullCellAddress));
            }

            var cellColumnSpan = cellAddressSpan[1..columnRowSeparatorIndex];
            var cellRowSpan = cellAddressSpan[(columnRowSeparatorIndex + 1)..];

            if (cellColumnSpan.Length == 0)
            {
                throw new ArgumentException(
                    $"Column name is empty in the cell address '{fullCellAddress}'.",
                    nameof(fullCellAddress));
            }

            if (cellRowSpan.Length == 0)
            {
                throw new ArgumentException(
                    $"Row name is empty in the cell address '{fullCellAddress}'.",
                    nameof(fullCellAddress));
            }

            // TODO: Check column and row names for invalid characters?
            return
                (sheetNameSpan.ToString(),
                cellColumnSpan.ToString(),
                cellRowSpan.ToString());
        }

    }
}
