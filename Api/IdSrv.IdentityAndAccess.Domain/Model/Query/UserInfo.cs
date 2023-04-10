namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query
{
    public class UserInfo
    {
        public string Id { get; set; }
        public bool IsActive { get; set; }
        public int? TenantId { get; set; }
        public bool IsConfirmed { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
    }
}
