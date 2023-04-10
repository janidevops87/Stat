using GemBox.Document;
using Statline.Common.Utilities;
using Statline.StatTrac.StatFax.Application;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Infrastructure.WordToPdfConverter
{
    public class GemBoxWordToPdfConverter : IWordToPdfConverter
    {
        public GemBoxWordToPdfConverter(
            GemBoxWordToPdfConverterOptions options)
        {
            Check.NotNull(options, nameof(options));
            ComponentInfo.SetLicense(options.GemBoxLicense);
        }

        public Task ConvertAsync(Stream wordDocumentStream, Stream pdfDocumentStream)
        {
            var document = DocumentModel.Load(wordDocumentStream, LoadOptions.DocxDefault);

            // TODO: This is an ugly solution,
            // because removing first page is a business requirement
            // independent from document format conversion, and this
            // breaks Single Responsibility Principle. The reason
            // for doing this here is that the GemBox library allows
            // easily removing document part which corresponds to the first 
            // page. Not sure if the DocumentFormat.OpenXml library can do 
            // the same easily. Note that OpenXml (Word) documents don't 
            // have page splitting concept: documents are paginated on the 
            // fly when opening in Word (depending on chosen layout) 
            // or when printing.
            // So TODO: try to achieve the same via DocumentFormat.OpenXml
            // and then move first page removal to the outer code.
            RemoveFirstPage(document);

            document.ApplyXmlMappings();

            // Narrowing margins because during conversion they seem 
            // to make text flow to next page (possibly due to some 
            // difference of font and margin size units in each format).
            var margins = document.Sections[0].PageSetup.PageMargins;
            margins.Top = 36;
            margins.Bottom = 36;

            document.Save(pdfDocumentStream, SaveOptions.PdfDefault);

            // No support for async yet.
            return Task.CompletedTask;
        }

        private static void RemoveFirstPage(DocumentModel document)
        {
            // Below code was suggested by GemBox tech support.
            // It works for current cases, but may not work for others.
            // First, we remove all content down to the first page break character.
            // Second, we remove the first page header/footer 
            // (they can be specified separately for the first page).
            var pageBreak = document
                .GetChildElements(recursively: true, ElementType.SpecialCharacter)
                .Cast<SpecialCharacter>()
                .First(sc => sc.CharacterType == SpecialCharacterType.PageBreak);

            new ContentRange(document.Content.Start, pageBreak.Content.End).Delete();

            var headersFooters = document.Sections[0].HeadersFooters;
            headersFooters.Remove(headersFooters[HeaderFooterType.HeaderFirst]);
            headersFooters.Remove(headersFooters[HeaderFooterType.FooterFirst]);
        }
    }
}
