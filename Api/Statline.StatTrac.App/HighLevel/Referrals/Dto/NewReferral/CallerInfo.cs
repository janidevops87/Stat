using Statline.StatTrac.App.HighLevel.Phones;
using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;

public class CallerInfo
{
    public PhoneNumber PhoneNumber { get; }
    public PhoneExtension? PhoneExtension { get; }
    public int HospitalOrganizationId { get; }
    public string SourceCode { get; }
    public PersonName CallerName { get; }
    public CallerInfo(
        PhoneNumber phoneNumber,
        PhoneExtension? phoneExtension,
        int hospitalOrganizationId,
        string sourceCode,
        PersonName callerName)
    {
        PhoneNumber = Check.NotNull(phoneNumber);
        PhoneExtension = phoneExtension;
        HospitalOrganizationId = Check.Bigger(hospitalOrganizationId, other: 0);
        SourceCode = Check.NotEmpty(sourceCode);
        CallerName = Check.NotNull(callerName);
    }
}
