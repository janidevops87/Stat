using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using Registry.API.ViewModels;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public class ReportDataProvider : EFDataProviderBase, IReportDataProvider
    {
        public async Task<List<ReportDbEntity>> RegistryStatistics(string states)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure<ReportDbEntity, Tuple<string>>("sps_Common_RegistryStatisticsReport", Tuple.Create(states), context)).ToList();
            }
        }
    }
}
