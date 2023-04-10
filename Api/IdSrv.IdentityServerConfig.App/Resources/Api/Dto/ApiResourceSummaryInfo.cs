namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto
{
    public class ApiResourceSummaryInfo
    {
        public string DisplayName { get; }
        public int Id { get; }
        public string Name { get; }

        public ApiResourceSummaryInfo(
            int id,
            string name,
            string displayName)
        {
            Id = id;
            Name = name;
            DisplayName = displayName;
        }

    }
}