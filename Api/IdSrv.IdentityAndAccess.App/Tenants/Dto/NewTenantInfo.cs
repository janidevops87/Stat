using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto
{
    public class NewTenantInfo
    {
        public string OrganizationName { get; }

        public NewTenantInfo(
            string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));
            OrganizationName = organizationName;
        }
    }
}
