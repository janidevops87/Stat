using System;
using System.Runtime.Serialization;

namespace Statline.Common.Repository
{
    /// <summary>
    /// The exception that is thrown by repository components when trying to 
    /// add an entity and there already is an entity with the same ID.
    /// </summary>
    [Serializable]
    public class EntityAlreadyExistsException : RepositoryException
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="EntityAlreadyExistsException"/> class.
        /// </summary>
        public EntityAlreadyExistsException() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="EntityAlreadyExistsException"/> class.
        /// </summary>
        /// <param name="message">
        /// Error message.
        /// </param>
        public EntityAlreadyExistsException(string message) : base(message) { }

        /// <summary>
        /// Initializes a new instance of the <see cref="EntityAlreadyExistsException"/> class.
        /// </summary>
        /// <param name="message">Error message.</param>
        /// <param name="innerException">Inner exception that is the original cause of the exception.</param>
        public EntityAlreadyExistsException(string message, Exception innerException) : base(message, innerException) { }

        /// <summary>
        /// Initializes a new instance of the <see cref="EntityAlreadyExistsException"/> 
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
        protected EntityAlreadyExistsException(
          SerializationInfo info,
          StreamingContext context) : base(info, context) { }
    }
}
