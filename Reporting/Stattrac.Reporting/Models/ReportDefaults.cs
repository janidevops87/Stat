using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    public class ReportDefaults
    {
        public string StartDate { get; set; }
        public string StartTime { get; set; }
        public string EndDate { get; set; }
        public string EndTime { get; set; }
        public bool IsDateOnly { get; set; }
        public Int32? ReportDateTypeId { get; set; }
        public Int32? SourceCodeTypeId { get; set; }
        public Int32? ReportGroupId { get; set; }
        public bool BlockEventLog { get; set; }
    }
}
