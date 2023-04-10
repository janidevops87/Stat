using Statline.Common.Utilities;
using System.IO;

namespace Statline.StatTrac.StatFax.Application.EmailSender
{
    public sealed class EmailAttachment
    {
        public EmailAttachment(IStreamReference content, string fileName)
        {
            Check.NotEmpty(fileName, nameof(fileName));
            Check.NotNull(content, nameof(content));
            FileName = fileName;
            Content = content;
        }

        public string FileName { get; }
        public IStreamReference Content { get; }
    }
}