using System;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.CosmosDb
{
    public class CosmosDbOptions
    {
        public string DatabaseName { get; set; }
        public Uri AccountEndpoint { get; set; }
        public string AccountKey { get; set; }
    }
}
