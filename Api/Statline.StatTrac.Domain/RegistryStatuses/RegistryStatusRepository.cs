namespace Statline.StatTrac.Domain.RegistryStatuses;

public interface IRegistryStatusRepository
{
    Task AddRegistryStatusAsync(RegistryStatus registryStatus);
}
