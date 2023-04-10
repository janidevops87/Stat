using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.UI.App.Configuration
{
    public class AppSettings
    {
        public string ExternalGetClaimsFromUserInfoEndpoint { get; set; }
        public string ExternalSaveTokens { get; set; }
        public string ExternalRequireHttpsMetadata { get; set; }
        public string StatlineStatTracApiIdentityServerUri { get; set; }
        public string StatlineStatTracApiIdentityServerApiName { get; set; }
        public string StatlineStatTracApiUri { get; set; }
        public string ExternalClientId { get; set; }
        public string ExternalClientSecret { get; set; }    
    }
}
