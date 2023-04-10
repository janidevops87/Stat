using AutoMapper;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi
{
    internal abstract class StatTracApiRepository
    {
        protected IStatTracApiClient StatTracApiClient { get; }
        protected IMapper Mapper { get; }

        protected StatTracApiRepository(
            IStatTracApiClient statTracApiClient,
            IMapper mapper)
        {
            StatTracApiClient = Check.NotNull(statTracApiClient, nameof(statTracApiClient));
            Mapper = Check.NotNull(mapper, nameof(mapper));
        }
    }
}
