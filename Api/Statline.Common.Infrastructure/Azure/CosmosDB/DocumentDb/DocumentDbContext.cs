using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Statline.Common.Infrastructure.Serialization.Json;
using Statline.Common.Utilities;
using System;
using System.Threading.Tasks;

namespace Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb
{
    public class DocumentDbContext<TDocument> : 
        IDocumentDbContext<TDocument>, 
        IDisposable
        where TDocument : class
    {
        // TODO: Pass this from outside if need to make configurable.
        private static readonly JsonSerializerSettings serializerSettings =
            new JsonSerializerSettings
            {
                // To allow deserializing to properties 
                // with private setters.
                ContractResolver = new PrivateSetterContractResolver()
            };

        private readonly DocumentClient client;
        private readonly ILogger logger;

        public IDocumentClient Client => client;

        public string DatabaseId { get; }
        public string CollectionId { get; }

        public DocumentDbContext(
            IOptions<DocumentDbOptions> options,
            ILogger<DocumentDbContext<TDocument>> logger)
        {
            Check.NotNull(options, nameof(options));
            Check.NotNull(logger, nameof(logger));

            this.logger = logger;

            var optionsValue = options.Value;

            ValidateOptions(optionsValue);


            logger.LogOptions(optionsValue);

            DatabaseId = optionsValue.DatabaseId;
            CollectionId = optionsValue.CollectionId;

            // NOTE: The service client encapsulates the endpoint 
            // and credentials and connection policy used to access 
            // the DocumentDB service. It is recommended to cache and 
            // reuse this instance within your application rather than 
            // creating a new instance for every operation.
            // Basically this means that repository should be 
            // configured as singleton in DI unless it holds
            // some non-shareable state.
            client = new DocumentClient(
                optionsValue.Url,
                optionsValue.AuthKey,
                serializerSettings);

            // We make this call synchronous since we're in constructor.
            // This means that instance of this class shouldn't be created
            // for every operation and ideally should be cached for
            // application lifetime.
            InitializeDbAsync().GetAwaiter().GetResult();
        }

        public void Dispose()
        {
            client?.Dispose();
        }

        private async Task InitializeDbAsync()
        {
            // NOTE: This context is intended to be reused,
            // and DB and collection check will not be done per each query,
            // but per context creation (which should be per app instance). 
            // This means that if the DB or collection
            // is deleted after context has been created and initialized,
            // subsequent queries will fail.
            await CreateDatabaseIfNotExistsAsync().ConfigureAwait(false);
            await CreateCollectionIfNotExistsAsync().ConfigureAwait(false);
        }

        private async Task CreateDatabaseIfNotExistsAsync()
        {
            logger.LogEnsuringDatabase(DatabaseId);

            var result = await client.CreateDatabaseIfNotExistsAsync(
                new Database { Id = DatabaseId }).ConfigureAwait(false);

            logger.LogDatabaseEnsured(DatabaseId, result);
        }

        private async Task CreateCollectionIfNotExistsAsync()
        {
            logger.LogEnsuringCollection(DatabaseId, CollectionId);

            var result = await client.CreateDocumentCollectionIfNotExistsAsync(
                        UriFactory.CreateDatabaseUri(DatabaseId),
                        new DocumentCollection { Id = CollectionId },
                        new RequestOptions
                        {
                            // TODO: This shouldn't be hard-coded.
                            OfferThroughput = 1000
                        }).ConfigureAwait(false);

            logger.LogCollectionEnsured(DatabaseId, CollectionId, result);
        }

        private void ValidateOptions(DocumentDbOptions options)
        {
            Check.NotNull(options, nameof(options));
            Check.NotNull(options.Url, nameof(options), nameof(options.Url));
            Check.NotEmpty(options.AuthKey, nameof(options.AuthKey));
            Check.NotEmpty(options.CollectionId, nameof(options.CollectionId));
            Check.NotEmpty(options.DatabaseId, nameof(options.DatabaseId));
        }
    }
}
