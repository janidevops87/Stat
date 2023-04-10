namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class ClientPartInfo<T> where T : class
    {
        public T PartInfo { get; internal set; }
        public int Id { get; internal set; }
        public string ClientId { get; internal set; }
    }
}
