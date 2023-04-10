using Statline.Common.Utilities;
using System.IO;

namespace Statline.StatTracUploader.App.Common.Notification
{
    public class NotificationContent
    {
        public NotificationContent(IStreamReference content, bool isHtml)
        {
            Check.NotNull(content, nameof(content));

            Content = content;
            IsHtml = isHtml;
        }

        public IStreamReference Content { get; }
        public bool IsHtml { get; }
    }
}
