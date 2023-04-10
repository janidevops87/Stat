using Emailer.LegacyBridge.App;
using Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue;
using System.Collections.Generic;
using System.Linq;

namespace Emailer.LegacyBridge.Service
{
    internal class ModelTranslator
    {
        public EmailMessage ToEmailMessage(Message message)
        {
            var row = message.Data;

            var messageInfo = new EmailMessage(
                id: message.Id,
                from: row.AlphaPageSender!,
                to: row.AlphaPageRecipient!,
                cc: row.AlphaPageCc,
                bcc: row.AlphaPageBc,
                subject: row.AlphaPageSubject,
                body: row.AlphaPageBody);

            return messageInfo;
        }

        public IEnumerable<EmailMessage> ToEmailMessages(
            IEnumerable<Message> messages)
        {
            return messages.Select(ToEmailMessage);
        }
    }
}
