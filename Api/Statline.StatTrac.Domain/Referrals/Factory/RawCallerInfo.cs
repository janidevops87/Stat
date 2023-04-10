using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Phones;

namespace Statline.StatTrac.Domain.Referrals.Factory;

public class RawCallerInfo
{
    public PhoneId PhoneId { get; }
    public PhoneExtension? Extension { get; }
    public PersonId? PersonId { get; }
    public int? SubLocationId { get; }
    public string? SubLocationLevel { get; }
    public int SourceCodeId { get; }
    public RawOrganizationInfo HospitalOrganization { get; }

    public RawCallerInfo(
        PhoneId phoneId,
        PhoneExtension? extension,
        PersonId? personId,
        int? subLocationId,
        string? subLocationLevel,
        int sourceCodeId,
        RawOrganizationInfo hospitalOrganization)
    {
        PersonId = personId;
        PhoneId = phoneId;
        Extension = extension;
        SubLocationId = subLocationId;
        SubLocationLevel = subLocationLevel;
        SourceCodeId = sourceCodeId;
        HospitalOrganization = Check.NotNull(hospitalOrganization);
    }
}
