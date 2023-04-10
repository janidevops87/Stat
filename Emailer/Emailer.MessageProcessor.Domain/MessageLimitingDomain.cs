using Statline.Common.Utilities;

namespace Emailer.MessageProcessor.Domain
{
    public class MessageLimitingDomain
    {
        public string Domain { get; }
        public int SizeLimit { get; }

        public MessageLimitingDomain(string domain, int sizeLimit)
        {
            Check.NotNull(domain, nameof(domain));
            Check.Bigger(sizeLimit, 0, nameof(sizeLimit));

            Domain = domain;
            SizeLimit = sizeLimit;
        }

        public override string ToString()
        {
            return $"{{{nameof(Domain)}={Domain}, {nameof(SizeLimit)}={SizeLimit}}}";
        }
    }
}
