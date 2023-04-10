using Microsoft.Extensions.Options;
using Statline.Common.Services;

namespace Statline.StatTrac.App.Heartbeat;

public class HeartbeatApplication
{
    private readonly ISqlServerHealthChecker sqlServerHealthChecker;
    private readonly IDateTimeService dateTimeService;
    private readonly string onPremSqlServerConnectionString;

    public HeartbeatApplication(
        IOptions<HeartbeatApplicationOptions> options,
        ISqlServerHealthChecker sqlServerHealthChecker,
        IDateTimeService dateTimeService)
    {
        Check.NotNull(options, nameof(options));
        Check.NotNull(sqlServerHealthChecker, nameof(sqlServerHealthChecker));
        Check.NotNull(dateTimeService, nameof(dateTimeService));

        this.sqlServerHealthChecker = sqlServerHealthChecker;
        this.dateTimeService = dateTimeService;

        var optionsValue = options.Value;

        optionsValue.Validate(nameof(options));

        onPremSqlServerConnectionString =
            optionsValue.OnPremSqlServerConnectionString;
    }

    public async Task<ApplicationHealthReport> CheckAppHealthAsync()
    {
        var onPremSqlServerHealthReport =
            await sqlServerHealthChecker.CheckHealthAsync(
                onPremSqlServerConnectionString);

        var timeStamp = dateTimeService.GetCurrent().ToUniversalTime();

        return new ApplicationHealthReport(
            timeStamp,
            onPremSqlServerHealthReport);
    }
}
