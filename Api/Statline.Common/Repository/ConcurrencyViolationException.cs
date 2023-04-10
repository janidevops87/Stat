using System;
using System.Runtime.Serialization;

namespace Statline.Common.Repository
{
    /// <summary>
    /// The exception that is thrown by repository components in cases when
    /// there is a concurrency race when manipulating data.
    /// </summary>
    [Serializable]
    public class ConcurrencyViolationException : RepositoryException
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ConcurrencyViolationException"/> class.
        /// </summary>
        public ConcurrencyViolationException()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ConcurrencyViolationException"/> class.
        /// </summary>
        /// <param name="message">
        /// Error message.
        /// </param>
        public ConcurrencyViolationException(string message)
            : base(message)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ConcurrencyViolationException"/> class.
        /// </summary>
        /// <param name="message">Error message.</param>
        /// <param name="innerException">Inner exception that is the original cause of the exception.</param>
        public ConcurrencyViolationException(string message, Exception innerException)
            : base(message, innerException)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ConcurrencyViolationException"/> 
        /// class  with serialized data.
        /// </summary>
        /// <param name="info">
        /// The <see cref="SerializationInfo"/> that holds the serialized object 
        /// data about the exception being thrown. 
        /// </param>
        /// <param name="context">
        /// The <see cref="StreamingContext"/> that contains contextual information 
        /// about the source or destination. 
        /// </param>
        protected ConcurrencyViolationException(
          SerializationInfo info,
          StreamingContext context)
            : base(info, context)
        {
        }
    }
}
