using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Statline.Ereferral.Web.Entities;
using System;

namespace Statline.Ereferral.Web.Contexts
{
    public class TransactionContext : IdentityDbContext<EreferralUser, EreferralRole, Guid>, ITransactionContext
    {
        public TransactionContext(DbContextOptions<TransactionContext> options) : base(options)
        {
        }

        public DbSet<LogEntity> Log { get; set; }
        public DbSet<AppSettingEntity> AppSetting { get; set; }
    }
}