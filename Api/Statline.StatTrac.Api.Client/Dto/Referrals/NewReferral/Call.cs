using Statline.StatTrac.Api.Client.Dto.Common;

namespace Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

public class Call
{
    public Caller CallerInformation { get; }
    public DateTimeOffset CallReceivedOn { get; }
    public PersonName? CoordinatorName { get; }

    public Call(
        Caller callerInformation,
        DateTimeOffset callReceivedOn,
        PersonName? coordinatorName)
    {
        CallerInformation = Check.NotNull(callerInformation);
        CallReceivedOn = callReceivedOn;
        CoordinatorName = coordinatorName;
    }
}
