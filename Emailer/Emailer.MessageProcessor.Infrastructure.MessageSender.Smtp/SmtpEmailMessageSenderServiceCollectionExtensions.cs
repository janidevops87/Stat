using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.Smtp
{
    public static class SmtpEmailMessageSenderServiceCollectionExtensions
    {
        //public static void AddSmtpMessageSender(
        //    this IServiceCollection services,
        //    Action<SmtpEmailMessageSenderOptions> setupAction)
        //{
        //    Check.NotNull(services, nameof(services));
        //    Check.NotNull(setupAction, nameof(setupAction));

        //    services.Configure(setupAction);
        //    services.AddSingleton<IEmailMessageSenderService, SmtpEmailMessageSenderService>();
        //}

        public static void AddSmtpMessageSender(
           this IServiceCollection services,
           IConfiguration config,
           string settingsPath)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            services.ConfigureEmailSenderSettingsOptions(config, settingsPath);
            services.AddSingleton<IEmailMessageSenderService, SmtpEmailMessageSenderService>();
        }

        //public static void AddSmtpMessageSenders(
        //  this IServiceCollection services,
        //  IConfiguration config)
        //{
        //    var failoverSenderOptions = LoadOptions(config);

        //    services.AddSingleton<IEmailMessageSenderService, FailoverSmtpEmailMessageSenderService>(sp =>
        //    {
        //        var servers = failoverSenderOptions.Servers.Select(
        //            opt => ActivatorUtilities.CreateInstance<SmtpEmailMessageSenderService>(
        //                sp, Options.Create(opt)));

        //        return ActivatorUtilities.CreateInstance<FailoverSmtpEmailMessageSenderService>(sp, servers);
        //    });
        //}

        //private static FailoverSmtpEmailMessageSenderOptions LoadOptions(IConfiguration config)
        //{
        //    var failoverSenderOptions = new FailoverSmtpEmailMessageSenderOptions();

        //    ConfigurationBinder.Bind(config, failoverSenderOptions);

        //    if (failoverSenderOptions.Servers == null ||
        //        failoverSenderOptions.Servers.Length == 0)
        //    {
        //        throw new InvalidOperationException(
        //            $"'{nameof(failoverSenderOptions.Servers)}' section must be present and non-empty in config.");
        //    }

        //    return failoverSenderOptions;
        //}
    }
}
