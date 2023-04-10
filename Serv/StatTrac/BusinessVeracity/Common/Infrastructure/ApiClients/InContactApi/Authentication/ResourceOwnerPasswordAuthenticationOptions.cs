using System.ComponentModel.DataAnnotations;
using System.Net;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Authentication;

public class ResourceOwnerPasswordAuthenticationOptions<TClient>
{
    [Required]
    public string TokenEndpointAddress { get; set; } = default!;

    [Required]
    public string ClientId { get; set; } = default!;

    [Required]
    public string ClientSecret { get; set; } = default!;

    public string? Scope { get; set; }

    [Required]
    public NetworkCredential UserCredentials { get; set; } = default!;
}
