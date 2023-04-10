namespace Statline.IdentityServer.Features.IdentityServerOperation.Consent
{
    public class ConsentOptions
    {
        public static bool EnableOfflineAccess = true;
        public static string OfflineAccessDisplayName = "Offline nAccess";
        public static string OfflineAccessDescription = "Access to your applications and resources, even when you are offline";

        public static readonly string MuchChooseOneErrorMessage = "You must pick at least one permission";
        public static readonly string InvalidSelectionErrorMessage = "Invalid selection";
    }
}
