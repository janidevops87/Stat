using Statline.Common.Notification;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralSource.StatTracApi;

public class StatTracApiReferralSource : StatTracApiReferralSourceBase<HighRiskReferralDetails>
{
    public StatTracApiReferralSource(
        IStatTracApiClient statTracApiClient,
        INotificationService notificationService,
        ILogger<StatTracApiReferralSource> logger) :
        base(statTracApiClient, notificationService, logger)
    {
    }

    public override async IAsyncEnumerable<HighRiskReferralDetails> GetReferralsAsync(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        Logger.LogQueryingReferralsList();

        var referralInfos = await StatTracApiClient.GetHighRiskCallReferralsAsync(from, to).ConfigureAwait(false);

        Logger.LogReferralCount(referralInfos.Count);

        var referralDetails = GetReferralDetailsForIdsAsync(referralInfos, ri => ri.ReferralId);

        await foreach (var dto in referralDetails.ConfigureAwait(false))
            yield return dto.ToHighRiskReferralDetails();
    }
}
