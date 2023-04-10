namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto
{
    public class IdentityResourceSummaryInfo
    {
        public string DisplayName { get; }
        public int Id { get; }
        public string Name { get; }

        public IdentityResourceSummaryInfo(
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