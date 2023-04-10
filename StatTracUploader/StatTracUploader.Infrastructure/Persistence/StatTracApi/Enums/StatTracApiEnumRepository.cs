using AutoMapper;
using Statline.StatTracUploader.Domain.Main.Enums;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Enums
{
    internal class StatTracApiEnumRepository : StatTracApiRepository, IEnumRepository
    {
        public StatTracApiEnumRepository(
            IStatTracApiClient statTracApiClient, 
            IMapper mapper) : base(statTracApiClient, mapper)
        {
        }

        public async Task<ICollection<EnumValue>> GetAllCausesOfDeathAsync(CancellationToken cancellationToken)
        {
            var cods = await StatTracApiClient.GetAllCausesOfDeathAsync(cancellationToken).ConfigureAwait(false);

            return Mapper.Map<ICollection<EnumValue>>(cods);
        }

        public async Task<ICollection<EnumValue>> GetAllRacesAsync(CancellationToken cancellationToken)
        {
            var races = await StatTracApiClient.GetAllRacesAsync(cancellationToken).ConfigureAwait(false);

            return Mapper.Map<ICollection<EnumValue>>(races);
        }
    }
}
