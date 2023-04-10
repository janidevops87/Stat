using System;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider
{
    internal class HostServiceWorkerOptions
    {
        public TimeSpan HealthCheckPeriod { get; set; }
    }
}
