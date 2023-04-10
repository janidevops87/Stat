using Statline.Common.Utilities;
using System.IO;

namespace Statline.StatTrac.StatFax.Application.EmailSender
{
    public class EmailBody
    {
        public EmailBody(GenericStreamReference content, bool isHtml)
        {
            Check.NotNull(content, nameof(content));

            Content = content;
            IsHtml = isHtml;
        }

        public GenericStreamReference Content { get; }
        public bool IsHtml { get; }
    }
}