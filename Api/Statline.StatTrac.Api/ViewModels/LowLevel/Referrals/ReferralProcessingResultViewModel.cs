using Statline.StatTrac.App.ReferralProcessor;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Referrals;

public class ReferralProcessingResultViewModel
{
    public string ProcessingStatus { get; }

    public ReferralProcessingResultViewModel(
        ReferralProcessingStatus processingStatus)
    {
        ProcessingStatus = processingStatus.ToString();
    }
}
