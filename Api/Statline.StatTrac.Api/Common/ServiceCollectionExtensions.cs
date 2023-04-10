using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Services;
using Statline.StatTrac.Api.Infrastructure.Heartbeat;
using Statline.StatTrac.Api.ViewModels.TypeConveters;
using Statline.StatTrac.App.Enums;
using Statline.StatTrac.App.EReferrals;
using Statline.StatTrac.App.Heartbeat;
using Statline.StatTrac.App.LowLevel.Calls;
using Statline.StatTrac.App.LowLevel.LogEvents;
using Statline.StatTrac.App.LowLevel.Organizations;
using Statline.StatTrac.App.LowLevel.Persons;
using Statline.StatTrac.App.LowLevel.Referrals;
using Statline.StatTrac.App.QAProcessor;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.Referrals.Factory.Criteria;
using Statline.StatTrac.Infrastructure.Common.Services;
using Statline.StatTrac.Infrastructure.Persistence.Ef;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Referrals;
//using Statline.StatTrac.Infrastructure.Persistence.DocumentDb;

namespace Statline.StatTrac.Api.Common;

public static class ServiceCollectionExtensions
{
    private const string ReferralsTransactionalEfRepositorySettingsPath = "Referrals:TransactionalEfRepository";
    private const string ReferralsReportingEfRepositorySettingsPath = "Referrals:ReportingEfRepository";
    private const string ReferralsDocumentDbSettingsPath = "Referrals:DocumentDbRepository";

    public static void AddCommonApplicationServices(
        this IServiceCollection services,
        IConfiguration config)
    {
        DateOnlyConverter.Register();
        PhoneNumberTypeConverter.Register();

        services.AddSingleton<IDateTimeService, DateTimeService>();
        services.AddSingleton<IWebReportGroupIdAccessor, HttpContextWebReportGroupIdAccessor>();
        services.AddCommonEfRepositorySerives(
            config,
            transactionalDbSettingsPath: ReferralsTransactionalEfRepositorySettingsPath,
            reportingDbSettingsPath: ReferralsReportingEfRepositorySettingsPath);
    }

    public static void AddReferralsApplication(
        this IServiceCollection services,
        IConfiguration config)
    {
        services.AddEfReferralRepository();
        services.AddScoped<ReferralsApplication>();

        //services.AddDocumentDbUpdatedReferralRepository(
        //    config.GetSection(ReferralsDocumentDbSettingsPath));
        //services.AddScoped<ReferralProcessorApplication>();
    }

    public static void AddReferralsHighLevelApplication(
       this IServiceCollection services,
       IConfiguration config)
    {
        services.AddEfReferralRepository();
        services.AddEfCallRepository();
        services.AddEfRegistryStatusRepository();
        services.AddEfSourceCodeRepository();
        services.AddEfOrganizationRepository();
        services.AddEfPhoneRepository();
        services.AddEfSubLocationRepository();
        services.AddEfPersonRepository();
        services.AddEfEnumRepository();

        services.TryAddTransient<ICriteriaCalculator, CriteriaCalculator>();

        services.AddScoped<App.HighLevel.Referrals.ReferralsHighLevelApplication>();
        services.AddTransient<Domain.Referrals.Factory.ReferralFactory>();
        services.AddTransient<Domain.Calls.Factory.CallFactory>();
    }

    public static void AddLogEventsHighLevelApplication(
        this IServiceCollection services)
    {
        services.AddEfReferralRepository();
        services.AddEfPersonRepository();
        services.AddEfOrganizationRepository();
        services.AddEfLogEventRepository();

        services.AddScoped<App.HighLevel.LogEvents.LogEventsHighLevelApplication>();
        services.AddTransient<Domain.LogEvents.Factory.LogEventFactory>();
    }

    public static void AddPersonsHighLevelApplication(
       this IServiceCollection services)
    {
        services.AddEfPersonRepository();
        services.AddEfOrganizationRepository();

        services.AddScoped<App.HighLevel.Persons.PersonsHighLevelApplication>();
        services.AddTransient<Domain.Persons.Factory.PersonFactory>();
    }

    public static void AddPhonesHighLevelApplication(
      this IServiceCollection services)
    {
        services.AddEfPhoneRepository();
        services.AddEfOrganizationRepository();

        services.AddScoped<App.HighLevel.Phones.PhonesHighLevelApplication>();
        services.AddTransient<Domain.Phones.Factory.PhoneFactory>();
    }

    public static void AddEReferralsApplication(
        this IServiceCollection services)
    {
        services.AddEfEReferralRepository();
        services.AddScoped<EReferralsApplication>();
    }

    public static void AddPersonsApplication(
        this IServiceCollection services)
    {
        services.AddEfPersonRepository();
        services.AddScoped<PersonsApplication>();
    }

    public static void AddOrganizationsApplication(
        this IServiceCollection services)
    {
        services.AddEfOrganizationRepository();
        services.AddEfPhoneRepository();
        services.AddEfSubLocationRepository();
        services.AddScoped<OrganizationsApplication>();
    }

    public static void AddLogEventsApplication(
        this IServiceCollection services)
    {
        services.AddEfLogEventRepository();
        services.AddScoped<LogEventsApplication>();
    }

    public static void AddCallsApplication(
        this IServiceCollection services)
    {
        services.AddEfCallRepository();
        services.AddEfRegistryStatusRepository();
        services.AddScoped<CallsApplication>();
    }

    public static void AddTimeZonesApplication(
        this IServiceCollection services)
    {
        services.AddEfTimeZoneRepository();
    }

    public static void AddEnumsApplication(
        this IServiceCollection services)
    {
        services.AddEfEnumRepository();
        services.AddScoped<EnumsApplication>();
    }

    public static void AddHeartbeatApplication(
        this IServiceCollection services,
        IConfiguration config)
    {
        var dbSettings = config.GetSqlDatabaseSettings(ReferralsTransactionalEfRepositorySettingsPath);

        services.Configure<HeartbeatApplicationOptions>(
            opt => opt.OnPremSqlServerConnectionString = dbSettings.ConnectionString);

        services.AddSingleton<ISqlServerHealthChecker, SqlServerHealthChecker>();
        services.AddScoped<HeartbeatApplication>();
    }

    public static void AddQAProcessorApplication(
        this IServiceCollection services, IConfiguration configuration)
    {
        services.AddOptions<QAProcessorApplicationOptions>()
            .ValidateDataAnnotations()
            .Bind(configuration.GetSection("ApplicationSettings:QAProcessor"));
        services.AddScoped<QAProcessorApplication>();
        services.AddEfQAProcessorRepositories();
    }
}
