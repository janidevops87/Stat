using System;
using System.Collections.Concurrent;
using System.Xml.Xsl;

namespace Statline.StatTrac.StatFile
{
    public class CachingXslTransformProvider : IXslTransformProvider
    {
        private readonly ConcurrentDictionary<string, XslCompiledTransform> transformCache
           = new ConcurrentDictionary<string, XslCompiledTransform>(
               StringComparer.OrdinalIgnoreCase);

        private readonly IXslTransformProvider innerTransformProvider;

        public CachingXslTransformProvider(IXslTransformProvider innerTransformProvider)
        {
            this.innerTransformProvider = innerTransformProvider ?? throw new ArgumentNullException(nameof(innerTransformProvider));
        }

        public XslCompiledTransform Get(string transformName)
        {
            // TODO: Do we need cache cleanup or we expected to 
            // have pretty short list of transforms?
            return transformCache.GetOrAdd(transformName, innerTransformProvider.Get);
        }
    }
}
