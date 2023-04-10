namespace Registry.Common.DTO
{
    public class UserAuthenticationTicket
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Login { get; set; }
        public int RegistryOwnerId { get; set; }
        public string RegistryOwnerRouteName { get; set; }
    }
}
