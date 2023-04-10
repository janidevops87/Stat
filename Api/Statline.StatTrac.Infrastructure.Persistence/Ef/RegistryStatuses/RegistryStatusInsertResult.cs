using Statline.StatTrac.Domain.RegistryStatuses;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.RegistryStatuses;

internal sealed class RegistryStatusInsertResult
{
    public int Id { get; private set; }
    public RegistryStatusType? RegistryStatus { get; private set; }
    public int? CallId { get; private set; }
}