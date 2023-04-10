namespace Statline.StatTrac.Domain.QAProcessor;

public interface IQAProcessorReferralRepository
{
    Task<IEnumerable<HighRiskCallReferral>> GetHighRiskCallReferralsAsync(
        DateTimeOffset startDate,
        DateTimeOffset endDate);
}
