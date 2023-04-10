using System.Collections.Generic;
using System.Threading.Tasks;
using Registry.API.ViewModels;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public interface IReportDataProvider
    {
        Task<List<ReportDbEntity>> RegistryStatistics(string states);
    }
}
