using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.JsonFile;

public class JsonFileReferralOutputOptions
{
    public bool WriteIdented { get; set; }
    [Required]
    public string OutputNameFormat { get; set; } = default!;
}
