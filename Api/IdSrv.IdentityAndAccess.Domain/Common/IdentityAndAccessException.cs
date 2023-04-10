using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Common
{
    [Serializable]
    public class IdentityAndAccessException : Exception
    {
        public IdentityAndAccessException() { }
        public IdentityAndAccessException(string message) : base(message) { }
        public IdentityAndAccessException(string message, Exception inner) : base(message, inner) { }
        protected IdentityAndAccessException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context) { }
    }
}
