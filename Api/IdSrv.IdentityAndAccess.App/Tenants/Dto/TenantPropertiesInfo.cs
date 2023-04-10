using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto
{
    public class TenantPropertiesInfo
    {
        public string OrganizationName { get; }

        public TenantPropertiesInfo(
            string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));
            OrganizationName = organizationName;
        }
    }
}