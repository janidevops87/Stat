using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Calls.Factory;

public class CallInfo
{
    public CallTypeId CallTypeId { get; }
    public DateTimeOffset CallReceivedOn { get; }
    public PersonName? CoordinatorName { get; }
    public string CallerSourceCode { get; }

    public CallInfo(
        CallTypeId callTypeId,
        DateTimeOffset callReceivedOn,
        PersonName? coordinatorName,
        string callerSourceCode)
    {
        CallTypeId = callTypeId;
        CallReceivedOn = callReceivedOn;
        CoordinatorName = coordinatorName;
        CallerSourceCode = Check.NotEmpty(callerSourceCode);
    }
}
