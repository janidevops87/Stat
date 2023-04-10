using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class UserSummaryInfo
    {
        public UserId Id { get; internal set; }
        public TenantId TenantId { get; internal set; }
        public string UserName { get; internal set; }
        public bool IsActive { get; internal set; }
        public bool IsConfirmed { get; internal set; }
    }
}
