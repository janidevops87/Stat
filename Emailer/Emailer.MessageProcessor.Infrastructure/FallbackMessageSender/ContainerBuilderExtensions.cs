using Autofac;
using Emailer.MessageProcessor.Domain;
using Emailer.MessageProcessor.Infrastructure.Common;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;


namespace Emailer.MessageProcessor.Infrastructure.FallbackMessageSender
{
    public static class ContainerBuilderExtensions
    {
        public static void AddFallbackMessageSenderDecorator(
            this ContainerBuilder containerBuilder,
            IConfiguration config)
        {
            Check.NotNull(containerBuilder, nameof(containerBuilder));

            containerBuilder.PopulateFromServices(services =>
            {
                services
                    .AddOptions<FallbackMessageSenderDecoratorOptions>()
                    .ValidateDataAnnotations();
                services.Configure<FallbackMessageSenderDecoratorOptions>(config);
            });

            containerBuilder.RegisterDecorator<FallbackMessageSenderDecorator, IEmailMessageSenderService>();
        }
    }
}
