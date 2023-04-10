using Newtonsoft.Json;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Infrastructure.Http
{
    /// <summary>
    /// Base class for implementing REST clients with optional authentication.
    /// </summary>
    public abstract class RestServiceClient : IDisposable
    {
        private readonly HttpClient httpClient = new HttpClient();
        private readonly IAuthenticationProvider authProvider;
        private readonly JsonMediaTypeFormatter jsonMediaTypeFormatter;
        private readonly MediaTypeFormatter[] mediaTypeFormatters;


        //private static readonly JsonSerializerSettings jsonSerializerSettings =
        //   new JsonSerializerSettings
        //   {
        //       // To allow deserializing to properties 
        //       // with private setters.
        //       //ContractResolver = new PrivateSetterContractResolver()
        //   };

        protected RestServiceClient(
            Uri serverUrl,
            string basePath,
            IAuthenticationProvider authProvider)
        {
            Check.NotNull(serverUrl, nameof(serverUrl));
            Check.NotNull(basePath, nameof(basePath));

            httpClient.BaseAddress = new Uri(serverUrl, basePath);

            this.authProvider = authProvider;

            jsonMediaTypeFormatter = new JsonMediaTypeFormatter();

            mediaTypeFormatters = new[] { jsonMediaTypeFormatter };
        }

        protected Task SendAsync(
          Uri requestUri,
          HttpMethod httpMethod,
          object content = null)
        {
            return SendAsync<object>(requestUri, httpMethod, content);
        }

        protected async Task<TResult> SendAsync<TResult>(
            Uri requestUri,
            HttpMethod httpMethod,
            object content = null) where TResult : class
        {
            Check.NotNull(requestUri, nameof(requestUri));

            if (content != null &&
                (httpMethod == HttpMethod.Get || httpMethod == HttpMethod.Head))
            {
                throw new ArgumentException(
                    $"Unsupported HTTP method '{httpMethod}' for non-empty content", nameof(httpMethod));
            }

            if (requestUri.IsAbsoluteUri)
            {
                throw new ArgumentException("The URI must be relative", nameof(requestUri));
            }

            var request = new HttpRequestMessage(
                httpMethod,
                requestUri);

            if (content != null)
            {
                if (content is HttpContent httpContent)
                {
                    request.Content = httpContent;
                }
                else
                {
                    request.Content = new ObjectContent(
                        content.GetType(),
                        content,
                        jsonMediaTypeFormatter);
                }
            }

            if (authProvider != null)
            {
                var authResult = await authProvider.AuthenticateAsync().ConfigureAwait(false);

                request.Headers.Authorization =
                    new AuthenticationHeaderValue(authResult.AccessTokenType, authResult.AccessToken);
            }

            using (var response = await httpClient.SendAsync(request).ConfigureAwait(false))
            {
                response.EnsureSuccessStatusCode();

                if (response.Content == null)
                    return null;

                return await response.Content
                    .ReadAsAsync<TResult>(mediaTypeFormatters)
                    .ConfigureAwait(false);
            }
        }

        public virtual void Dispose()
        {
            httpClient.Dispose();
        }

        /// <summary>
        /// A helper method for building relative URIs with query parameters.
        /// </summary>
        protected Uri BuildRequestUri(string path, IDictionary<string, string> parameters)
        {
            Check.NotNull(path, nameof(path));
            Check.NotNull(parameters, nameof(parameters));
            Check.HasNoNulls(parameters.Keys, $"{nameof(parameters)}.{nameof(parameters.Keys)}");
            Check.HasNoNulls(parameters.Values, $"{nameof(parameters)}.{nameof(parameters.Values)}");

            var uriStringBuilder = new StringBuilder(path);

            uriStringBuilder.Append('?');

            foreach (var parameter in parameters)
            {
                uriStringBuilder.Append(parameter.Key);
                uriStringBuilder.Append('=');
                uriStringBuilder.Append(parameter.Value);
                uriStringBuilder.Append('&');
            }

            return new Uri(
                uriStringBuilder.ToString(0, uriStringBuilder.Length - 1),
                UriKind.Relative);
        }
    }
}
