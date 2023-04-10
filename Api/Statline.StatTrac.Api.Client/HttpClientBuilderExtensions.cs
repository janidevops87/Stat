using Polly;
using Polly.Extensions.Http;

namespace Microsoft.Extensions.DependencyInjection;

internal static class HttpClientBuilderExtensions
{
    private const int RetryCount = 3;

    public static IHttpClientBuilder AddRetryPolicy<TClient>(
        this IHttpClientBuilder builder)
    {
        builder.AddPolicyHandler((services, request) => GetRetryPolicy<TClient>(services));
        return builder;
    }

    private static IAsyncPolicy<HttpResponseMessage> GetRetryPolicy<TClient>(
        IServiceProvider serviceProvider)
    {
        return
            HttpPolicyExtensions
            .HandleTransientHttpError()
            // exponential backoff
            .WaitAndRetryAsync(
                retryCount: RetryCount,
                sleepDurationProvider: retryAttempt => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)),
                onRetry: (res, delay, retryAttempt, ctx) =>
                {
                    var logger = serviceProvider.GetRequiredService<ILogger<TClient>>();

                    if (res.Exception is not null)
                    {
                        LogRetryAttemtAfterException(logger, res.Result, res.Exception, delay, retryAttempt);
                    }
                    else
                    {
                        LogRetryAttemtAfterHttpError(logger, res.Result, delay, retryAttempt);
                    }
                });
    }

    private static void LogRetryAttemtAfterException<TClient>(
        ILogger<TClient> logger,
        HttpResponseMessage responseMessage,
        Exception exception,
        TimeSpan delay,
        int retryAttempt)
    {
        logger.LogWarning(
            "Failed to make request to {RequestUri}, error message: '{ErrorMessage}'. " +
            "Delaying for {delay}, then making retry {retry} of {RetryCount}.",
            responseMessage?.RequestMessage?.RequestUri,
            exception.Message,
            delay,
            retryAttempt,
            RetryCount);
    }

    private static void LogRetryAttemtAfterHttpError<TClient>(
        ILogger<TClient> logger,
        HttpResponseMessage responseMessage,
        TimeSpan delay,
        int retryAttempt)
    {
        logger.LogWarning(
            "Failed to make request to {RequestUri}, status code {StatusCode} {ReasonPhrase}. " +
            "Delaying for {delay}, then making retry {retry} of {RetryCount}.",
            responseMessage.RequestMessage?.RequestUri,
            (int)responseMessage.StatusCode,
            responseMessage.ReasonPhrase,
            delay,
            retryAttempt,
            RetryCount);
    }
}
