using System.Web.Configuration;
using System.Web.Hosting;

namespace Registry.API.Dla
{
    public class DlaSettings
    {
        internal static string DlaAppId => WebConfigurationManager.AppSettings["Dla.AppId"];
        internal static string DlaCertificateFile => HostingEnvironment.MapPath(WebConfigurationManager.AppSettings["Dla.CertificateFile"]);
        internal static string DlaCertificatePassword => WebConfigurationManager.AppSettings["Dla.CertificatePassword"];
        internal static string DlaSearchUrl => WebConfigurationManager.AppSettings["Dla.SearchUrl"];
        internal static string DlaGetUrl => WebConfigurationManager.AppSettings["Dla.GetUrl"];
        internal static string DlaToken => WebConfigurationManager.AppSettings["Dla.Token"];
        internal static string DlaUrl => WebConfigurationManager.AppSettings["Dla.Url"];
    }
}