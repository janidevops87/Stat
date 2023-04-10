using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Statline.Common.Utilities;

namespace Statline.Statrac.IdentityServerIntegration.App
{
    public class IdentityServerIntegrationApplication
    {
        private readonly IConfigurationRepository configurationRepository;
        private readonly ILogger logger;

        public IdentityServerIntegrationApplication(
            IConfigurationRepository configurationRepository,
            ILogger<IdentityServerIntegrationApplication> logger)
        {
            Check.NotNull(configurationRepository, nameof(configurationRepository));
            Check.NotNull(logger, nameof(logger));
            this.configurationRepository = configurationRepository;
            this.logger = logger;
        }

        public async Task RegisterConfiguration(int webReportGroupId)
        {
            logger.LogRegisteringConfiguration(webReportGroupId);

            var configId =
                await configurationRepository.AddConfiguration(webReportGroupId);

            if (configId == null)
            {
                logger.LogFailedToRegisterConfiguration(webReportGroupId);
            }
            else
            {
                logger.LogConfigurationRegistered(webReportGroupId, configId);
            }
        }
       
        // TODO: Handle user activation/deactivation?
        // TODO: Handle claim/user/tenant/client removal?
    }
}
