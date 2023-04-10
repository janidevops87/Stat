using System;
using System.Collections.ObjectModel;

namespace Statline.Common.Infrastructure.Configuration.Database
{
    public class RetryOnFailureSettings
    {
        public static readonly int DefaultMaxRetryCount = 6;
        public static readonly TimeSpan DefaultMaxDelay = TimeSpan.FromSeconds(30);
        public int MaxRetryCount { get; set; } = DefaultMaxRetryCount;
        public TimeSpan MaxRetryDelay { get; set; } = DefaultMaxDelay;
        public Collection<int> AdditionalErrorNumbers { get; set; }
    }
}
