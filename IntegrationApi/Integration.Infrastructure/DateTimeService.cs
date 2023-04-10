using Statline.Common.Services;

namespace Statline.StatTrac.Integration.Infrastructure;

public class DateTimeService : IDateTimeService
{
    public DateTimeOffset GetCurrent()
    {
        return DateTimeOffset.Now;
    }
}
