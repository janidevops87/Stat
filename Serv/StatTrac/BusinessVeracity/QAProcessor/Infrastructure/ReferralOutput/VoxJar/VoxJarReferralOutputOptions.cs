using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;

public class VoxJarReferralOutputOptions
{
    [Required]
    public string VoxJarCompanyId { get; set; } = default!;
}
