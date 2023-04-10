namespace Statline.StatTrac.Domain.Enums;

public interface IEnumRepositoryFactory
{
    IEnumRepository<TEnumEntity> Create<TEnumEntity>() where TEnumEntity : class;
}
