using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Common;

public class HospitalSubLocationViewModel
{
    [StringLength(maximumLength: 50, MinimumLength = 1)]
    public string? Name { get; init; }

    [StringLength(maximumLength: 5, MinimumLength = 1)]
    public string? Level { get; init; }
}
