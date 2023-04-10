using AutoMapper;
using Statline.StatTrac.Domain.LogEvents;

namespace Statline.StatTrac.App.LowLevel.LogEvents;

public class LogEventsApplication
{
    private readonly ILogEventRepository logEventRepository;
    private readonly IMapper mapper;

    public LogEventsApplication(
        ILogEventRepository logEventRepository,
        IMapper mapper)
    {
        this.logEventRepository = Check.NotNull(logEventRepository, nameof(logEventRepository));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    public async Task<LogEventInfo?> FindLogEventByIdAsync(int logEventId)
    {
        return await logEventRepository.FindLogEventAsync(logEventId,
            logEvent => new LogEventInfo
            {
                Id = logEvent.LogEventId,
                Type = logEvent.LogEventType!.LogEventTypeName,
                FromToPersonName = logEvent.LogEventName,
                CallId = logEvent.CallId,
                DateTime = logEvent.LogEventDateTime,
                Description = logEvent.LogEventDesc,
                Number = logEvent.LogEventNumber
            });
    }

    public async Task<int> AddLogEventAsync(NewLogEventInfo newLogEvent)
    {
        Check.NotNull(newLogEvent, nameof(newLogEvent));

        var logEvent = mapper.Map<LogEvent>(newLogEvent);

        ApplyNewLogEventDefaultValues(logEvent);

        await logEventRepository.AddLogEventAsync(logEvent);

        return logEvent.LogEventId;
    }

    private static void ApplyNewLogEventDefaultValues(LogEvent logEvent)
    {
        // Some of properties of log event are expected to have
        // default non-null values when values are not provided.
        // So unless client explicitly assigns such property with null
        // it will have default value.
        const int DefaultValueMinusOneForNullInt = -1;
        const int DefaultValueZeroForNullInt = 0;

        logEvent.LogEventCallbackPending = logEvent.LogEventCallbackPending ?? DefaultValueZeroForNullInt;
    }
}
