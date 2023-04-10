namespace Statline.StatTrac.Api.ViewModels.QAProcessor;

public class CallTimingsViewModel
{
    public CallTimingsViewModel(DateTimeOffset callStart, DateTimeOffset callEnd)
    {
        CallStart = callStart;
        CallEnd = callEnd;
    }

    public DateTimeOffset CallStart { get; }
    public DateTimeOffset CallEnd { get; }
}
