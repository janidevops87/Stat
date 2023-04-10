using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Statline.Common.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue
{
    internal class LegacyMessageQueue : ILegacyMessageQueue
    {
        private readonly ReferralDbContext referralDbContext;
        private readonly ILogger logger;
        private readonly IDateTimeService dateTimeService;

        public LegacyMessageQueue(
            ReferralDbContext referralDbContext,
            ILogger<LegacyMessageQueue> logger,
            IDateTimeService dateTimeService)
        {
            this.referralDbContext = referralDbContext;
            this.logger = logger;
            this.dateTimeService = dateTimeService;
        }

        public async Task<IEnumerable<Message>> GetUnprocessedMessagesAsync(CancellationToken cancellationToken)
        {
            logger.LogDebug("Polling the database for new messages...");



            AlphaPage[] alphaPages;

            try
            {
                // TODO: Refactor to avoid using raw SQL.

                alphaPages = await referralDbContext.AlphaPage.FromSqlRaw(
                        @"SELECT 
                        [AlphaPageId], 
                        [CallId], 
                        [AlphaPageRecipient], 
                        [AlphaPageSender], 
                        [AlphaPageBC], 
                        [AlphaPageCC], 
                        [AlphaPageSubject], 
                        [AlphaPageBody], 
                        [AlphaPageCreated], 
                        COALESCE([AlphaPageSent], 0) AS AlphaPageSent, 
                        COALESCE([AlphaPageComplete], '') AS AlphaPageComplete 
                        FROM AlphaPage 
                        WHERE AlphaPageSent IS NULL 
                        ORDER BY AlphaPageComplete ASC")
                    .AsNoTracking()
                    .ToArrayAsync(cancellationToken)
                    .ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                var errorMessage = $"{ex.Message} {ex.InnerException?.Message}";
                var sendErrorLocation = "Failure Getting Alpha Page Queue";
                logger.LogError($"{sendErrorLocation}. {errorMessage}");
                throw;
            }

            if (alphaPages.Length > 0)
            {
                logger.LogInformation($"Got {alphaPages.Length} unprocessed messages.");
            }
            else
            {
                logger.LogInformation("There are no unprocessed messages.");
            }

            return alphaPages.Select(row => new Message(row));
        }

        public async Task MarkMessageProcessedAsync(int messageId, CancellationToken cancellationToken)
        {
            logger.LogInformation("Marking message with AlphaPageId = '{AlphaPageId}' as handled in the database...", messageId);

            var nowDateTime = dateTimeService.GetCurrent().DateTime;

            try
            {
                // TODO: Refactor to avoid using raw SQL.
                await referralDbContext.Database
                    .ExecuteSqlInterpolatedAsync(
                            @$"UPDATE AlphaPage SET 
                            AlphaPageComplete += 1, 
                            AlphaPageSent = {nowDateTime} 
                            WHERE AlphaPageId =  {messageId}",
                            cancellationToken)
                    .ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                var errorMessage = $"{ex.Message} {ex.InnerException?.Message}";
                var sendErrorLocation = "Failure Updating Alpha Page Queue";
                logger.LogError($"{sendErrorLocation}. {errorMessage}");
                throw;
            }

            logger.LogInformation("Message with AlphaPageId = '{AlphaPageId}' was marked as handled.", messageId);
        }
    }
}
