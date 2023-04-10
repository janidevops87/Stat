namespace Statline.StatTrac.BusinessVeracity.Common.Domain;

public record CallTimings
{
    public DateTimeOffset CallStart { get; }
    public DateTimeOffset CallEnd { get; }
    public TimeSpan CallDuration => CallEnd - CallStart;

    public CallTimings(DateTimeOffset callStart, DateTimeOffset callEnd)
    {
        if (callEnd < callStart)
        {
            throw new ArgumentException(
                $"Call end time must not be less than call start time", nameof(callEnd));
        }

        CallStart = callStart;
        CallEnd = callEnd;
    }

    public void Deconstruct(out DateTimeOffset callStart, out DateTimeOffset callEnd)
    {
        callStart = CallStart;
        callEnd = CallEnd;
    }
}
