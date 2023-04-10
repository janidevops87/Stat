namespace Statline.IdentityServer
{
    public static class AuthorizationPolicies
    {
        public const string AuthenticatedUserPolicy = "AuthenticatedUserPolicy";
        public const string WholeApplicationAdministrationPolicy = "WholeApplicationAdministrationPolicy";
        public const string ConfigurationEditingPolicy = "ConfigurationEditingPolicy";
        public const string ConfigurationViewingPolicy = "ConfigurationViewingPolicy";
    }
}
