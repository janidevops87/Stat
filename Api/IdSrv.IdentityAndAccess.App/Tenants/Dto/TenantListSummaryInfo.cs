using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto
{
    public class TenantListSummaryInfo
    {
        public TenantId Id { get; internal set; }
        public string OrganizationName { get; internal set; }
    }
}