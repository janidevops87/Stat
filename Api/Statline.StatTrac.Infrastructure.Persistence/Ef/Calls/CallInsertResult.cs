namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Calls;

internal sealed class CallInsertResult
{
    public int CallId { get; private set; }
    public string CallNumber { get; private set; } = default!;
}
