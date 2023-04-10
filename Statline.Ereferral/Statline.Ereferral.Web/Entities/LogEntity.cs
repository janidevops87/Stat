using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Statline.Ereferral.Web.Entities
{
    [Table("Log")]
    public class LogEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public DateTime CreatedTime { get; set; }
        public int? EventId { get; set; }
        public string LogLevel { get; set; }
        public string Message { get; set; }
    }
}