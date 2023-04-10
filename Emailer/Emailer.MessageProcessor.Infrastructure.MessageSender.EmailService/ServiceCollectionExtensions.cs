using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.EmailService;

public static class ServiceCollectionExtensions
{
    public static void AddEmailServiceMessageSender(
       this IServiceCollection services,
       IConfiguration config)
    {
        Check.NotNull(services);
        Check.NotNull(config);
        services.AddSingleton<IEmailMessageSenderService, EmailServiceMessageSenderService>();
        services.Configure<EmailServiceMessageSenderServiceOptions>(config);
    }
}
