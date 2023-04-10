namespace Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto
{
    public class TenantPartInfo<T> where T : class
    {
        public T PartInfo { get; internal set; }
        public int Id { get; internal set; }
        public string OrganizationName { get; internal set; }
    }
}
