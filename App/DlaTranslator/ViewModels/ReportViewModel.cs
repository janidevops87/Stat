using System.Collections.Generic;

namespace Registry.Web.UI.ViewModels
{
    public class ReportViewModel
    {
        public ReportViewModel()
        {
            EntityList = new List<ReportEntity>();
        }

        public List<ReportEntity> EntityList { get; set; }

        public long GrandTotal { get; set; }
    }

    public class ReportEntity
    {
        public string StateName { get; set; }
        public string StateCode { get; set; }
        public long WebRegistryCount { get; set; }
        public long StateRegistryCount { get; set; }
        public decimal WebRegistryPercent { get; set; }
        public decimal StateRegistryPercent { get; set; }
        public long TotalCount { get; set; }
    }
}