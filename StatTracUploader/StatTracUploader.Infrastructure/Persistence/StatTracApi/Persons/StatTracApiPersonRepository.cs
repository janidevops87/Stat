using AutoMapper;
using Statline.StatTracUploader.Domain.Main.Persons;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Persons
{
    internal class StatTracApiPersonRepository : StatTracApiRepository, IPersonRepository
    {
        public StatTracApiPersonRepository(
            IStatTracApiClient statTracApiClient, 
            IMapper mapper) : base(statTracApiClient, mapper)
        {
        }

        public async Task<ICollection<StatEmployee>> GetFilteredEmployeesAsync(
            string? firstName, 
            string? lastName, 
            bool? inactive, 
            CancellationToken cancellationToken)
        {
            var employeeDtos = await StatTracApiClient.GetFilteredEmployeesAsync(
                firstName,
                lastName,
                inactive,
                cancellationToken).ConfigureAwait(false);

            return Mapper.Map<ICollection<StatEmployee>>(employeeDtos);
        }

        public async Task<ICollection<int>> GetFilteredPersonIdsOrderedAsync(
            PersonFilterCriteria filterCriteria, 
            CancellationToken cancellationToken)
        {
            var filterCriteriaDto =
                Mapper.Map<Services.StatTracApi.Model.Persons.PersonFilterCriteria>(filterCriteria);

            return await StatTracApiClient.GetFilteredPersonIdsOrderedAsync(
                filterCriteriaDto,
                cancellationToken).ConfigureAwait(false);
        }
    }
}
