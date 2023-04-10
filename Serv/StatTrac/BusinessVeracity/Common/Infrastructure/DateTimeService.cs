using Statline.Common.Services;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure;

public class DateTimeService : IDateTimeService
{
    public DateTimeOffset GetCurrent()
    {
        return DateTimeOffset.Now;
    }
}
