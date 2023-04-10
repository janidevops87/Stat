using System;

namespace Statline.Extensions.Logging.Email
{
    /// <summary>
    /// The email logger settings DTO.
    /// </summary>
    internal class EmailLoggerSettings
    {
        public TimeSpan BatchSendPeriod { get; set; }
    }
}
