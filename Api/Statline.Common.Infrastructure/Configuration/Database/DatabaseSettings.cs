using System;

namespace Statline.Common.Infrastructure.Configuration.Database
{
    public class DatabaseSettings
    {
        public string ConnectionString { get; internal set; }
        public bool EnableSensitiveDataLogging { get; internal set; }
        public TimeSpan? CommandTimeout { get; internal set; }
        public RetryOnFailureSettings RetryOnFailure { get; internal set; }
    }
}
