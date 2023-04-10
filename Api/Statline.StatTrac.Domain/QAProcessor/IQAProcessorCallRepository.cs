namespace Statline.StatTrac.Domain.QAProcessor;

public interface IQAProcessorCallRepository
{
    /// <summary>
    /// Calculates call timings (start/end).
    /// </summary>
    /// <param name="callId">The call id.</param>
    /// <param name="defaultCallDuration">
    /// In some cases there is no data about 
    /// call end time. <paramref name="defaultCallDuration"/>
    /// is then added to call start time to have at least 
    /// some result.
    /// </param>
    /// <returns>
    /// <see cref="CallTimings"/> instance, or <c>null</c> if there is no
    /// call with the given <paramref name="callId"/>.
    /// </returns>
    /// <dev>
    /// The reason <paramref name="defaultCallDuration"/> is passed to repository
    /// instead of calculating default timings in application code is to have 
    /// consistent implementation in the underlying database. In other words, 
    /// for the stored procedure to always return a pair of values.
    /// </dev>
    Task<CallTimings?> GetCallTimingsAsync(int callId, TimeSpan defaultCallDuration);
}
