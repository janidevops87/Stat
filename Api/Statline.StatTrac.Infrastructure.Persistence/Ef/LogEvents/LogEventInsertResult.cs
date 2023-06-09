﻿namespace Statline.StatTrac.Infrastructure.Persistence.Ef.LogEvents;

/// <summary>
/// Holds values generated by the DB.
/// </summary>
internal sealed class LogEventInsertResult
{
    public int LogEventId { get; private set; }
    public int? LogEventNumber { get; private set; }
}
