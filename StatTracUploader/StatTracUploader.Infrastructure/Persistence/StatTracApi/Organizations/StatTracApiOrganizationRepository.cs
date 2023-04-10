using AutoMapper;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Main.LogEvents;
using Statline.StatTracUploader.Domain.Main.Organizations;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.LogEvents;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Organizations
{
    internal class StatTracApiOrganizationRepository : StatTracApiRepository, IOrganizationRepository
    {
        public StatTracApiOrganizationRepository(
            IStatTracApiClient statTracApiClient,
            IMapper mapper) : base(statTracApiClient, mapper)
        {
        }

        public async Task<ICollection<Organization>> GetFilteredOrganizationsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            var filterCriteriaDto =
                Mapper.Map<Services.StatTracApi.Model.Organizations.OrganizationFilterCriteria>(filterCriteria);

            var organizations =
                await StatTracApiClient.GetFilteredOrganizationsAsync(filterCriteriaDto, cancellationToken).ConfigureAwait(false);

            return Mapper.Map<ICollection<Organization>>(organizations);
        }

        public async Task<ICollection<int>> GetFilteredOrganizationIdsAsync(
            OrganizationFilterCriteria filterCriteria, 
            CancellationToken cancellationToken)
        {
            var filterCriteriaDto = 
                Mapper.Map<Services.StatTracApi.Model.Organizations.OrganizationFilterCriteria>(filterCriteria);

            var organizationIds = 
                await StatTracApiClient.GetFilteredOrganizationIdsAsync(filterCriteriaDto, cancellationToken).ConfigureAwait(false);

            return organizationIds;
        }

        public async Task<ICollection<SubLocation>> GetFilteredOrganizationSubLocationsAsync(
            int organizationId, 
            SubLocationFilterCriteria filterCriteria, 
            CancellationToken cancellationToken)
        {
            var filterCriteriaDto =
                Mapper.Map<Services.StatTracApi.Model.Organizations.SubLocationFilterCriteria>(filterCriteria);

            var subLocations = await StatTracApiClient.GetFilteredOrganizationSubLocationsAsync(
                organizationId,
                filterCriteriaDto, 
                cancellationToken).ConfigureAwait(false);

            return Mapper.Map<ICollection<SubLocation>>(subLocations);
        }

        public async Task<ICollection<int>> GetFilteredPhoneIds(
            int organizationId, 
            PhoneFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            var filterCriteriaDto =
                Mapper.Map<Services.StatTracApi.Model.Organizations.PhoneFilterCriteria>(filterCriteria);

            return await StatTracApiClient.GetFilteredOrganizationPhoneIds(
                organizationId,
                filterCriteriaDto,
                cancellationToken).ConfigureAwait(false);
        }
    }
}
