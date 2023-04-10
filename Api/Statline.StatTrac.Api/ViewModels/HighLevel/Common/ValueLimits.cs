namespace Statline.StatTrac.Api.ViewModels.HighLevel.Common;

internal static class ValueLimits
{
    // These are storage enforced limits.
    // Time is actually omitted, but that is not that important,
    // since we don't really expect values near these, that's just
    // to guard against programming errors and default values in
    // particular.
    public const string MinDateTimeFormatted = "1753-01-01";
    public const string MaxDateTimeFormatted = "9999-12-31";
    public const string MinSmallDateTimeFormatted = "1900-01-01";
    public const string MaxSmallDateTimeFormatted = "2079-06-06";
}
