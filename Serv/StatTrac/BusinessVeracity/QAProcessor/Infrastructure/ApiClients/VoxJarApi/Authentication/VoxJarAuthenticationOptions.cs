using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Authentication;

public class VoxJarAuthenticationOptions<TClient>
{
    [Required]
    public string RefreshToken { get; set; } = default!;
    [Required]
    public Uri TokenEndpointAddress { get; set; } = default!;

}
