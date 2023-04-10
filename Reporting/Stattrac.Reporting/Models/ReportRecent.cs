using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    public class ReportRecent
    {
        public int ReportRecentID { get; set; }
        public int ReportID { get; set; }
        public int WebPersonID { get; set; }
        public DateTime LastModified { get; set; }
    }
}
