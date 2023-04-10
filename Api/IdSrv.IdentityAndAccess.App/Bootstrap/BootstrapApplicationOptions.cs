using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Bootstrap
{
    public class BootstrapApplicationOptions
    {
        public string AdministrativeTenantOrganizationName { get; set; }
        public string DefaultAdminUserName { get; set; }
        public string DefaultAdminPassword { get; set; }
        public string DefaultAdminEmail { get; set; }

        public void Validate(string referencingPath)
        {
            Check.NotEmpty(referencingPath, nameof(referencingPath));

            Check.NotEmpty(AdministrativeTenantOrganizationName, 
                referencingPath + "." + nameof(AdministrativeTenantOrganizationName));

            Check.NotEmpty(DefaultAdminUserName, 
                referencingPath + "." + nameof(DefaultAdminUserName));

            Check.NotEmpty(DefaultAdminPassword,
                referencingPath + "." + nameof(DefaultAdminPassword));

            Check.NotEmpty(DefaultAdminEmail,
                referencingPath + "." + nameof(DefaultAdminEmail));
        }
    }
}
