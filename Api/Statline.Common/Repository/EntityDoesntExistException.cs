using System;
using System.Runtime.Serialization;

namespace Statline.Common.Repository
{
    /// <summary>
    /// The exception that is thrown by repository components when trying to 
    /// get an entity and there is no entity with specified ID.
    /// </summary>
    [Serializable]
    public class EntityDoesntExistException : RepositoryException
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="EntityDoesntExistException"/> class.
        /// </summary>
        public EntityDoesntExistException() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="EntityDoesntExistException"/> class.
        /// </summary>
        /// <param name="message">
        /// Error message.
        /// </param>
        public EntityDoesntExistException(string message) : base(message) { }

        /// <summary>
        /// Initializes a new instance of the <see cref="EntityDoesntExistException"/> class.
        /// </summary>
        /// <param name="message">Error message.</param>
        /// <param name="innerException">Inner exception that is the original cause of the exception.</param>
        public EntityDoesntExistException(string message, Exception innerException) : base(message, innerException) { }

        /// <summary>
        /// Initializes a new instance of the <see cref="EntityDoesntExistException"/> 
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
        protected EntityDoesntExistException(
          SerializationInfo info,
          StreamingContext context) : base(info, context) { }
    }
}
