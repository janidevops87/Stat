using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Referrals.Factory;

public record RawDonorPersonInfo
{
    public PersonName? Name { get; }
    public DateOnly? DateOfBirth { get; }
    // We have both DateOfBirth and Age because the
    // hospital doesn’t always know the DOB so they
    // take a guess on age.
    public PersonAge? Age { get; }
    public int? RaceId { get; }
    public PersonGender? Gender { get; }
    public PersonWeight? Weight { get; }

    public RawDonorPersonInfo(
        PersonName? name,
        DateOnly? dateOfBirth,
        PersonAge? age,
        int? raceId,
        PersonGender? gender,
        PersonWeight? weight)
    {
        Age = age;
        Name = name;
        Weight = weight;
        DateOfBirth = dateOfBirth;
        RaceId = raceId;
        Gender = gender;
    }
}
