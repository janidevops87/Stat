namespace Statline.StatTrac.BusinessVeracity.Common.Domain;

public record CallCalculationsServiceOptions
{
    public CallCalculationsServiceOptions(
        CallTimeMarginOptions newReferralCallTimeMargin,
        CallTimeMarginOptions referralUpdateCallTimeMargin,
        TimeSpan newReferralDefaultCallDuration)
    {
        NewReferralCallTimeMargin = Check.NotNull(newReferralCallTimeMargin, nameof(newReferralCallTimeMargin));
        ReferralUpdateCallTimeMargin = Check.NotNull(referralUpdateCallTimeMargin, nameof(referralUpdateCallTimeMargin));
        NewReferralDefaultCallDuration = newReferralDefaultCallDuration;
    }

    public CallTimeMarginOptions NewReferralCallTimeMargin { get; }
    public CallTimeMarginOptions ReferralUpdateCallTimeMargin { get; }
    public TimeSpan NewReferralDefaultCallDuration { get; }
}
