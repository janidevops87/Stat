using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.Enums;
using System;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Enums;

public class EnumRepositoryFactory : IEnumRepositoryFactory
{
    private readonly IServiceProvider serviceProvider;

    public EnumRepositoryFactory(IServiceProvider serviceProvider)
    {
        // It's OK to use service provider here, as we're at
        // infrastructure level.
        this.serviceProvider = Check.NotNull(serviceProvider);
    }

    public IEnumRepository<TEnumEntity> Create<TEnumEntity>() where TEnumEntity : class
    {
        return serviceProvider.GetRequiredService<IEnumRepository<TEnumEntity>>();
    }
}
