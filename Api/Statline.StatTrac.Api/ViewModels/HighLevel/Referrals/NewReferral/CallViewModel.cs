using Statline.StatTrac.Api.ViewModels.Common;
using Statline.StatTrac.Api.ViewModels.HighLevel.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public class CallViewModel
{
    public CallerViewModel CallerInformation { get; init; } = default!;
    
    [Range(typeof(DateTimeOffset), ValueLimits.MinDateTimeFormatted, ValueLimits.MaxDateTimeFormatted, ErrorMessage = ValidationMessages.DateTimeOutOfRange)]
    public DateTimeOffset CallReceivedOn { get; init; }
    
    public PersonNameViewModel? CoordinatorName { get; init; }
}
