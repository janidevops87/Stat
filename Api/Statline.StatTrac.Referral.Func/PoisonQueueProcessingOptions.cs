using System;

namespace Statline.StatTrac.Api.Func
{
    class PoisonQueueProcessingOptions
    {
        public static readonly int DefaultMaxRetryCount = 6;
        public static readonly TimeSpan DefaultMaxDelay = TimeSpan.FromSeconds(30.0);

        public int MaxRetryCount { get; set; } = DefaultMaxRetryCount;
        public TimeSpan MaxRetryDelay { get; set; } = DefaultMaxDelay;
    }
}
