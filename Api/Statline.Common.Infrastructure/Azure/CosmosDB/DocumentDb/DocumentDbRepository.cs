using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Threading.Tasks;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using Microsoft.Azure.Documents.Linq;
using Microsoft.Extensions.Logging;
using Statline.Common.Repository;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb
{
    public class DocumentDbRepository<TDocument>
        where TDocument : Resource
    {
        private readonly IDocumentDbContext<TDocument> context;
        private readonly Uri collectionUri;
        private readonly ILogger logger;
        private readonly Expression<Func<TDocument, bool>> globalFilter;

        public DocumentDbRepository(
            IDocumentDbContext<TDocument> context,
            ILogger<DocumentDbRepository<TDocument>> logger,
            Expression<Func<TDocument, bool>> globalFilter = null)
        {
            Check.NotNull(context, nameof(context));
            Check.NotNull(logger, nameof(logger));

            this.context = context;
            this.logger = logger;

            collectionUri = UriFactory.CreateDocumentCollectionUri(
                    context.DatabaseId,
                    context.CollectionId);

            // TODO: This produces "WHERE (true AND (". 
            // Think how to exclude this if no global filter provided.
            // Consider creating extension method "WhereOptional(<expression>)"
            // which add a "where" statement only if expression is not null.
            this.globalFilter = globalFilter ?? (_ => true);
        }

        private void ValidateOptions(DocumentDbOptions options)
        {
            Check.NotNull(options, nameof(options));
            Check.NotNull(options.Url, nameof(options), nameof(options.Url));
            Check.NotEmpty(options.AuthKey, nameof(options.AuthKey));
            Check.NotEmpty(options.CollectionId, nameof(options.CollectionId));
            Check.NotEmpty(options.DatabaseId, nameof(options.DatabaseId));
        }

        public async Task<List<TDocument>> GetItemsAsync(
            Expression<Func<TDocument, bool>> predicate)
        {
            return await GetItemsAsync(predicate, doc => doc).ConfigureAwait(false);
        }

        public async Task<List<TResult>> GetItemsAsync<TResult>(
            Expression<Func<TDocument, bool>> predicate,
            Expression<Func<TDocument, TResult>> selector)
        {
            IDocumentQuery<TResult> query = context.Client.CreateDocumentQuery<TDocument>(
                collectionUri,
                new FeedOptions { MaxItemCount = 1 }) // TODO: Should not be hard-coded.
                .Where(globalFilter)
                .Where(predicate)
                .Select(selector)
                .AsDocumentQuery();

            logger.LogDocumentQuery(query);

            return await query.ExecuteAllAsync().ConfigureAwait(false);
        }

        public async Task<Document> CreateItemAsync(TDocument item)
        {
            Check.NotNull(item, nameof(item));

            logger.LogDocumentCreate(item);

            try
            {
                return await context.Client.CreateDocumentAsync(
                    collectionUri, item, disableAutomaticIdGeneration: true).ConfigureAwait(false);
            }
            catch (DocumentClientException ex)
            when (ex.StatusCode == HttpStatusCode.Conflict)
            {
                throw new EntityAlreadyExistsException(
                    "A document with same ID already exists",
                    ex);
            }
        }

        public async Task UpdateItemAsync(TDocument item)
        {
            Check.NotNull(item, nameof(item));

            logger.LogDocumentUpdate(item);

            Uri documentUri = CreateDocumentUri(item.Id);

            // This is needed for optimistic concurrency.
            // ETag here represents document version.
            var ac = new AccessCondition
            {
                Condition = item.ETag,
                Type = AccessConditionType.IfMatch
            };

            try
            {
                await context.Client.ReplaceDocumentAsync(
                    documentUri,
                    item,
                    new RequestOptions
                    {
                        AccessCondition = ac
                    }).ConfigureAwait(false);

            }
            catch (DocumentClientException ex)
            when (ex.StatusCode == HttpStatusCode.PreconditionFailed)
            {
                throw new ConcurrencyViolationException(
                    "The document was updated in the database. Reread it and repeat.",
                    ex);
            }
        }

        public async Task DeleteItemAsync(string id)
        {
            Uri documentUri = CreateDocumentUri(id);

            // TODO: Add global filter support.
            await context.Client.DeleteDocumentAsync(documentUri).ConfigureAwait(false);
        }

        private Uri CreateDocumentUri(string id)
        {
            return UriFactory.CreateDocumentUri(context.DatabaseId, context.CollectionId, id);
        }
    }
}
