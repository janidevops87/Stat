using Statline.Common.Notification;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.ReferralSource.StatTracApi;

public class StatTracApiReferralSource : StatTracApiReferralSourceBase<ReferralDetails>
{
    public StatTracApiReferralSource(
        IStatTracApiClient statTracApiClient,
        INotificationService notificationService,
        ILogger<StatTracApiReferralSource> logger) :
        base(statTracApiClient, notificationService, logger)
    {
    }

    public override async IAsyncEnumerable<ReferralDetails> GetReferralsAsync(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        Logger.LogQueryingReferralsList();

        var referralIds = await StatTracApiClient.GetUpdatedReferrals(from, to).ConfigureAwait(false);

        Logger.LogReferralCount(referralIds.Count);

        var referralDetailDtos = GetReferralDetailsForIdsAsync(referralIds);

        await foreach (var dto in referralDetailDtos.ConfigureAwait(false))
            yield return dto.ToReferralDetails();
    }
}
