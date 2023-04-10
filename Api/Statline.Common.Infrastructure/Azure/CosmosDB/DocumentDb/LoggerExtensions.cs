using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using Microsoft.Azure.Documents.Linq;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb
{
    internal static class LoggerExtensions
    {
        public static void LogOptions(
            this ILogger logger,
            DocumentDbOptions options)
        {
            logger.LogInformation(
                $@"DocumentDB client initialized with following options:
                {
                    JsonConvert.SerializeObject(
                       new // Use new object to exclude auth key.
                       {
                           options.DatabaseId,
                           options.CollectionId,
                           options.Url
                       },
                       Formatting.Indented)
                }");
        }

        public static void LogEnsuringDatabase(
           this ILogger logger,
           string databaseId)
        {
            logger.LogInformation($"Ensuring database '{databaseId}'...");
        }

        public static void LogDatabaseEnsured(
            this ILogger logger,
            string databaseId,
            ResourceResponse<Database> result)
        {
            bool created = result.StatusCode == System.Net.HttpStatusCode.Created;
            logger.LogInformation($"Database '{databaseId}' {(created ? "created" : "existed")}.");
        }

        public static void LogEnsuringCollection(
            this ILogger logger,
            string databaseId,
            string collectionId)
        {
            logger.LogInformation($"Ensuring collection '{collectionId}' in database '{databaseId}'...");
        }

        public static void LogCollectionEnsured(
            this ILogger logger,
            string databaseId,
            string collectionId,
            ResourceResponse<DocumentCollection> result)
        {
            bool created = result.StatusCode == System.Net.HttpStatusCode.Created;
            logger.LogInformation($"Collection '{collectionId}' in database '{databaseId}' {(created ? "created" : "existed")}.");
        }

        public static void LogDocumentQuery(this ILogger logger, IDocumentQuery query)
        {
            logger.LogDebug($"Executing document query: '{query}'.");
        }

        public static void LogDocumentUpdate<TDocument>(
            this ILogger logger,
            TDocument document) where TDocument : Resource
        {
            logger.LogDebug(
                $"Updating document with id='{document.Id}', " +
                $"ETag='{document.ETag}', " +
                $"CLR type='{document.GetType().Name}'.");
        }

        public static void LogDocumentCreate<TDocument>(
            this ILogger logger,
            TDocument document) where TDocument : Resource
        {
            logger.LogDebug(
                $"Creating document with id='{document.Id}', " +
                $"CLR type='{document.GetType().Name}'.");
        }
    }
}
