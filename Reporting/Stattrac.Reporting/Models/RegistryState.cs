using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Models
{
    
    public class RegistryState
    {
        [Key]
        public string State { get; set; }
        public string FullName { get; set; }
        public int Value { get; set; }
    }
}
