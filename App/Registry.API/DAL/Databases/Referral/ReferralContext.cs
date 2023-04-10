using System.Data.Entity;
using Registry.API.DAL.Databases.Referral.Entities;

namespace Registry.API.DAL.Databases.Referral
{
    public class ReferralContext : DbContextBase
    {
        public ReferralContext(string name) : base(name)
        {
        }

        public virtual IDbSet<Person> Person { get; set; }
        public virtual IDbSet<WebPerson> WebPerson { get; set; }
    }
}