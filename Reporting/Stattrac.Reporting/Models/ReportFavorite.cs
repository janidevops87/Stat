using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    public class ReportFavorite
    {
        public int ReportFavoriteID { get; set; }
        public int ReportID { get; set; }
        public int WebPersonID { get; set; }
        public int SortOrder { get; set; }
        public DateTime LastModified { get; set; }
    }
}
