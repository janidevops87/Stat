using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Statline.Ereferral.Web.Entities;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.Ereferral.Web.Contexts
{
    public interface ITransactionContext
    {
        DbSet<LogEntity> Log { get; set; }
        DbSet<AppSettingEntity> AppSetting { get; set; }

        DbSet<TEntity> Set<TEntity>() where TEntity : class;

        Task<int> SaveChangesAsync(CancellationToken cancellationToken = default(CancellationToken));

        EntityEntry<TEntity> Entry<TEntity>(TEntity entity) where TEntity : class;
    }
}