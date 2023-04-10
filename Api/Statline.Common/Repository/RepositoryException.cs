using System;
using System.Runtime.Serialization;

namespace Statline.Common.Repository
{
    /// <summary>
    /// The exception that is thrown by repository components.
    /// </summary>
    [Serializable]
    public class RepositoryException : Exception
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="RepositoryException"/> class. 
        /// </summary>
        public RepositoryException()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RepositoryException"/> class.
        /// </summary>
        /// <param name="message">
        /// Error message.
        /// </param>
        public RepositoryException(string message)
            : base(message)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RepositoryException"/> class.
        /// </summary>
        /// <param name="message">Error message.</param>
        /// <param name="innerException">Inner exception that is the original cause of the exception.</param>
        public RepositoryException(string message, Exception innerException)
            : base(message, innerException)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RepositoryException"/> 
        /// class with serialized data. 
        /// </summary>
        /// <param name="info">
        /// The <see cref="SerializationInfo"/> that holds the serialized object 
        /// data about the exception being thrown. 
        /// </param>
        /// <param name="context">
        /// The <see cref="StreamingContext"/> that contains contextual information 
        /// about the source or destination. 
        /// </param>
        protected RepositoryException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

    }
}
