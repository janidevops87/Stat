using System;

namespace Statline.StatTracUploader.App.Processor
{
    internal class ReferralProcessingException : Exception
    {
        public ReferralProcessingException() { }
        public ReferralProcessingException(string message) : base(message) { }
        public ReferralProcessingException(string message, Exception inner) : base(message, inner) { }
    }
}

