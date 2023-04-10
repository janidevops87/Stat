using System;

namespace Statline.Common.Services
{
    /// <summary>
    /// Provides date/time services.
    /// </summary>
    public interface IDateTimeService
    {
        /// <summary>
        /// Gets the current date/time.
        /// </summary>
        /// <returns>
        /// A <see cref="DateTimeOffset"/> instance 
        /// describing current date/time.
        /// </returns>
        DateTimeOffset GetCurrent();
    }
}
