using Statline.StatTrac.Domain.Phones;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Phones;

internal sealed class PhoneInsertResult
{
    public PhoneId PhoneId { get; private set; }
    public int OrganizationPhoneId { get; private set; }
}
