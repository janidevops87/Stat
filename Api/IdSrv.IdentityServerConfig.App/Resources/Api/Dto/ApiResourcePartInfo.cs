namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto
{
    public class ApiResourcePartInfo<T> where T : class
    {
        public T PartInfo { get; internal set; }
        public int ApiResourceId { get; internal set; }
        public string ApiResourceName { get; internal set; }
    }
}
