using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Services;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.Enums;
using Statline.StatTrac.Domain.EReferrals;
using Statline.StatTrac.Domain.LogEvents;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.QAProcessor;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.Referrals.Factory.Criteria;
using Statline.StatTrac.Domain.RegistryStatuses;
using Statline.StatTrac.Domain.SourceCodes;
using Statline.StatTrac.Domain.SubLocations;
using Statline.StatTrac.Domain.TimeZones;
using Statline.StatTrac.Infrastructure.Common.Services;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Calls;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Enums;
using Statline.StatTrac.Infrastructure.Persistence.Ef.EReferrals;
using Statline.StatTrac.Infrastructure.Persistence.Ef.LogEvents;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Organizations;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Persons;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Phones;
using Statline.StatTrac.Infrastructure.Persistence.Ef.QAProcessor;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Referrals;
using Statline.StatTrac.Infrastructure.Persistence.Ef.RegistryStatuses;
using Statline.StatTrac.Infrastructure.Persistence.Ef.SourceCodes;
using Statline.StatTrac.Infrastructure.Persistence.Ef.SubLocations;
using Statline.StatTrac.Infrastructure.Persistence.Ef.TimeZones;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef;

public static class ServiceCollectionExtensions
{
    public static void AddCommonEfRepositorySerives(
        this IServiceCollection services,
        IConfiguration config,
        string transactionalDbSettingsPath,
        string reportingDbSettingsPath)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(config, nameof(config));
        Check.NotEmpty(transactionalDbSettingsPath, nameof(transactionalDbSettingsPath));
        Check.NotEmpty(reportingDbSettingsPath, nameof(reportingDbSettingsPath));

        services.TryAddSingleton<IDateTimeService, DateTimeService>();

        services.AddDbContext<ReferralTransactionalDbContext>(
            options => options.ConfigureSqlServerDbContext(config, transactionalDbSettingsPath));

        services.AddDbContext<ReferralReportingDbContext>(
            options => options.ConfigureSqlServerDbContext(config, reportingDbSettingsPath));
    }

    public static void AddEfReferralRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<IReferralRepository, ReferralRepository>();
    }

    public static void AddEfEReferralRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<IEReferralRepository, EReferralRepository>();
    }

    public static void AddEfPersonRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<IPersonRepository, PersonRepository>();
    }

    public static void AddEfOrganizationRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<IOrganizationRepository, OrganizationRepository>();
    }

    public static void AddEfPhoneRepository(
       this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<IPhoneRepository, PhoneRepository>();
    }

    public static void AddEfSubLocationRepository(
       this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<ISubLocationRepository, SubLocationRepository>();
    }

    public static void AddEfEnumRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped(typeof(IEnumRepository<>), typeof(EnumRepository<>));
        services.TryAddScoped<IEnumRepositoryFactory, EnumRepositoryFactory>();
    }

    public static void AddEfLogEventRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<ILogEventRepository, LogEventRepository>();
    }

    public static void AddEfCallRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<ICallRepository, CallRepository>();
    }

    public static void AddEfRegistryStatusRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<IRegistryStatusRepository, RegistryStatusRepository>();
    }

    public static void AddEfTimeZoneRepository(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<ITimeZoneRepository, TimeZoneRepository>();
    }

    public static void AddEfSourceCodeRepository(
       this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.TryAddScoped<ISourceCodeRepository, SourceCodeRepository>();
    }

    public static void AddEfQAProcessorRepositories(
        this IServiceCollection services)
    {
        Check.NotNull(services, nameof(services));
        services.AddScoped<IQAProcessorCallRepository, QAProcessorCallRepository>();
        services.AddScoped<IQAProcessorReferralRepository, QAProcessorReferralRepository>();
    }
}
