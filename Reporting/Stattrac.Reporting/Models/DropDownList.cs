using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    
    public class DropDownList
    {
        [Key]
        public Int32 value { get; set; }
        public string label { get; set; }

    }
}
