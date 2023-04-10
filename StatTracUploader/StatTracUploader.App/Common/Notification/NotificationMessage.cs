using Statline.Common.Utilities;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Collections.ObjectModel;

namespace Statline.StatTracUploader.App.Common.Notification
{
    public class NotificationMessage
    {
        public NotificationAddress? ToAddress { get; }
        public NotificationContent Content { get; }
        public string? Subject { get; }
        public IReadOnlyCollection<NotificationAttachment> Attachments { get; }

        public NotificationMessage(
            NotificationAddress? toAddress,
            NotificationContent content,
            string? subject, 
            params NotificationAttachment[] attachments)
        {
            Check.NotNull(content, nameof(content));
            Check.HasNoNulls(attachments, nameof(attachments));
            ToAddress = toAddress;
            Content = content;
            Subject = subject;
            Attachments = ImmutableArray.Create(attachments);
        }
    }
}
