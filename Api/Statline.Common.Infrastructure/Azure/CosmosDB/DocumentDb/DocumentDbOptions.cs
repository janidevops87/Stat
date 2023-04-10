using System;

namespace Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb
{
    public class DocumentDbOptions
    {
        public Uri Url { get; set; }
        public string AuthKey { get; set; }
        public string DatabaseId { get; set; }
        public string CollectionId { get; set; }
    }
}
