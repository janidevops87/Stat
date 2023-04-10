using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Mail;
using HtmlAgilityPack;
using Registry.Common.DTO;
using Registry.Common.Util;

namespace Registry.Common.EmailService
{
    public class EmailSender : IEmailSender
    {
        public void SendEmails(List<Email> emails, RegistryOwnerEmail registryOwnerEmail)
        {
            foreach (var email in emails)
            {
                if (string.IsNullOrEmpty(email.TemplateName))
                {
                    continue;
                }

                if (string.IsNullOrEmpty(email.EmailToAddress))
                {
                    continue;
                }

                var emailText = "";

                try
                {
                    //if something wrong with context or template - should not fail
                    var currPath = HttpContextManager.Current.Server.MapPath("~");
                    emailText = TemplateHelper.ApplyTemplate(email, Path.Combine(currPath, @"EmailTemplates"));
                    var emailDocument = new HtmlDocument();
                    emailDocument.LoadHtml(emailText);
                    email.Subject = emailDocument.DocumentNode.SelectSingleNode("/html/head/title").InnerText;
                    email.EmailFromAddress = emailDocument.DocumentNode.SelectSingleNode("/html/head/meta[@name='from']").Attributes["content"].Value;
                }
                catch (Exception)
                {
                    //todo: add log4net
                }

                var smtpClient = new SmtpClient();
                var credentials = smtpClient.Credentials as NetworkCredential;

                if (credentials != null)
                    credentials.UserName = registryOwnerEmail.EmailMailboxAccount;

                var mail = new MailMessage
                {
                    From = new MailAddress(registryOwnerEmail.EmailMailboxAccount, email.EmailFromAddress),
                    ReplyToList = { new MailAddress(registryOwnerEmail.EmailFrom) },
                    To = { email.EmailToAddress },
                    Subject = email.Subject,
                    Body = emailText,
                    IsBodyHtml = true,
                };

                smtpClient.SendCompleted += (s, a) =>
                {
                    mail.Dispose();
                    smtpClient.Dispose();
                };

                smtpClient.SendAsync(mail, null);
            }
        }
    }
}
