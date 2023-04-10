namespace Statline.StatTrac.Api.DemoClient.Http
{
    public class ClientCredentialsAuthenticationOptions
    {
        public string TokenEndpointAddress { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string Scope { get; set; }
    }
}
