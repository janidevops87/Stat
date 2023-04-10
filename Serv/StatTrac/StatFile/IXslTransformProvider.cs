using System.Xml.Xsl;

namespace Statline.StatTrac.StatFile
{
    public interface IXslTransformProvider
    {
        XslCompiledTransform Get(string transformName);
    }
}
