using Autofac;
using Emailer.MessageProcessor.Domain;
using Emailer.MessageProcessor.Infrastructure.Common;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;


namespace Emailer.MessageProcessor.Infrastructure.RetryMessageSender
{
    public static class ContainerBuilderExtensions
    {
        public static void AddRetryMessageSenderDecorator(
            this ContainerBuilder containerBuilder,
            IConfiguration config)
        {
            Check.NotNull(containerBuilder, nameof(containerBuilder));

            containerBuilder.PopulateFromServices(services =>
            {
                services.Configure<RetryMessageSenderDecoratorOptions>(config);
            });

            containerBuilder.RegisterDecorator<RetryMessageSenderDecorator, IEmailMessageSenderService>();
        }
    }
}
