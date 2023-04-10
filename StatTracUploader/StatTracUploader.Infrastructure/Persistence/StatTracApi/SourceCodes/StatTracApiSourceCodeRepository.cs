using AutoMapper;
using Statline.StatTracUploader.Domain.Main.SourceCodes;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.SourceCodes
{
    internal class StatTracApiSourceCodeRepository : StatTracApiRepository, ISourceCodeRepository
    {
        public StatTracApiSourceCodeRepository(
            IStatTracApiClient statTracApiClient, 
            IMapper mapper) : base(statTracApiClient, mapper)
        {
        }

        public async Task<int> FindSourceCodeIdByNameAsync(
            string sourceCode, 
            CancellationToken cancellationToken)
        {
            return await StatTracApiClient.GetSourceCodeIdAsync(sourceCode, cancellationToken).ConfigureAwait(false);
        }
    }
}
