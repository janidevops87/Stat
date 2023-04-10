namespace Statline.StatTrac.App.ReferralProcessor;

public class ReferralProcessingResult
{
    public ReferralProcessingStatus ProcessingStatus { get; }

    public ReferralProcessingResult(
        ReferralProcessingStatus processingStatus)
    {
        ProcessingStatus = processingStatus;
    }
}
