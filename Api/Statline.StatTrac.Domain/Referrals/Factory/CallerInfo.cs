using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.Referrals.Factory;

public record CallerInfo
{
    public PhoneNumber PhoneNumber { get; }
    public PhoneExtension? PhoneExtension { get; }
    public PersonName CallerName { get; }
    public OrganizationId HospitalOrganizationId { get; }
    public string SourceCode { get; }

    public CallerInfo(
        PhoneNumber phoneNumber,
        PhoneExtension? phoneExtension,
        OrganizationId hospitalOrganizationId,
        PersonName callerName,
        string sourceCode)
    {
        CallerName = Check.NotNull(callerName);
        PhoneNumber = Check.NotNull(phoneNumber);
        PhoneExtension = phoneExtension;
        HospitalOrganizationId = hospitalOrganizationId;
        SourceCode = Check.NotEmpty(sourceCode);
    }
}
