namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Heartbeat
{
    internal class SqlServerHealthReport
    {
        public bool IsHealthy { get; set; }
        public string? ErrorDescription { get; set; }
    }
}
