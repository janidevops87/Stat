namespace Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto
{
    public class RolePartInfo<T> where T : class
    {
        public T PartInfo { get; internal set; }
        public string Id { get; internal set; }
        public string Name { get; internal set; }
    }
}
