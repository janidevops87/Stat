using System;

namespace Statline.IdentityServer.IdentityAndAccess.App.Common
{
    [Serializable]
    public class ApplicationServiceException : Exception
    {
        public ApplicationServiceException() { }
        public ApplicationServiceException(string message) : base(message) { }
        public ApplicationServiceException(string message, Exception inner) : base(message, inner) { }
        protected ApplicationServiceException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context) { }
    }
}
