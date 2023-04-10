using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using Registry.Common.DTO;
using Registry.Common.Enums;

namespace Registry.Common.EmailService
{
    public static class SendCustomersEmail
    {
        private static IDictionary<EmailTemplateType, Action<LanguagesEnum, string, RegistryOwner>> EmailingMethodsCollection => new Dictionary<EmailTemplateType, Action<LanguagesEnum, string, RegistryOwner>>
        {
            {EmailTemplateType.Confirmation, SendConfirmationEmails},
            {EmailTemplateType.Removal, SendRemovalEmails}
        };

        public static Task Send(string lng, EmailTemplateType templateType, string toAddress, RegistryOwner registryOwner)
        {
            var lngVal = (LanguagesEnum)Enum.Parse(typeof(LanguagesEnum), lng, true);

            if (!Enum.IsDefined(typeof(LanguagesEnum), lngVal))
            {
                throw new InvalidEnumArgumentException(lng);
            }

            return Task.Factory.StartNew(() => EmailingMethodsCollection[templateType](lngVal, toAddress, registryOwner));
        }

        public static void SendConfirmationEmails(LanguagesEnum lng, string toAddress, RegistryOwner registryOwner)
        {
            var lngCode = lng.ToString();
            //'m' looks to be used for 'multilanguage' ?
            var email = registryOwner.Emails.FirstOrDefault(x => x.LanguageCode.Equals(lngCode, StringComparison.InvariantCultureIgnoreCase)) ?? registryOwner.Emails.FirstOrDefault(x => x.LanguageCode.Equals("m"));

            SendEmails(new List<Email>
            {
                new Email
                {
                    EmailToAddress = toAddress,
                    TemplateName = $@"{registryOwner.RegistryOwnerRouteName}\{lng}\Confirmation"
                },
                new Email
                {
                    EmailToAddress = toAddress,
                    TemplateName = $@"{registryOwner.RegistryOwnerRouteName}\{lng}\FriendsAndFamily"
                }
            }, email);
        }

        private static void SendRemovalEmails(LanguagesEnum lng, string toAddress, RegistryOwner registryOwner)
        {
            var lngCode = lng.ToString();
            var email = registryOwner.Emails.FirstOrDefault(x => x.LanguageCode.Equals(lngCode, StringComparison.InvariantCultureIgnoreCase)) ?? registryOwner.Emails.FirstOrDefault(x => x.LanguageCode.Equals("m", StringComparison.InvariantCultureIgnoreCase));

            SendEmails(new List<Email>
            {
                new Email
                {
                    EmailToAddress = toAddress,
                    TemplateName = $@"{registryOwner.RegistryOwnerRouteName}\{lng}\Removal"
                }
            }, email);
        }

        public static void SendEmails(List<Email> emails, RegistryOwnerEmail registryOwnerEmail)
        {
            var sender = new EmailSender();
            sender.SendEmails(emails, registryOwnerEmail);
        }
    }
}
