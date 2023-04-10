using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.Statrac.IdentityServerIntegration.App;

namespace Statline.Statrac.IdentityServerIntegration.Infrastructure.Persistence.Ef
{
    public class ConfigurationRepository : IConfigurationRepository
    {
        private readonly ConfigurationDbContext manageDbContext;

        public ConfigurationRepository(
           ConfigurationDbContext manageDbContext)
        {
            Check.NotNull(manageDbContext, nameof(manageDbContext));
            this.manageDbContext = manageDbContext;
        }

        public async Task<int?> AddConfiguration(int webReportGroupId)
        {
            var configurations = await manageDbContext.Configurations
                    .FromSqlInterpolated($"EXEC Api.AddConfiguration {webReportGroupId}")
                    .AsNoTracking()
                    .ToListAsync()
                    .ConfigureAwait(true);

            // If WebReportGroupId was invalid, configuration will be null.
            return configurations.SingleOrDefault()?.ConfigurationId;
        }
    }
}
