using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Polly;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.MessageProcessor.Infrastructure.RetryMessageSender
{
    public class RetryMessageSenderDecorator : IEmailMessageSenderService
    {
        private readonly IEmailMessageSenderService childMessageSender;
        private readonly ILogger logger;
        private readonly AsyncPolicy errorHandlingPolicy;

        public RetryMessageSenderDecorator(
            IEmailMessageSenderService childMessageSender,
            IOptions<RetryMessageSenderDecoratorOptions> options,
            ILogger<RetryMessageSenderDecorator> logger)
        {
            Check.NotNull(childMessageSender, nameof(childMessageSender));
            Check.NotNull(logger, nameof(logger));

            this.childMessageSender = childMessageSender;
            this.logger = logger;

            ValidateOptions(options);

            var optionsValue = options.Value;

            errorHandlingPolicy = Policy
                // TODO: Think of more fine grain exceptions 
                // handling, catching all is not good!
                // This approach just replicates how it was done in 
                // the legacy app.
                .Handle<Exception>()
                // For retry we use exponential back-off.
                .WaitAndRetryAsync(
                    optionsValue.RetryCount,
                    retryAttempt => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)));
        }

        public async Task SendMessageAsync(EmailMessage message, CancellationToken cancellationToken)
        {
            var context = new Context("SendMessageAsync",
                new Dictionary<string, object> { ["message"] = message });

            await errorHandlingPolicy.ExecuteAsync(async (ctx, token) =>
            {
                logger.LogInformation($"Trying to send a message using {childMessageSender.GetType().FullName}.");
                await childMessageSender.SendMessageAsync(message, cancellationToken).ConfigureAwait(false);
            },
            context,
            cancellationToken,
            continueOnCapturedContext: false).ConfigureAwait(false);
        }

        private static void ValidateOptions(IOptions<RetryMessageSenderDecoratorOptions> options)
        {
            Check.NotNull(options, nameof(options));

            var optionsValue = options.Value;

            Check.BiggerOrEqual(optionsValue.RetryCount, 0, nameof(optionsValue.RetryCount));
        }
    }
}
