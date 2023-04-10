using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Enums;
using Statline.StatTrac.Domain.EReferrals;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.Referrals.Factory;
using Statline.StatTrac.Domain.RegistryStatuses;
using Statline.StatTrac.Domain.SubLocations;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Calls;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;
using Statline.StatTrac.Infrastructure.Persistence.Ef.EReferrals;
using Statline.StatTrac.Infrastructure.Persistence.Ef.LogEvents;
using Statline.StatTrac.Infrastructure.Persistence.Ef.RegistryStatuses;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef;

/// <summary>
/// NOTE: This is not a fully-fledged DB context. Its used just as a 
/// bridge between object model and existing SQL database. The entities are
/// basically DTOs, and the queries are done in raw SQL.
/// </summary>
public class ReferralDbContext<TContext> : DbContext
    where TContext : ReferralDbContext<TContext>
{
    internal TimeZoneInfo DefaultTimeZone => ValueConverters.DefaultTimeZone;

    public ReferralDbContext(DbContextOptions<TContext> options)
        : base(options)
    {
    }

    internal DbSet<Domain.TimeZones.TimeZone> TimeZones => Set<Domain.TimeZones.TimeZone>();
    internal DbSet<Call> Calls => Set<Call>();
    internal DbSet<RegistryStatus> RegistryStatuses => Set<RegistryStatus>();
    internal DbSet<Referral> Referrals => Set<Referral>();
    internal DbSet<Domain.LogEvents.LogEvent> LogEvents => Set<Domain.LogEvents.LogEvent>();
    internal DbSet<StatEmployee> StatEmployees => Set<StatEmployee>();
    internal DbSet<Person> Persons => Set<Person>();
    internal DbSet<Organization> Organizations => Set<Organization>();
    internal DbSet<OrganizationPhone> OrganizationPhones => Set<OrganizationPhone>();

    #region ReferralDetails
    internal DbSet<ReferralDetails> ReferralDetails => Set<ReferralDetails>();
    internal DbSet<Domain.Referrals.LogEvent> ReferralLogEvents => Set<Domain.Referrals.LogEvent>();
    internal DbSet<ReferralSecondary> SecondaryData => Set<ReferralSecondary>();
    #endregion ReferralDetails

    #region EReferrals
    internal DbSet<FacilityInfo> FacilityInfo => Set<FacilityInfo>();
    internal DbSet<ContactTitle> ContactTitle => Set<ContactTitle>();
    internal DbSet<HospitalUnit> HospitalUnit => Set<HospitalUnit>();
    internal DbSet<HospitalUnitAndFloor> HospitalUnitAndFloor => Set<HospitalUnitAndFloor>();
    internal DbSet<FacilityInfo> FacilityCodes => Set<FacilityInfo>();
    #endregion EReferrals

    protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
    {
        configurationBuilder
            .Properties<DateOnly?>()
            .HaveConversion<NullableDateOnlyConverter>();

        configurationBuilder
            .Properties<DateTimeOffset>()
            .HaveConversion<DefaultTimeZoneDateTimeOffsetToDateTimeConverter>();
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(this.GetType().Assembly);

        modelBuilder.Entity<Domain.Referrals.LogEvent>(b =>
        {
            b.HasNoKey();
        });

        modelBuilder.Entity<CallType>(b =>
        {
            b.ToTable(nameof(CallType));
        });

        modelBuilder.Entity<CallInsertResult>().HasNoKey();

        modelBuilder.Entity<RegistryStatus>(b =>
        {
            b.ToTable(nameof(RegistryStatus));
        });

        modelBuilder.Entity<RegistryStatusInsertResult>().HasNoKey();

        modelBuilder.Entity<Organization>(b =>
        {
            b.ToTable(nameof(Organization));
        });

        modelBuilder.Entity<SubLocation>();

        modelBuilder.Entity<CauseOfDeath>(b =>
        {
            b.ToTable(nameof(CauseOfDeath));
        });

        modelBuilder.Entity<Race>(b =>
        {
            b.ToTable(nameof(Race));
        });

        modelBuilder.Entity<Gender>(b =>
        {
            b.ToTable(nameof(Gender));
            // Property can't have the same name as enclosing class.
            b.Property(g => g.GenderName).HasColumnName("Gender");
        });

        modelBuilder.Entity<Domain.LogEvents.LogEvent>(b =>
        {
            b.ToTable(nameof(Domain.LogEvents.LogEvent));
        });

        modelBuilder.Entity<Domain.LogEvents.LogEventType>(b =>
        {
            b.ToTable(nameof(Domain.LogEvents.LogEventType));
        });

        modelBuilder.Entity<Domain.TimeZones.TimeZone>(b =>
        {
            b.ToTable(nameof(Domain.TimeZones.TimeZone));
        });

        modelBuilder.Entity<LogEventInsertResult>().HasNoKey();

        modelBuilder.Entity<IntegerHolder>().HasNoKey();
        modelBuilder.Entity<FacilityInfo>().HasNoKey();
        modelBuilder.Entity<ContactTitle>().HasNoKey();
        modelBuilder.Entity<HospitalUnit>().HasNoKey();
        modelBuilder.Entity<HospitalUnitAndFloor>().HasNoKey();
        modelBuilder.Entity<FacilityInfo>().HasNoKey();

        modelBuilder.HasDbFunction(() => EReferralCalculateCriteria(
            null, null, null, null, null, null, null, null, null, null, null));

        modelBuilder.HasDbFunction(() => EReferralCalculateCriteria_Organ(
            null, null, null, null, null, null, null, null, null, null, null, null, null));
    }

    internal IQueryable<ReferralCriteria> EReferralCalculateCriteria(
        int? Age,
        AgeUnit? AgeUnit,
        PersonGender? Gender,
        int? Weight,
        DonorHighRiskValue? HivId,
        DonorHighRiskValue? AidsId,
        DonorHighRiskValue? HepBId,
        DonorHighRiskValue? HepCId,
        DonorHighRiskValue? Ivdaid,
        int? OrganizationId,
        int? SourceCodeID) =>
        FromExpression(() => EReferralCalculateCriteria(
            Age,
            AgeUnit,
            Gender,
            Weight,
            HivId,
            AidsId,
            HepBId,
            HepCId,
            Ivdaid,
            OrganizationId,
            SourceCodeID));

    internal IQueryable<ReferralCriteria> EReferralCalculateCriteria_Organ(
        int? Age,
        AgeUnit? AgeUnit,
        PersonGender? Gender,
        int? Weight,
        DonorHighRiskValue? HivId,
        DonorHighRiskValue? AidsId,
        DonorHighRiskValue? HepBId,
        DonorHighRiskValue? HepCId,
        DonorHighRiskValue? Ivdaid,
        HeartbeatType? HeartbeatId,
        VentilatorType? Vented,
        int? OrganizationId,
        int? SourceCodeID) =>
        FromExpression(() => EReferralCalculateCriteria_Organ(
            Age,
            AgeUnit,
            Gender,
            Weight,
            HivId,
            AidsId,
            HepBId,
            HepCId,
            Ivdaid,
            HeartbeatId,
            Vented,
            OrganizationId,
            SourceCodeID));
}
