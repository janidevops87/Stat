using AutoMapper;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Main.Calls;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Calls;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Calls
{
    internal class StatTracApiCallRepository : StatTracApiRepository, ICallRepository
    {
        public StatTracApiCallRepository(
            IStatTracApiClient statTracApiClient,
            IMapper mapper) :base(statTracApiClient, mapper)
            
        {
        }

        public async Task AddCallAsync(Call call, CancellationToken cancellationToken)
        {
            Check.NotNull(call, nameof(call));

            var newCall = Mapper.Map<NewCall>(call);

            call.Id = await StatTracApiClient.AddCallAsync(newCall, cancellationToken).ConfigureAwait(false);
        }
    }
}
