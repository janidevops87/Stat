using Microsoft.Extensions.Logging;
using Serilog.Extensions.Logging;

namespace Statline.Extensions.Logging.Email
{
    /// <summary>
    /// The reason for this class to exist 
    /// is overriding Serilog's provider alias.
    /// Also, it can be referenced in some configuration methods like
    /// <see cref="FilterLoggingBuilderExtensions.AddFilter{T}(ILoggingBuilder, string, LogLevel)"/>
    /// as type parameter.
    /// </summary>
    /// <dev>
    /// By default the configuration system
    /// will search (see https://github.com/aspnet/Logging/blob/dev/src/Microsoft.Extensions.Logging/LoggerRuleSelector.cs)
    /// a section by a provider alias, defined as "Serilog":
    /// https://github.com/serilog/serilog-extensions-logging/blob/d29a1b64f1619303973074981bd7ed08ce6c1d22/src/Serilog.Extensions.Logging/Extensions/Logging/SerilogLoggerProvider.cs#L24
    /// But we're trying to hide existence of Serilog and pretend there is
    /// an Email logger provider.
    /// </dev>
    [ProviderAlias("Email")]
    public class EmailLoggerProvider : SerilogLoggerProvider
    {
        public EmailLoggerProvider(Serilog.ILogger logger = null, bool dispose = false) 
            : base(logger, dispose)
        {

        }
    }
}
