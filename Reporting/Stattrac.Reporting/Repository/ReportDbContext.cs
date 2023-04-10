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
    public class ReportDbContext: DbContext
    {
        public static readonly LoggerFactory _myLoggerFactory =
            new LoggerFactory(new[] {new Microsoft.Extensions.Logging.Debug.DebugLoggerProvider()});

        public ReportDbContext(DbContextOptions<ReportDbContext> options)
            : base(options)
        {
        }

        internal DbSet<Report> Reports { get; set; }
        internal DbSet<ReportDefaults> ReportDefaults { get; set; }
        internal DbSet<WebPerson> WebPerson { get; set; }
        internal DbSet<ReportParameterControl> ParameterControls { get; set; }
        internal DbSet<DropDownList> ReportDateTypeDropDown { get; set; }
        internal DbSet<DropDownList> ReportGroupDropDown { get; set; }
        internal DbSet<DropDownList> ReportOrganizationDropDown { get; set; }
        internal DbSet<DropDownListStringId> ReportSourceCodeDropDown { get; set; }
        internal DbSet<DropDownList> ReportCoordinatorDropDown { get; set; }
        internal DbSet<DropDownListStringId> SortTypeDropDown { get; set; }
        internal DbSet<DropDownList> ReportCauseOfDeathDropDown { get; set; }
        internal DbSet<DropDownList> ReportMonthDropDown { get; set; }
        internal DbSet<DropDownList> ReportYearDropDown { get; set; }
        internal DbSet<DropDownList> ReportOrganizationTypeDropDown { get; set; }
        internal DbSet<DropDownList> ReportQATrackingTypeDropDown { get; set; }
        internal DbSet<DropDownList> ReportAlertGroupDropDown { get; set; }
        internal DbSet<DropDownList> MessageImportOrganizationsDropDown { get; set; }
        internal DbSet<DropDownList> PersonListByOrganizationDropDown { get; set; }
        internal DbSet<DropDownList> StattracUserDropDown { get; set; }
        internal DbSet<DropDownList> GetPendingReferralTypeDropDownList { get; set; }
        internal DbSet<DropDownList> GetScheduleOrganizationDropDownList { get; set; }
        internal DbSet<DropDownList> GetScheduleGroupsDropDownList { get; set; }
        internal DbSet<DropDownList> GetScreeningCriteriaOrganizationsDropDown { get; set; }
        internal DbSet<DropDownList> GetScreeningCriteriaGroupsDropdownList { get; set; }
        internal DbSet<DropDownList> GetSchedulePeopleDropDownList { get; set; }
        internal DbSet<DropDownList> GetApproachPersonDropDownList { get; set; }
        internal DbSet<DropDownList> GetStateDropDownList { get; set; }
        internal DbSet<DropDownList> GetOrganizationByStateAndTypeDropDownList { get; set; }
        internal DbSet<ReportRecent> ReportRecents { get; set; }
        internal DbSet<ReportFavorite> ReportFavorites { get; set; }
        internal DbSet<DropDownList> GetReferralTypeDropDownList { get; set; }
        internal DbSet<Schedule> GetSchedules { get; set; }
        internal DbSet<ScheduleLock> GetScheduleLock { get; set; }
        internal DbSet<ShiftStatusContainer> ShiftStatus { get; set; }
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
            modelBuilder
                .Entity<Schedule>(eb =>
                {
                    eb.HasNoKey();
                });
            modelBuilder
                .Entity<ShiftStatusContainer>(eb =>
                {
                    eb.HasNoKey();
                });
            modelBuilder
                .Entity<ScheduleLock>(eb =>
                {
                    eb.HasNoKey();
                });
        }
    }
}
