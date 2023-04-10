using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Serilog;
using Statline.Common.Configuration.Email.Sender;
using Statline.Common.Utilities;
using Statline.Extensions.Logging.Email;

namespace Statline.Extensions.Logging
{
    public static class LoggingBuilderExtensions
    {
        /// <summary>
        /// Adds an email logger to the logging pipeline.
        /// </summary>
        /// <param name="loggingBuilder">
        /// The logging builder to configure.
        /// </param>
        /// <param name="config">
        /// The root configuration, used to find section specified by 
        /// <paramref name="loggerSettingsPath"/> as well as to resolve
        /// reference to SMTP server configuration.
        /// </param>
        /// <param name="loggerSettingsPath">
        /// The path to configuration section which specifies 
        /// ".Net Core style" filtering rules.
        /// The section should also contain email sender settings
        /// under the "EmailSender" subsection.
        /// </param>
        public static ILoggingBuilder AddEmailLog(
            this ILoggingBuilder loggingBuilder,
            IConfiguration config,
            string loggerSettingsPath)
        {
            Check.NotNull(loggingBuilder, nameof(loggingBuilder));
            Check.NotNull(config, nameof(config));

            string senderSettingsPath =
                loggerSettingsPath + ":EmailSender";

            var senderSettings = config
                .GetEmailSenderSettings(senderSettingsPath);

            var loggerSettings = config.Get<EmailLoggerSettings>();

            var serilogLogger = new LoggerConfiguration()
              .Enrich.FromLogContext()
              // This email logger sends emails in batches using the 
              // thread pool. This may be not ideal if server is
              // highly loaded and the thread pool is busy. If emails
              // need to be sent more predictably and reliably, a background
              // sink should be used (uses a dedicated thread).
              .WriteTo.Email(
                    connectionInfo: senderSettings.ToSerilogEmailConnectionInfo(),
                    period: loggerSettings.BatchSendPeriod)
              .CreateLogger();

            return loggingBuilder
              .AddSerilogAsEmailLoggerProvider(serilogLogger, dispose: true);
        }

        private static ILoggingBuilder AddSerilogAsEmailLoggerProvider(
            this ILoggingBuilder builder,
            Serilog.ILogger logger,
            bool dispose)

        {
            return builder.AddProvider(new EmailLoggerProvider(logger, dispose));
        }
    }
}
