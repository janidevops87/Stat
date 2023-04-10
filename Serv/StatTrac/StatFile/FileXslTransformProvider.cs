using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

namespace Statline.StatTrac.StatFile
{
    public class FileXslTransformProvider : IXslTransformProvider
    {
        private readonly string baseDirectory;

        public FileXslTransformProvider(string baseDirectory)
        {
            if (string.IsNullOrWhiteSpace(baseDirectory))
            {
                throw new ArgumentException("Base directory is not specified", nameof(baseDirectory));
            }

            this.baseDirectory = baseDirectory;
        }

        public XslCompiledTransform Get(string transformName)
        {
            if (string.IsNullOrWhiteSpace(transformName))
            {
                throw new ArgumentException("Transform name is not specified", nameof(transformName));
            }

            var xsltFilePath = Path.Combine(baseDirectory, transformName);
            var xmlResolver = new XmlUrlResolver();
            var xslFile = new XslCompiledTransform();
            xslFile.Load(xsltFilePath, XsltSettings.Default, xmlResolver);
            return xslFile;
        }
    }
}
