namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto
{
    public class IdentityResourcePartInfo<T> where T : class
    {
        public T PartInfo { get; internal set; }
        public int IdentityResourceId { get; internal set; }
        public string IdentityResourceName { get; internal set; }
    }
}
