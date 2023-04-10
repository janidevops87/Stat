namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.CosmosDb
{
    public class CosmosDbContextOptions
    {
        public CosmosDbOptions CosmosDbOptions { get; set; }
        public bool EnableDetailedErrors { get; set; }
        public bool EnableSensitiveDataLogging { get; set; }
    }
}
