using System;

namespace Statline.StatTrac.Api.Infrastructure.RestClient.Model
{
    public class ApiHealthReport
    {
        public bool IsHealthy { get; set; }
        public DateTimeOffset TimeStamp { get; set; }
        public SqlServerHealthReport OnPremSqlServerHealth { get; set; }
    }
}
