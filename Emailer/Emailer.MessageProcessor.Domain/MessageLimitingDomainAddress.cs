using Statline.Common.Utilities;

namespace Emailer.MessageProcessor.Domain
{
    public class MessageLimitingDomainAddress
    {
        public EmailAddress Address { get; }
        public int SizeLimit { get; }

        public MessageLimitingDomainAddress(EmailAddress address, int sizeLimit)
        {
            Check.NotNull(address, nameof(address));
            Check.Bigger(sizeLimit, 0, nameof(sizeLimit));

            Address = address;
            SizeLimit = sizeLimit;
        }
    }
}
