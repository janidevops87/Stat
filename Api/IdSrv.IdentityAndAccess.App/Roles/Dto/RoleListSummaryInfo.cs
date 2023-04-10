using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto
{
    public class RoleListSummaryInfo
    {
        public RoleId Id { get; internal set; }
        public string Name { get; internal set; }
    }
}