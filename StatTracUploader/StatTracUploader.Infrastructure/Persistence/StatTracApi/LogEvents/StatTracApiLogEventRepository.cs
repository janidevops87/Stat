using AutoMapper;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Main.LogEvents;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.LogEvents;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.LogEvents
{
    internal class StatTracApiLogEventRepository : StatTracApiRepository, ILogEventRepository
    {
        public StatTracApiLogEventRepository(
            IStatTracApiClient statTracApiClient,
            IMapper mapper) : base(statTracApiClient, mapper)
        {
        }

        public async Task AddLogEventAsync(LogEvent logEvent, CancellationToken cancellationToken)
        {
            Check.NotNull(logEvent, nameof(logEvent));

            var newLogEvent = Mapper.Map<NewLogEvent>(logEvent);

            logEvent.Id = await StatTracApiClient.AddLogEventAsync(newLogEvent, cancellationToken).ConfigureAwait(false);
        }
    }
}
