using System;

namespace Emailer.MessageProcessor.Domain
{
    public class EmailMessageSenderException : Exception
    {
        public EmailMessageSenderException() { }
        public EmailMessageSenderException(string message) : base(message) { }
        public EmailMessageSenderException(string message, Exception inner) : base(message, inner) { }
    }
}
