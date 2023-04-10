using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Stattrac.Reporting.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Repository
{
    public class RegistryDbContext: DbContext
    {
        public static readonly LoggerFactory _myLoggerFactory =
            new LoggerFactory(new[] {new Microsoft.Extensions.Logging.Debug.DebugLoggerProvider()});

        public RegistryDbContext(DbContextOptions<RegistryDbContext> options)
            : base(options)
        {
        }

        internal DbSet<DropDownList> GetEventMainCategoryDropDownList { get; set; }
        internal DbSet<DropDownList> GetEventSubCategoryDropDownList { get; set; }

        internal DbSet<RegistryState> GetRegistryOwnerStates { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder
                .Entity<Report>(eb =>
                {
                    eb.HasNoKey();
                });
            modelBuilder
                .Entity<ReportDefaults>(eb =>
                {
                    eb.HasNoKey();
                });
        }
    }
}
