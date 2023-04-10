using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    public class Report
    {
        public string ReportType { get; set; }
        public string ReportName { get; set; }
        public string Url { get; set; }

        public Int32 ReportID { get; set; }

        public string CustomReportControlName { get; set; }

    }
}
