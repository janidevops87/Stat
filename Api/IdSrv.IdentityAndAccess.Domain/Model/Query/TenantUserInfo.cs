namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query
{
    public sealed class TenantUserInfo : UserInfo
    {
        public string TenantOrganizationName { get; set; }
    }
}
