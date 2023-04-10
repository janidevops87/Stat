namespace Statline.StatTrac.Api.Func.Model
{
    public class ReferralQueueDto
    {
        public int ReferralId { get; set; }
        public int WebReportGroupId { get; set; }
        public int RetryCount { get; set; }
        public bool IsDelayedRetry { get; set; }
    }
}
