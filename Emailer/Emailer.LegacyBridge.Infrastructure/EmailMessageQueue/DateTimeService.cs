using Statline.Common.Services;
using System;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue
{
    internal class DateTimeService : IDateTimeService
    {
        public DateTimeOffset GetCurrent()
        {
            return DateTimeOffset.Now;
        }
    }
}
