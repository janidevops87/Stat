using System.Collections.Generic;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public interface ISearchDataProvider
    {
        Task<IEnumerable<SearchResult>> SearchRegistry(SearchRequest registrySearchParams);
        Task<SearchResult> SearchDlaRegistry(int id);
    }
}
