using System.Data.SqlClient;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Persistence.SqlServer;
using Statline.Common.Repository;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Domain.Repository
{
    public abstract class RepositoryBase<TDbContext>
        where TDbContext : DbContext
    {
        protected TDbContext DbContext { get; }

        protected RepositoryBase(TDbContext dbContext)
        {
            Check.NotNull(dbContext, nameof(dbContext));
            DbContext = dbContext;
        }

        public async Task SaveChangesAsync()
        {
            try
            {
                await DbContext.SaveChangesAsync().ConfigureAwait(false);
            }
            catch (DbUpdateConcurrencyException ex)
            {
                throw new ConcurrencyViolationException(
                    "The entity has been changed since last read. " +
                    "Re-read the entity and try again.", ex);
            }
            catch (DbUpdateException ex)
            // TODO: Below goes SQL-specific code. It'd be nice
            // make this class provider-independent and put this exception
            // translation behind some abstraction.
            when (ex.InnerException is SqlException sqlEx)
            {
                switch ((SqlErrors)sqlEx.Number)
                {
                    case SqlErrors.UniqueConstraintViolation:
                        throw new EntityAlreadyExistsException(
                            "An entity with the same unique-constrained values already exists.", ex);
                    case SqlErrors.DuplicateKey:
                        throw new EntityAlreadyExistsException(
                            "An entity with the same primary key already exists.", ex);
                    default:
                        throw;
                }
            }
        }
    }

}
