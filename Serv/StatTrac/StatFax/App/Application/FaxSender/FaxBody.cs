using Statline.Common.Utilities;
using System.IO;

namespace Statline.StatTrac.StatFax.Application.FaxSender
{
    public class FaxBody
    {
        public FaxBody(IStreamReference content, string fileName)
        {
            Check.NotNull(content, nameof(content));
            Check.NotEmpty(fileName, nameof(fileName));
            Content = content;
            FileName = fileName;
        }

        public IStreamReference Content { get; }
        public string FileName { get; }
    }
}