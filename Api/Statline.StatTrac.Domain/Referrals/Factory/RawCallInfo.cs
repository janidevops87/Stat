namespace Statline.StatTrac.Domain.Referrals.Factory;

public class RawCallInfo
{
    public RawCallerInfo CallerInformation { get; }

    public RawCallInfo(RawCallerInfo callerInformation)
    {
        CallerInformation = Check.NotNull(callerInformation);
    }
}
