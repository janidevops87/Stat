using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;
using MimeKit.Text;
using Statline.Common.Configuration.Email.Sender;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Common.Notification;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Services.Notification.MailKit
{
    public class MailKitNotificationService : INotificationService
    {
        private readonly EmailSenderSettings options;

        public MailKitNotificationService(IOptions<EmailSenderSettings> options)
        {
            Check.NotNull(options, nameof(options));
            this.options = options.Value;
        }

        public async Task SendAsync(NotificationMessage notification)
        {
            Check.NotNull(notification, nameof(notification));

            // Using composite disposable to gather and not forget to dispose
            // all streams we reference from different email objects.
            using var compositeDisposable = new CompositeDisposable();

            var message = await BuildMessageAsync(
                notification,
                compositeDisposable).ConfigureAwait(false);

            await SendMessageAsync(message).ConfigureAwait(false);
        }

        private async Task SendMessageAsync(MimeMessage message)
        {
            var serverSettings = options.SmtpServerSettings;

            using var client = new SmtpClient();

            await client.ConnectAsync(
                serverSettings.ServerName, 
                serverSettings.ServerPort, 
                options: MapSecureSocketOptions(serverSettings.SecureConnectionMode)).ConfigureAwait(false);

            if (serverSettings.Credential is not null)
            {
                await client.AuthenticateAsync(serverSettings.Credential).ConfigureAwait(false);
            }

            await client.SendAsync(message).ConfigureAwait(false);
            await client.DisconnectAsync(quit: true).ConfigureAwait(false);
        }

        private SecureSocketOptions MapSecureSocketOptions(
            Common.Configuration.Email.Smtp.SecureSocketOptions secureConnectionMode)
        {
            return secureConnectionMode switch
            {
                Common.Configuration.Email.Smtp.SecureSocketOptions.None => SecureSocketOptions.None,
                Common.Configuration.Email.Smtp.SecureSocketOptions.SslOnConnect => SecureSocketOptions.SslOnConnect,
                Common.Configuration.Email.Smtp.SecureSocketOptions.StartTls => SecureSocketOptions.StartTls,
                Common.Configuration.Email.Smtp.SecureSocketOptions.StartTlsWhenAvailable => SecureSocketOptions.StartTlsWhenAvailable,
                _ => SecureSocketOptions.Auto,
            };
        }

        private async Task<MimeMessage> BuildMessageAsync(
            NotificationMessage notificationMessage,
            CompositeDisposable compositeDisposable)
        {
            var message = new MimeMessage();

            var toAddress = notificationMessage.ToAddress;

            if (toAddress is not null)
            {
                message.To.Add(new MailboxAddress(toAddress.Name, toAddress.Address));
            }
            else if (!string.IsNullOrEmpty(options.ToEmails))
            {
                message.To.AddRange(InternetAddressList.Parse(options.ToEmails));
            }
            else
            {
                throw new InvalidOperationException(
                    "Neither notification nor configuration has destination address specified.");
            }

            message.From.Add(MailboxAddress.Parse(options.FromEmail));
            message.Subject = notificationMessage.Subject ?? options.EmailSubject;

            MimeEntity bodyPart =
                await BuildMessageBodyPartAsync(notificationMessage.Content, compositeDisposable).ConfigureAwait(false);

            if (notificationMessage.Attachments.Any())
            {
                MimePart[] attachmentParts =
                    await BuildAttachmentPartsAsync(notificationMessage.Attachments, compositeDisposable).ConfigureAwait(false);

                bodyPart = new Multipart(subtype: "mixed")
                {
                    bodyPart,
                    attachmentParts
                };
            }

            message.Body = bodyPart;

            return message;
        }

        private static async Task<TextPart> BuildMessageBodyPartAsync(
            NotificationContent notificationContent,
            CompositeDisposable compositeDisposable)
        {
            var messageBodyStream = await notificationContent.Content.OpenReadAsync().ConfigureAwait(false);

            compositeDisposable.Add(messageBodyStream);

            var bodyPart = new TextPart(notificationContent.IsHtml ? TextFormat.Html : TextFormat.Text)
            {
                Content = new MimeContent(messageBodyStream)
            };

            return bodyPart;
        }


        private static async Task<MimePart[]> BuildAttachmentPartsAsync(
            IEnumerable<NotificationAttachment> attachments,
            CompositeDisposable compositeDisposable)
        {
            var tasks = attachments.Select(attachment => BuildAttachmentPartAsync(attachment, compositeDisposable));
            return await Task.WhenAll(tasks).ConfigureAwait(false);
        }

        private static async Task<MimePart> BuildAttachmentPartAsync(
            NotificationAttachment attachment,
            CompositeDisposable disposables)
        {
            var attachmentContentStream = await attachment.Content.OpenReadAsync().ConfigureAwait(false);

            disposables.Add(attachmentContentStream);

            string contentType = MimeTypes.GetMimeType(attachment.FileName);

            var attachmentPart = new MimePart(contentType)
            {
                Content = new MimeContent(attachmentContentStream, ContentEncoding.Default),
                ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
                ContentTransferEncoding = ContentEncoding.Base64,
                FileName = attachment.FileName
            };

            return attachmentPart;
        }
    }
}
