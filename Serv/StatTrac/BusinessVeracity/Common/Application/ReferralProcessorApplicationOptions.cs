using Statline.StatTrac.BusinessVeracity.Common.Domain;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.Common.Application;

public class ReferralProcessorApplicationOptions
{
    [Required]
    public CallTimeMarginOptions NewReferralCallTimeMargin { get; set; } = default!;
    [Required]
    public CallTimeMarginOptions ReferralUpdateCallTimeMargin { get; set; } = default!;
    public TimeSpan MaxCallDuration { get; set; }
    public TimeSpan NewReferralDefaultCallDuration { get; set; }
    public TimeSpan ProcessingTimeAdjustment { get; set; }
}
