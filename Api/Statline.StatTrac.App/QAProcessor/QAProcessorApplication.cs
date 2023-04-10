using Microsoft.Extensions.Options;
using Statline.StatTrac.Domain.QAProcessor;

namespace Statline.StatTrac.App.QAProcessor;

public class QAProcessorApplication
{
    private readonly IQAProcessorCallRepository callRepository;
    private readonly IQAProcessorReferralRepository referralRepository;
    private readonly QAProcessorApplicationOptions options;

    public QAProcessorApplication(
        IQAProcessorCallRepository callRepository,
        IQAProcessorReferralRepository referralRepository,
        IOptionsSnapshot<QAProcessorApplicationOptions> options)
    {
        this.callRepository = Check.NotNull(callRepository, nameof(callRepository));
        this.referralRepository = Check.NotNull(referralRepository, nameof(referralRepository));
        this.options = Check.NotNull(options, nameof(options)).Value;
    }

    public async Task<CallTimings?> GetCallTimingsAsync(int callId)
    {
        return await callRepository.GetCallTimingsAsync(callId, options.DefaultCallDuration);
    }

    public async Task<IEnumerable<HighRiskCallReferral>> GetHighRiskCallReferralsAsync(
        DateTimeOffset startDate,
        DateTimeOffset endDate)
    {
        return await referralRepository.GetHighRiskCallReferralsAsync(startDate, endDate);
    }
}
