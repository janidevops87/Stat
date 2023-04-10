using Xunit;

namespace Emailer.MessageProcessor.Domain.Tests.Unit
{
    public class LogEventServiceTests
    {
        private static readonly EmailMessageEqualityComparer comparer = new();

        [Fact]
        public void AddLogEventToSubjectAndBody_MessageWithLogEvent_LogEventIsAdded()
        {
            var logEventService = new LogEventService();

            var actualMessage = new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("Test body text. LogEvent: In test!")
                .SetSubject("Test subject text.");


            var expectedMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("LogEvent: In test! Test body text. LogEvent: In test!")
                .SetSubject("LogEvent: In test! Test subject text.");

            logEventService.AddLogEventToSubjectAndBody(actualMessage);

            Assert.Equal(expectedMessage.Build(), actualMessage.Build(), comparer);
        }

        [Fact]
        public void AddLogEventToSubjectAndBody_MessageWithoutLogEvent_MessageNotChanged()
        {
            var logEventService = new LogEventService();

            var actualMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("Test body text.")
                .SetSubject("Test subject text.");


            var expectedMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("Test body text.")
                .SetSubject("Test subject text.");

            logEventService.AddLogEventToSubjectAndBody(actualMessage);

            Assert.Equal(expectedMessage.Build(), actualMessage.Build(), comparer);
        }

        [Fact]
        public void MoveLogEventAndAddSubjectToStartOfBody_MessageWithLogEvent_LogEventIsMoved()
        {
            var logEventService = new LogEventService();

            var actualMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("Test body text. LogEvent: In test!")
                .SetSubject("Test subject text.");

            var expectedMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("LogEvent: In test! Test subject text. Test body text. ")
                .SetSubject("Test subject text.");

            logEventService.MoveLogEventAndAddSubjectToStartOfBody(actualMessage);

            Assert.Equal(expectedMessage.Build(), actualMessage.Build(), comparer);
        }

        [Fact]
        public void MoveLogEventAndAddSubjectToStartOfBody_MessageWithoutLogEvent_MessageNotChanged()
        {
            var logEventService = new LogEventService();

            var actualMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("Test body text.")
                .SetSubject("Test subject text.");

            var expectedMessage =
                new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody("Test body text.")
                .SetSubject("Test subject text.");

            logEventService.MoveLogEventAndAddSubjectToStartOfBody(actualMessage);

            Assert.Equal(expectedMessage.Build(), actualMessage.Build(), comparer);
        }

        [Fact]
        public void GetLogEventLength_LogEventPresent_LengthReturned()
        {
            var logEventService = new LogEventService();

            var logEventText = "LogEvent: In test!";

            var message = new EmailMessageBuilder()
                .SetMessageId(1)
                .SetToAddress("to@gmail.com")
                .SetFromAddress("from@gmail.com")
                .SetBody($"Test body text. " + logEventText)
                .SetSubject("Test subject text.");

            var actualLength = logEventService.GetLogEventLength(message.Build());

            Assert.Equal(logEventText.Length, actualLength);
        }
    }
}
