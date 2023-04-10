using Statline.Common.Utilities;
using System;

namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Heartbeat
{
    internal class ApiHealthReport
    {
        public ApiHealthReport(
            bool isHealthy, 
            DateTimeOffset timeStamp, 
            SqlServerHealthReport onPremSqlServerHealth)
        {
            IsHealthy = isHealthy;
            TimeStamp = timeStamp;
            OnPremSqlServerHealth = 
                Check.NotNull(onPremSqlServerHealth, nameof(onPremSqlServerHealth));
        }

        public bool IsHealthy { get; }
        public DateTimeOffset TimeStamp { get; }
        public SqlServerHealthReport OnPremSqlServerHealth { get; }
    }
}
