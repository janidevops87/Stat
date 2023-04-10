namespace Statline.StatTrac.Api.Infrastructure.RestClient.Model
{
    public class SqlServerHealthReport
    {
        public bool IsHealthy { get; set; }
        public string ErrorDescription { get; set; }
    }
}
