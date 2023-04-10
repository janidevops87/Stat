using System;
using System.Net;

namespace Statline.Common.Infrastructure.Configuration.Database
{
    internal class DatabaseSettingsRaw
    {
        public NetworkCredential Credential { get; set; }
        public string DatabaseName { get; set; }
        public string ConnectionStringName { get; set; }
        public bool EnableSensitiveDataLogging { get; set; }
        public TimeSpan? CommandTimeout { get; set; }
        public RetryOnFailureSettings RetryOnFailure { get; set; }
    }
}
