using System;
using Statline.Common.Services;

namespace Statline.StatTrac.Api.Func.Infrastructure
{
    public class DateTimeService : IDateTimeService
    {
        public DateTimeOffset GetCurrent()
        {
            return DateTimeOffset.Now;
        }
    }
}
