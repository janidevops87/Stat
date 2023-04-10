using Microsoft.WindowsAzure.Storage.Queue;
using Newtonsoft.Json;
using Statline.Common.Utilities;
using System;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Func.Infrastructure
{
    internal static class CloudQueueExtensions
    {
        public static async Task EnqueueObjectAsync(
            this CloudQueue cloudQueue,
            object item,
            TimeSpan? delay = null)
        {
            Check.NotNull(cloudQueue, nameof(cloudQueue));
            Check.NotNull(item, nameof(item));

            var message = 
                new CloudQueueMessage(JsonConvert.SerializeObject(item));

            await cloudQueue.AddMessageAsync(
                message,
                timeToLive: null,
                initialVisibilityDelay: delay,
                options: null,
                operationContext: null).ConfigureAwait(false);
        }
    }
}
