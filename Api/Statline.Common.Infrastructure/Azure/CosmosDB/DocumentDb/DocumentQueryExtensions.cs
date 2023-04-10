using Microsoft.Azure.Documents.Linq;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb
{
    internal static class DocumentQueryExtensions
    {
        public static async Task<List<TResult>> ExecuteAllAsync<TResult>(
            this IDocumentQuery<TResult> query,
            CancellationToken token = default(CancellationToken))
        {
            var results = new List<TResult>();

            while (query.HasMoreResults)
            {
                var queryResult = await query.ExecuteNextAsync<TResult>().ConfigureAwait(false);
                results.AddRange(queryResult);
            }

            return results;
        }
    }
}
