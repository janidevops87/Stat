using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef;

namespace Statline.IdentityServer.Common.AdministrativeTenant
{
    internal class WithDesignTimeFallbackAdministrativeTenantIdProvider
        : IAdministrativeTenantIdProvider
    {
        private readonly IAdministrativeTenantIdProvider runTimeTenantIdProvider;
        private readonly IDesignTimeDetector designTimeDetector;

        public WithDesignTimeFallbackAdministrativeTenantIdProvider(
           IAdministrativeTenantIdProvider runTimeTenantIdProvider,
           IDesignTimeDetector designTimeDetector)
        {
            Check.NotNull(runTimeTenantIdProvider, nameof(runTimeTenantIdProvider));
            Check.NotNull(designTimeDetector, nameof(designTimeDetector));

            this.runTimeTenantIdProvider = runTimeTenantIdProvider;
            this.designTimeDetector = designTimeDetector;
        }

        public int GetAdministrativeTenantId()
        {
            if (designTimeDetector.IsDesignTime)
            {
                return default;
            }
            else
            {
                return runTimeTenantIdProvider.GetAdministrativeTenantId();
            }
        }
    }
}
