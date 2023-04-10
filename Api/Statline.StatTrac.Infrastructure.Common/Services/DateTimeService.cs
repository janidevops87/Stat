using Statline.Common.Services;

namespace Statline.StatTrac.Infrastructure.Common.Services;

public class DateTimeService : IDateTimeService
{
    public DateTimeOffset GetCurrent()
    {
        return DateTimeOffset.Now;
    }
}
