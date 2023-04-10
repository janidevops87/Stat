using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.SqlServer
{
    public static class ServiceCollectionExtensions
    {
        public static void AddEfSqlServerTempReferralRepository(
            this IServiceCollection services,
            IConfiguration config,
            string dbSettingsPath)
        {
            services.Configure<SqlServerReferralDbContext>(config);

            services.AddDbContext<SqlServerReferralDbContext>(
                (o) => o.ConfigureSqlServerDbContext(config, dbSettingsPath));

            services.TryAddScoped<IReferralUploadRepository, ReferralUploadRepository<SqlServerReferralDbContext>>();
        }
    }
}
