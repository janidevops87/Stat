using Statline.Common.Utilities;
using System;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTracUploader.WebUI.Common
{
    public class ApplicationUIOptions
    {
        private readonly Lazy<TimeZoneInfo> timeZone;

        [Required]
        public string TimeZoneId { get; set; } = "Mountain Standard Time";

        public ApplicationUIOptions()
        {
            timeZone = new(() => LoadTimeZoneInfo(TimeZoneId));
        }

        public TimeZoneInfo GetTimeZone() => timeZone.Value;

        private static TimeZoneInfo LoadTimeZoneInfo(string timeZoneId)
        {
            Check.NotEmpty(timeZoneId, nameof(timeZoneId));

            TimeZoneInfo timeZone;

            try
            {
                timeZone = TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
            }
            catch (Exception ex) when (
                ex is TimeZoneNotFoundException ||
                ex is InvalidTimeZoneException)
            {
                throw new ArgumentException(
                    $"Failed to load TimeZoneInfo for time zone ID " +
                    $"'{timeZoneId}': {ex.Message}",
                    nameof(timeZoneId),
                    ex);
            }

            return timeZone;
        }
    }
}
