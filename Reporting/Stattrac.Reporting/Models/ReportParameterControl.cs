using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    
    public class ReportParameterControl
    {
        [Key]
        public string ReportControlName { get; set; }
        public string ReportParamSectionName { get; set; }

    }
}
