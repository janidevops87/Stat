using Statline.Common.Utilities;
using System.IO;

namespace Statline.StatTracUploader.App.Common.Notification
{
    public sealed class NotificationAttachment
    {
        public NotificationAttachment(IStreamReference content, string fileName)
        {
            Check.NotNull(content, nameof(content));
            Check.NotEmpty(fileName, nameof(fileName));
            FileName = fileName;
            Content = content;
        }

        public string FileName { get; }
        public IStreamReference Content { get; }
    }
}
