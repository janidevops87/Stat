namespace Statline.StatTrac.BusinessVeracity.Common.Application;

public class ReferralProcessingException : Exception
{
    public int ReferralId { get; }

    public ReferralProcessingException(int referralId)
    {
        ReferralId = referralId;
    }
    public ReferralProcessingException(string message, int referralId) : base(message)
    {
        ReferralId = referralId;
    }
    public ReferralProcessingException(string message, Exception inner, int referralId) : base(message, inner)
    {
        ReferralId = referralId;
    }
}
