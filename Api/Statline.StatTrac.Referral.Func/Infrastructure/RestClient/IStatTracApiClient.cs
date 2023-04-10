using Statline.StatTrac.Api.Infrastructure.RestClient.Model;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Infrastructure.RestClient
{
    // TODO: Restructure this interface once it starts growing.
    public interface IStatTracApiClient
    {
        Task<ReferralProcessingResult> ProcessReferralAsync(ReferralInfo referralInfo);
        Task<ApiHealthReport> GetApiHealthReportAsync();
    }
}
