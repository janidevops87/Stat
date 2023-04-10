using Statline.Common.Services;
using System;

namespace Statline.StatTracUploader.Infrastructure.Services
{
    public class DateTimeService : IDateTimeService
    {
        public DateTimeOffset GetCurrent()
        {
            return DateTimeOffset.Now;
        }
    }
}
