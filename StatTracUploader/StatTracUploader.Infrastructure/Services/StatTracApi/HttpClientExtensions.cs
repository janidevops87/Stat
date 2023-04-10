using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.Common.Utilities;
using System;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi
{
    internal static class HttpClientExtensions
    {
        public static async Task<TResult> SendAndUnwrapAsync<TResult>(
           this HttpClient httpClient,
           Uri requestUri,
           HttpMethod httpMethod,
           object? content = null,
           CancellationToken cancellationToken = default)
        {
            Check.NotNull(httpClient, nameof(httpClient));

            var response = await httpClient.SendAsync<TResult>(
                requestUri,
                httpMethod,
                content,
                ensureSuccessStatusCode: true,
                cancellationToken).ConfigureAwait(false);

            return response.Content ?? throw new InvalidOperationException("Response content is empty");
        }
    }
}
