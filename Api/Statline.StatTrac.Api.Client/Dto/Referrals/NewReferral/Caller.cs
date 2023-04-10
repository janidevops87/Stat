using Statline.StatTrac.Api.Client.Dto.Common;

namespace Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

public class Caller
{
    public string PhoneNumber { get; }
    public string? PhoneExtension { get; }
    public int HospitalOrganizationId { get; }
    public string SourceCode { get; }
    public PersonName CallerName { get; }

    public Caller(
        string phoneNumber,
        string? phoneExtension,
        int hospitalOrganizationId,
        string sourceCode,
        PersonName callerName)
    {
        PhoneNumber = Check.NotEmpty(phoneNumber);
        PhoneExtension = phoneExtension;
        HospitalOrganizationId = hospitalOrganizationId;
        SourceCode = Check.NotEmpty(sourceCode);
        CallerName = Check.NotNull(callerName);
    }
}
