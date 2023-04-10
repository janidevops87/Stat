using Microsoft.Azure.Documents;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Infrastructure.Persistence.DocumentDb;

public class ReferralDto : Resource
{
    public int WebReportGroupId { get; set; }
    public ReferralDetails ReferralData { get; set; }
    public DateTime LastUpdated { get; set; }
}
