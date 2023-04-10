namespace Statline.StatTrac.Domain.Calls.Factory;

public class RawCallInfo
{
    public CallTypeId CallTypeId { get; init; }
    public DateTimeOffset CallReceivedOn { get; init; }
    public int? CoordinatorEmployeeId { get; init; }
    public int CallerSourceCodeId { get; init; }
}
