using Statline.IdentityServer.Features.IdentityServerOperation.Consent.ViewModels;

namespace Statline.IdentityServer.Features.IdentityServerOperation.Consent
{
    public class ProcessConsentResult
    {
        public bool IsRedirect => RedirectUri != null;
        public string RedirectUri { get; set; }

        public bool ShowView => ViewModel != null;
        public ConsentViewModel ViewModel { get; set; }

        public bool HasValidationError => ValidationError != null;
        public string ValidationError { get; set; }
    }
}
