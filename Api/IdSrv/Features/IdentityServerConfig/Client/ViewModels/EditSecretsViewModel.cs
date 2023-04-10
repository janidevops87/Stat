using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditSecretsViewModel : ClientViewModel
    {
        [Display(Name = "Secrets")]
        public SecretViewModel[] Secrets { get; set; }
    }
}
