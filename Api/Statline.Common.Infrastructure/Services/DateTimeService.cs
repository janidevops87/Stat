using Statline.Common.Services;
using System;

namespace Statline.Common.Infrastructure.Services
{
    public class DateTimeService : IDateTimeService
    {
        public DateTimeOffset GetCurrent()
        {
            return DateTimeOffset.Now;
        }
    }
}
