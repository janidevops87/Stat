using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Referral.Entities
{
    [Table("Person")]
    public class Person
    {
        [Key]
        public int PersonId { get; set; }
        public int OrganizationId { get; set; }
        [StringLength(50)]
        public string PersonFirst { get; set; }
        [StringLength(50)]
        public string PersonLast { get; set; }
        [NotMapped]
        public string FullName => string.Join(" ", PersonFirst, PersonLast);
    }
}
