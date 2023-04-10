namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class UserPartInfo<T> where T : class
    {
        public T PartInfo { get; internal set; }
        public string Id { get; internal set; }
        public string UserName { get; internal set; }
    }
}
