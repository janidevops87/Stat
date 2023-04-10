using Microsoft.Azure.Documents;
using System;

namespace Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb
{
    /// <summary>
    /// This is a wrapper for the <see cref="IDocumentClient"/>
    /// to be able to inject it as a dependency as singleton 
    /// for a particular <typeparamref name="TDocument"/> but
    /// separate instances for each such document type. So basically
    /// <typeparamref name="TDocument"/> plays role of a key
    /// to choose document-specific client 
    /// (and not used for any other purpose here).
    /// </summary>
    /// <typeparam name="TDocument">
    /// The type of document object model.
    /// </typeparam>
    public interface IDocumentDbContext<TDocument> : IDisposable
        where TDocument : class
    {
        IDocumentClient Client { get; }
        string DatabaseId { get; }
        string CollectionId { get; }
    }
}
