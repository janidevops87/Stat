using Statline.Common.Utilities;
using System.Collections.Generic;

namespace Emailer.MessageProcessor.Domain
{
    public static class EmailMessageBuilderExtensions
    {
        public static EmailMessageBuilder CloneWithNewAddresses(
            this EmailMessageBuilder messageBuilder,
            IEnumerable<EmailAddress> newAddresses)
        {
            Check.NotNull(messageBuilder, nameof(messageBuilder));

            return messageBuilder
                .Clone()
                .SetToAddresses(newAddresses);
        }
    }
}
