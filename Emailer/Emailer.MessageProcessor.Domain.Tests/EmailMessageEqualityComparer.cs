using System;
using System.Collections.Generic;
using System.Linq;

namespace Emailer.MessageProcessor.Domain.Tests
{
    public class EmailMessageEqualityComparer : EqualityComparer<EmailMessage>
    {
        public override bool Equals(EmailMessage x, EmailMessage y)
        {
            // This comparison is for tests, so it tends to 
            // be primarily ordinal.
            return
                x.Id.Equals(y.Id) &&
                x.To.SequenceEqual(y.To) &&
                x.From.Equals(y.From) &&
                x.CC.SequenceEqual(y.CC) &&
                x.Bcc.SequenceEqual(y.Bcc) &&
                string.Equals(x.Subject, y.Subject, StringComparison.Ordinal) &&
                string.Equals(x.Body, y.Body, StringComparison.Ordinal);
        }

        public override int GetHashCode(EmailMessage obj)
        {
            throw new NotImplementedException();
        }
    }
}
