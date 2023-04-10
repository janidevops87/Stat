using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;

#pragma warning disable CA1822 // Mark members as static

namespace Emailer.MessageProcessor.Domain
{
    /// <summary>
    /// Splits emails into chunks according to size limit.
    /// </summary>
    public sealed class EmailSplitterService
    {
        /// <summary>
        /// Splits an email into chunks according to each 
        /// specified size limit.
        /// </summary>
        /// <param name="originalMessage">The message to split.</param>
        /// <param name="limitingDomainAddresses">
        /// Descriptions of limiting domain addresses (with size limit included).
        /// </param>
        /// <returns>A collection of email chunks.</returns>
        // TODO: Do we need to group chunks by To addresses?
        public EmailMessageBuilder[] SplitEmail(
            EmailMessageBuilder originalMessage,
            IEnumerable<MessageLimitingDomainAddress> limitingDomainAddresses)
        {
            Check.NotNull(originalMessage, nameof(originalMessage));
            Check.NotNull(limitingDomainAddresses, nameof(limitingDomainAddresses));

            return limitingDomainAddresses
                .SelectMany(lda => SplitEmail(originalMessage, lda))
                .ToArray();
        }

        private static IEnumerable<EmailMessageBuilder> SplitEmail(
            EmailMessageBuilder originalMessage,
            MessageLimitingDomainAddress limitingDomainAddress)
        {
            var bodies = SplitBody(
                originalMessage.Body,
                limitingDomainAddress.SizeLimit);

            var messages = bodies.Select(body =>
            {
                return originalMessage
                    .Clone()
                    .SetToAddress(limitingDomainAddress.Address)
                    .SetBody(body);
            }).ToArray();

            return messages;
        }

        private static IEnumerable<string> SplitBody(
            string originalBody,
            int sizeLimit)
        {
            int chunkStartIndex = 0;

            // Break email body text into smaller blocks 
            while ((chunkStartIndex + sizeLimit) < originalBody.Length)
            {
                // Search a new line sequence within the current text block.
                // MSDN: The search proceeds from startIndex toward the beginning of the string. 
                int lastNewLineIndex = originalBody.LastIndexOf(
                    Environment.NewLine,
                    startIndex: chunkStartIndex + sizeLimit - 1,
                    count: sizeLimit);

                int charsToTake = lastNewLineIndex - chunkStartIndex;

                // If last return is not found take full block.
                // TODO: Are we sure that '=' part should be here? 
                if (charsToTake <= 0)
                {
                    charsToTake = sizeLimit;
                }

                // Define block text with last return before sizeLimit
                var bodyChunk = originalBody.Substring(chunkStartIndex, charsToTake);

                chunkStartIndex += charsToTake;

                yield return bodyChunk;
            }

            // Add remaining block of text before LogEvent check 
            var lastBodyChunk = originalBody[chunkStartIndex..];

            yield return lastBodyChunk;
        }
    }
}
