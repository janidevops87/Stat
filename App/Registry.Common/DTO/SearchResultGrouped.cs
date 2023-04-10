using System.Collections.Generic;

namespace Registry.Common.DTO
{
    public class SearchResultGrouped
    {
        public SearchResultGrouped()
        {
            Items = new List<SearchResult>();
        }

        public List<SearchResult> Items { get; set; }

        public int Total { get; set; }
        public string State { get; set; }
        public int Order { get; set; }
    }
}