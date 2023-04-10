using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Referral.Entities
{
    [Table("WebPerson")]
    public class WebPerson
    {
        [Key]
        public int WebPersonId { get; set; }
        [StringLength(15)]
        public string WebPersonUserName { get; set; }
        [StringLength(20)]
        public string WebPersonPassword { get; set; }
        public int PersonId { get; set; }
        public Person Person { get; set; }
    }
}
