namespace Statline.StatTrac.Domain.Referrals.Factory;

public class CallInfo
{
    public CallerInfo CallerInformation { get; }

    public CallInfo(CallerInfo callerInformation)
    {
        CallerInformation = Check.NotNull(callerInformation);
    }
}
