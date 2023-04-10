using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace Emailer.MessageProcessor.Domain.Tests.Unit
{
    public class EmailSplitterServiceTests
    {
        [Fact]
        public void SplitEmail_MessageNull_ExceptionThrown()
        {
            var target = new EmailSplitterService();

            EmailMessageBuilder message = null;
            var addresses = Enumerable.Empty<MessageLimitingDomainAddress>();

            Assert.Throws<ArgumentNullException>(
                () => target.SplitEmail(message, addresses));
        }

        [Fact]
        public void SplitEmail_AddressesNull_ExceptionThrown()
        {
            var target = new EmailSplitterService();

            var message = new EmailMessageBuilder()
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com");

            IEnumerable<MessageLimitingDomainAddress> addresses = null;

            Assert.Throws<ArgumentNullException>(
                () => target.SplitEmail(message, addresses));
        }

        [Fact]
        public void SplitEmail_BigMessagePassed_MessageSplitIntoRightNumberOfSmallerMessages()
        {
            var target = new EmailSplitterService();

            var originalMessage = new EmailMessageBuilder()
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("12345" + "12345" + "123");

            var limitingDomainAdddresses = new[]
            {
                new MessageLimitingDomainAddress("to@gmail.com", sizeLimit: 5)
            };

            var splitEmails = target.SplitEmail(
                originalMessage,
                limitingDomainAdddresses);

            Assert.Equal(expected: 3, actual: splitEmails.Length);
        }

        [Fact]
        public void SplitEmail_BigMessagePassed_SplitMessagesHaveCorrectSize()
        {
            var target = new EmailSplitterService();

            var originalMessage = new EmailMessageBuilder()
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("12345" + "12345" + "12345");

            var sizeLimit = 5;

            var limitingDomainAdddresses = new[]
            {
                new MessageLimitingDomainAddress("to@gmail.com", sizeLimit)
            };

            var splitEmails = target.SplitEmail(
                originalMessage,
                limitingDomainAdddresses);

            Assert.All(splitEmails, email => Assert.Equal(sizeLimit, email.Body.Length));
        }

        [Fact]
        public void SplitEmail_BigMessagePassed_LastSplitMessageHasCorrectRemainder()
        {
            var target = new EmailSplitterService();

            var originalMessage = new EmailMessageBuilder()
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("12345" + "123");

            var limitingDomainAdddresses = new[]
            {
                new MessageLimitingDomainAddress("to@gmail.com", sizeLimit: 5)
            };

            var splitEmails = target.SplitEmail(
                originalMessage,
                limitingDomainAdddresses);

            Assert.Equal(expected: 3, actual: splitEmails.Last().Body.Length);
        }

        [Fact]
        public void SplitEmail_BigMessagePassed_SplitMessagesHaveCorrectContent()
        {
            var target = new EmailSplitterService();

            var originalMessage = new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("12345" + "12345" + "123")
                .SetSubject("Test subject");

            var sizeLimit = 5;

            var limitingDomainAdddresses = new[]
            {
                new MessageLimitingDomainAddress("to@gmail.com", sizeLimit)
            };

            var actualMessages = target.SplitEmail(
                originalMessage,
                limitingDomainAdddresses).Select(mb => mb.Build());

            var expectedMessages = new[]
            {
                new EmailMessageBuilder()
                    .SetMessageId(1)
                    .SetToAddress("to@gmail.com")
                    .SetFromAddress("from@gmail.com")
                    .SetBody("12345")
                    .SetSubject("Test subject"),

                new EmailMessageBuilder()
                    .SetMessageId(1)
                    .SetToAddress("to@gmail.com")
                    .SetFromAddress("from@gmail.com")
                    .SetBody("12345")
                    .SetSubject("Test subject"),

                new EmailMessageBuilder()
                    .SetMessageId(1)
                    .SetToAddress("to@gmail.com")
                    .SetFromAddress("from@gmail.com")
                    .SetBody("123")
                    .SetSubject("Test subject")
            }.Select(mb => mb.Build());

            Assert.Equal(expectedMessages, actualMessages, new EmailMessageEqualityComparer());
        }

        [Fact]
        public void SplitEmail_BigMessagePassed_SplitMessagesHaveLimitingDomainAddressInTo()
        {
            var target = new EmailSplitterService();

            var originalMessage = new EmailMessageBuilder()
                .SetToAddresses(new EmailAddress[] { "to1@gmail.com", "to2@gmail.com" })
                .SetFromAddress("from@gmail.com")
                .SetBody("12345" + "12345" + "12345");

            // Note that addresses in the original email are basically 
            // ignored, implying they contain the limiting domain address.
            // Somebody else is responsible for cheking.
            var expectedAddress = new EmailAddress("to@gmail.com");
            var expectedTo = new[] { expectedAddress };

            var limitingDomainAdddresses = new[]
            {
                new MessageLimitingDomainAddress(expectedAddress, sizeLimit: 5)
            };

            var splitEmails = target.SplitEmail(
                originalMessage,
                limitingDomainAdddresses);

            Assert.All(splitEmails, email => Assert.Equal(expectedTo, email.ToAddresses));
        }

    }
}
