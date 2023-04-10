using Statline.StatTrac.Api.ViewModels.Common;
using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public record CallerViewModel
{
    public PhoneNumber PhoneNumber { get; init; } = default!;
    public PhoneExtension? PhoneExtension { get; init; }
    public int HospitalOrganizationId { get; init; }
    public string SourceCode { get; init; } = default!;
    public PersonNameViewModel CallerName { get; init; } = default!;
}
