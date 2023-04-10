using System.Globalization;

namespace Statline.StatTrac.Domain.Common;

public class PersonAgeCalculationService
{
    private readonly Calendar calendar;

    public PersonAgeCalculationService(Calendar calendar)
    {
        this.calendar = Check.NotNull(calendar, nameof(calendar));
    }

    public PersonAge CaculatePersonAge(
        DateOnly dateOfBirth,
        DateOnly now)
    {
        // Convert to DateTime because DateOnly doesn't
        // support arithmetic operations for some reason.
        return CaculatePersonAge(
            dateOfBirth.ToDateTime(TimeOnly.MinValue),
            now.ToDateTime(TimeOnly.MinValue));
    }

    ///<dev>
    /// NOTE: This method was ported from corresponding functionality in StatTrac
    /// written in VB.NET with using VB-specific routines. While those routines are 
    /// available in C# and .Net Core, I decided to make the code looking more familiar
    /// and also use explicit calendar instance instead current thread's one 
    /// (VB routines do not allow passing culture explicitly).
    /// For reference the VB.NET routines implementation can be found here:
    /// https://github.com/dotnet/runtime/blob/release/5.0/src/libraries/Microsoft.VisualBasic.Core/src/Microsoft/VisualBasic/DateAndTime.vb
    ///</dev>
    public PersonAge CaculatePersonAge(
        DateTime dateOfBirth,
        DateTime now)
    {
        CheckDateTimeKind(dateOfBirth, nameof(dateOfBirth));
        CheckDateTimeKind(now, nameof(now));

        var diff = now - dateOfBirth;

        int diffInDays = (int)diff.TotalDays;

        return diffInDays switch
        {
            0 => new PersonAge(1, AgeUnit.Days),
            > 0 and <= 31 => new PersonAge(diffInDays, AgeUnit.Days),
            // 730 days means 24 months
            > 31 and < 730 => new PersonAge(AgeInMonths(dateOfBirth, now), AgeUnit.Months),
            > 730 => new PersonAge(AgeInYears(dateOfBirth, now), AgeUnit.Years),
            // This will not handle rounding of negative fraction
            // of day (which will result in 0), but do we care?
            _ => throw new ArgumentException(
                "Date of birth is later than date of age calculation.",
                nameof(dateOfBirth))
        };
    }

    ///<dev>
    /// NOTE: This method was ported from corresponding functionality in StatTrac
    /// written in VB.NET with using VB-specific routines. While those routines are 
    /// available in C# and .Net Core, I decided to make the code looking more familiar
    /// and also use explicit calendar instance instead current thread's one 
    /// (VB routines do not allow passing culture explicitly).
    /// For reference the VB.NET routines implementation can be found here:
    /// https://github.com/dotnet/runtime/blob/release/5.0/src/libraries/Microsoft.VisualBasic.Core/src/Microsoft/VisualBasic/DateAndTime.vb
    ///</dev>
    private int AgeInMonths(DateTime startDate, DateTime endDate)
    {
        // This is simplification as in some calendars some years may 
        // have different number of months.
        const int MonthsPerYear = 12;

        double ageInMonths =
            (calendar.GetYear(endDate) - calendar.GetYear(startDate)) * MonthsPerYear +
            calendar.GetMonth(endDate) - calendar.GetMonth(startDate);

        if (calendar.GetDayOfMonth(startDate) > calendar.GetDayOfMonth(endDate))
        {
            ageInMonths--;
        }

        if (ageInMonths < 0)
        {
            ageInMonths++;
        }

        return (int)Math.Round(ageInMonths);
    }

    ///<dev>
    /// NOTE: This method was ported from corresponding functionality in StatTrac
    /// written in VB.NET with using VB-specific routines. While those routines are 
    /// available in C# and .Net Core, I decided to make the code looking more familiar
    /// and also use explicit calendar instance instead current thread's one 
    /// (VB routines do not allow passing culture explicitly).
    /// For reference the VB.NET routines implementation can be found here:
    /// https://github.com/dotnet/runtime/blob/release/5.0/src/libraries/Microsoft.VisualBasic.Core/src/Microsoft/VisualBasic/DateAndTime.vb
    ///</dev>
    private int AgeInYears(DateTime startDate, DateTime endDate)
    {
        var ageInYears = calendar.GetYear(endDate) - calendar.GetYear(startDate);

        int endYear = calendar.GetYear(endDate);
        int startMonth = calendar.GetMonth(startDate);
        int startDay = calendar.GetDayOfMonth(startDate);

        // As in a particular year number of months and days in given month
        // can be different than in the original year (e.g. number of days in February),
        // we can't just specify them in the new instance of DateTime. Instead, we add
        // each of this part so the calendar can decide to wrap to next month or year.
        var startDateWithEndYear =
            calendar.ToDateTime(year: endYear, month: 1, day: 1, 0, 0, 0, 0);

        // Subtracting 1 because we already added 1 month and date above.
        calendar.AddMonths(startDateWithEndYear, startMonth - 1);
        calendar.AddDays(startDateWithEndYear, startDay - 1);

        if (endDate.Date < startDateWithEndYear)
        {
            ageInYears--;
        }

        return ageInYears;
    }

    private static void CheckDateTimeKind(DateTime dateTime, string paramName)
    {
        if (dateTime.Kind is DateTimeKind.Local)
        {
            throw new ArgumentException("DateTime.Kind must not be Local", paramName);
        }
    }
}
