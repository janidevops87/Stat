using Statline.StatTrac.Api.ViewModels.Common;
using Statline.StatTrac.Api.ViewModels.HighLevel.Common;
using Statline.StatTrac.Domain.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public record DonorPersonViewModel
{
    public PersonNameViewModel? Name { get; init; }

    [Range(typeof(DateOnly), ValueLimits.MinDateTimeFormatted, ValueLimits.MaxDateTimeFormatted, ErrorMessage = ValidationMessages.DateTimeOutOfRange)]
    public DateOnly? DateOfBirth { get; init; }

    public PersonAgeViewModel? Age { get; init; }
    [Range(1, int.MaxValue)]
    public int? RaceId { get; init; }
    public PersonGender? Gender { get; init; }
    public PersonWeightViewModel? Weight { get; init; }
}
