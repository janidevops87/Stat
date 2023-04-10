using AutoMapper;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Main.Referrals;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Referrals;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Referrals
{
    internal class StatTracApiReferralRepository : StatTracApiRepository, IReferralRepository
    {
        public StatTracApiReferralRepository(
            IStatTracApiClient statTracApiClient,
            IMapper mapper) : base(statTracApiClient, mapper)
        {
        }

        public async Task AddReferralAsync(
            Referral referral, 
            CancellationToken cancellationToken)
        {
            Check.NotNull(referral, nameof(referral));

            var newReferral = Mapper.Map<NewReferral>(referral);

            referral.Id = await StatTracApiClient.AddReferralAsync(newReferral, cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<int>> GetDuplicateReferralIdsAsync(
            Domain.Main.Referrals.DuplicateReferralsFilterCriteria filterCriteria, 
            CancellationToken cancellationToken)
        {
            Check.NotNull(filterCriteria, nameof(filterCriteria));

            var filterCriteriaDto = Mapper.Map<Services.StatTracApi.Model.Referrals.DuplicateReferralsFilterCriteria>(filterCriteria);
            
            return await StatTracApiClient.GetDuplicateReferralIdsAsync(
                filterCriteriaDto,
                cancellationToken).ConfigureAwait(false);
        }
    }
}
