using GemBox.Document;
using GemBox.Document.CustomMarkups;
using Statline.Common.Utilities;
using System.IO;
using System.Text.RegularExpressions;
using System.Xml;

namespace Statline.StatTrac.StatFax.Infrastructure.WordToPdfConverter
{
    internal static class DocumentModelExtensions
    {
        /// <summary>
        /// Walks through all elements (content controls) which have data binding defined and
        /// loads values from referenced data source.
        /// </summary>
        /// <remarks>
        /// GemBox.Document doesn't automatically update content controls from bound data source. 
        /// This method basically loads each data value and inserts it into corresponding 
        /// content control.
        /// </remarks>
        // This code was provided by GemBox tech support.
        public static void ApplyXmlMappings(this DocumentModel document)
        {
            Check.NotNull(document, nameof(document));

            foreach (var element in document.GetChildElements(
                recursively: true,
                ElementType.InlineContentControl,
                ElementType.BlockContentControl))
            {
                if (element.ElementType == ElementType.InlineContentControl)
                {
                    var inlineSdt = (InlineContentControl)element;
                    var value = inlineSdt.Properties.XmlMapping.GetValue();
                    if (string.IsNullOrEmpty(value))
                        continue;

                    var characterFormat = inlineSdt.Properties.CharacterFormat != null ?
                        inlineSdt.Properties.CharacterFormat.Clone() : new CharacterFormat();

                    inlineSdt.Inlines.Clear();
                    inlineSdt.Inlines.Add(
                        new Run(document, value) { CharacterFormat = characterFormat });
                }

                if (element.ElementType == ElementType.BlockContentControl)
                {
                    var blockSdt = (BlockContentControl)element;
                    var value = blockSdt.Properties.XmlMapping.GetValue();
                    if (string.IsNullOrEmpty(value))
                        continue;

                    var paragraphFormat = blockSdt.Blocks.Count > 0 & blockSdt.Blocks[0].ElementType == ElementType.Paragraph ?
                        ((Paragraph)blockSdt.Blocks[0]).ParagraphFormat.Clone() : new ParagraphFormat();

                    var characterFormat = blockSdt.Properties.CharacterFormat != null ?
                        blockSdt.Properties.CharacterFormat.Clone() : new CharacterFormat();

                    blockSdt.Blocks.Clear();
                    blockSdt.Blocks.Add(
                        new Paragraph(document,
                            new Run(document, value)
                            { CharacterFormat = characterFormat })
                        { ParagraphFormat = paragraphFormat });
                }
            }
        }

        // This code was provided by GemBox tech support.
        private static string GetValue(this XmlMapping xmlMapping)
        {
            if (xmlMapping == null || xmlMapping.CustomXmlPart == null)
                return null;

            var xmlDocument = new XmlDocument();
            xmlDocument.Load(new MemoryStream(xmlMapping.CustomXmlPart.Data));

            var namespaces = new XmlNamespaceManager(xmlDocument.NameTable);
            if (!string.IsNullOrEmpty(xmlMapping.PrefixMappings))
            {
                var regex = new Regex("xmlns:(?<prefix>[\\S]+)='(?<namespace>[\\S]+)'");
                foreach (Match match in regex.Matches(xmlMapping.PrefixMappings))
                    namespaces.AddNamespace(match.Groups["prefix"].Value, match.Groups["namespace"].Value);
            }

            var node = xmlDocument.SelectSingleNode(xmlMapping.XPath, namespaces);
            return node?.InnerText;
        }
    }
}
