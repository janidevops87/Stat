using Statline.StatTrac.Api.Client.Dto.Common;
using Statline.StatTrac.Api.Client.Dto.Referrals.Common;

namespace Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

public class DonorPerson
{
    public PersonName? Name { get; init; }
    public DateOnly? DateOfBirth { get; init; }
    public PersonAge? Age { get; init; }
    public int? RaceId { get; init; }
    public PersonGender? Gender { get; init; }
    public PersonWeight? Weight { get; init; }
}
