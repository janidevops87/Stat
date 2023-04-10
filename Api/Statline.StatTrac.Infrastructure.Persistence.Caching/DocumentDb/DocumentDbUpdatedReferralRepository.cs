using Microsoft.Extensions.Logging;
using Statline.Common.Infrastructure.Azure.CosmosDb.DocumentDb;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTrac.App.ReferralProcessor;
using Statline.StatTrac.Domain.Referrals;
using System.Globalization;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.DocumentDb;

public class DocumentDbUpdatedReferralRepository :
    DocumentDbRepository<ReferralDto>,
    IUpdatedReferralRepository
{
    private readonly IDateTimeService dateTimeService;
    private readonly IWebReportGroupIdAccessor webReportGroupIdAccessor;

    // This is used for naive entity instance tracking like
    // in ORMs. Primary goal of this is to avoid exposing
    // any details about how document versioning and optimistic 
    // concurrency are implemented. Repository user just gets
    // an entity instance (Referral), and all "technical" details like ETag
    // remain in corresponding entity container (ReferralDto).
    // When repository client tries to update the entity, repository
    // uses this dictionary to find all the information about the entity
    // at the time of reading it. Thus, its able to persist it with the
    // same ETag and correctly handle concurrent updates.
    // Some details on ETags: https://peter.intheazuresky.com/2016/04/28/documentdb-revisited-part-3-concurrency-in-documentdb/
    private Dictionary<ReferralDetails, ReferralDto> referralToDtoMapping;

    public DocumentDbUpdatedReferralRepository(
        IDocumentDbContext<ReferralDto> context,
        IWebReportGroupIdAccessor webReportGroupIdAccessor,
        IDateTimeService dateTimeService,
        ILogger<DocumentDbUpdatedReferralRepository> logger)
        : base(context,
              logger,
              globalFilter: CreateGlobalFilter(
                  Check.NotNull(webReportGroupIdAccessor, nameof(webReportGroupIdAccessor))))
    {
        Check.NotNull(dateTimeService, nameof(dateTimeService));

        this.dateTimeService = dateTimeService;
        this.webReportGroupIdAccessor = webReportGroupIdAccessor;

        referralToDtoMapping = new Dictionary<ReferralDetails, ReferralDto>(
            ReferenceEqualityComparer<ReferralDetails>.Instance);
    }

    private static Expression<Func<ReferralDto, bool>> CreateGlobalFilter(
        IWebReportGroupIdAccessor webReportGroupIdAccessor)
    {
        return item => item.WebReportGroupId ==
            webReportGroupIdAccessor.GetWebReportGroupId().Value;
    }

    public async Task<IEnumerable<ReferralId>> GetUpdatedAsync(DateTimeOffset sinceTime)
    {
        var sinceTimeUtc = sinceTime.ToUniversalTime().UtcDateTime;

        var referralIds = await GetItemsAsync(
           item => item.LastUpdated >= sinceTimeUtc,
           item => item.ReferralData.ReferralId).ConfigureAwait(false);

        return referralIds.Select(id => new ReferralId(id));
    }

    public async Task<ReferralDetails?> GetDetailsByIdAsync(ReferralId referralId)
    {
        Check.NotNull(referralId, nameof(referralId));

        var referralDtos = await GetItemsWithTrackingAsync(item =>
            item.ReferralData.ReferralId == referralId.Value).ConfigureAwait(false);

        var referralDto = referralDtos.SingleOrDefault();

        return referralDto?.ReferralData;
    }

    public async Task AddAsync(ReferralDetails referral)
    {
        Check.NotNull(referral, nameof(referral));

        ReferralDto referralDto = WrapReferralInDto(referral);

        await CreateItemAsync(referralDto).ConfigureAwait(false);
    }

    public async Task UpdateAsync(ReferralDetails referral)
    {
        Check.NotNull(referral, nameof(referral));

        ReferralDto referralDto = GetReferralDto(referral);

        // TODO: In case of exception during saving to DB this 
        // will remain updated. Think if this can cause problems.
        referralDto.LastUpdated = dateTimeService.GetCurrent().UtcDateTime;

        await UpdateItemAsync(referralDto).ConfigureAwait(false);
    }

    public async Task DeleteAsync(ReferralId referralId)
    {
        Check.NotNull(referralId, nameof(referralId));
        await DeleteCoreAsync(referralId).ConfigureAwait(false);
    }

    public async Task DeleteAsync(ReferralDetails referral)
    {
        Check.NotNull(referral, nameof(referral));
        await DeleteCoreAsync(new ReferralId(referral.ReferralId)).ConfigureAwait(false);
        StopReferralDtoTracking(referral);
    }

    private async Task DeleteCoreAsync(ReferralId referralId)
    {
        await DeleteItemAsync(referralId.ToString()).ConfigureAwait(false);
    }

    private ReferralDto WrapReferralInDto(ReferralDetails referral)
    {
        var referralDto = new ReferralDto
        {
            Id = referral.ReferralId.ToString(CultureInfo.InvariantCulture),
            WebReportGroupId = webReportGroupIdAccessor.GetWebReportGroupId().Value,
            ReferralData = referral,
            LastUpdated = dateTimeService.GetCurrent().UtcDateTime
        };

        return referralDto;
    }

    private ReferralDto GetReferralDto(ReferralDetails referral)
    {
        try
        {
            return referralToDtoMapping[referral];
        }
        catch (KeyNotFoundException ex)
        {
            throw new InvalidOperationException(
                "Referral was not previously read from the repository.", ex);
        }
    }

    private void StopReferralDtoTracking(ReferralDetails referral)
    {
        referralToDtoMapping.Remove(referral);
    }

    private async Task<List<ReferralDto>> GetItemsWithTrackingAsync(
        Expression<Func<ReferralDto, bool>> predicate)
    {
        var items = await GetItemsAsync(predicate).ConfigureAwait(false);

        foreach (var item in items)
        {
            referralToDtoMapping[item.ReferralData] = item;
        }

        return items;
    }

}
