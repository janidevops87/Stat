using Microsoft.EntityFrameworkCore;
using Statline.StatTracUploader.App;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.CosmosDb
{
    internal class CosmosReferralDbContext : ReferralDbContext<CosmosReferralDbContext>
    {
        public CosmosReferralDbContext(DbContextOptions<CosmosReferralDbContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.HasDefaultContainer("Referrals");
        }
    }
}
