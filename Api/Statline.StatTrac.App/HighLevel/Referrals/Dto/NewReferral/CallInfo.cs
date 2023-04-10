using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;

public class CallInfo
{
    public DateTimeOffset CallReceivedOn { get; }
    public CallerInfo CallerInformation { get; }
    public PersonName? CoordinatorName { get; }

    public CallInfo(
        CallerInfo callerInformation,
        DateTimeOffset callReceivedOn,
        PersonName? coordinatorName)
    {
        CallerInformation = Check.NotNull(callerInformation);
        CallReceivedOn = callReceivedOn;
        CoordinatorName = coordinatorName;
    }
}
