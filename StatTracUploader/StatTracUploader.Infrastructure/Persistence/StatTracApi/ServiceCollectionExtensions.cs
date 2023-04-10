using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Main.Calls;
using Statline.StatTracUploader.Domain.Main.Enums;
using Statline.StatTracUploader.Domain.Main.LogEvents;
using Statline.StatTracUploader.Domain.Main.Organizations;
using Statline.StatTracUploader.Domain.Main.Persons;
using Statline.StatTracUploader.Domain.Main.Referrals;
using Statline.StatTracUploader.Domain.Main.SourceCodes;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Calls;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Enums;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.LogEvents;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Organizations;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Persons;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Referrals;
using Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.SourceCodes;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi
{
    public static class ServiceCollectionExtensions
    {
        public static void AddStatTracApiMainRepositories(
            this IServiceCollection services)
        {
            Check.NotNull(services, nameof(services));
            services.TryAddScoped<IReferralRepository, StatTracApiReferralRepository>();
            services.TryAddScoped<ILogEventRepository, StatTracApiLogEventRepository>();
            services.TryAddScoped<ICallRepository, StatTracApiCallRepository>();
            services.TryAddScoped<IOrganizationRepository, StatTracApiOrganizationRepository>();
            services.TryAddScoped<IPersonRepository, StatTracApiPersonRepository>();
            services.TryAddScoped<IEnumRepository, StatTracApiEnumRepository>();
            services.TryAddScoped<ISourceCodeRepository, StatTracApiSourceCodeRepository>();
        }
    }
}
