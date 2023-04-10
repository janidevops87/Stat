using System;
using Xunit;

namespace Emailer.MessageProcessor.Domain.Tests.Unit
{
    public class EmailMessageTests
    {
        [Fact]
        public void Constructor_ToAddressesCollectionNull_ExceptionThrown()
        {
            Assert.Throws<ArgumentNullException>(() => new EmailMessage(id: 1,
                    to: null,
                    cc: Array.Empty<EmailAddress>(),
                    bcc: Array.Empty<EmailAddress>(),
                    from: new EmailAddress("from@gmail.com")));
        }

        [Fact]
        public void Constructor_ToAddressesCollectionEmpty_ExceptionThrown()
        {
            Assert.Throws<ArgumentException>(() => new EmailMessage(id: 1,
                    to: Array.Empty<EmailAddress>(),
                    cc: Array.Empty<EmailAddress>(),
                    bcc: Array.Empty<EmailAddress>(),
                    from: new EmailAddress("from@gmail.com")));
        }

        [Fact]
        public void Constructor_ToAddressesCollectionHasNull_ExceptionThrown()
        {
            Assert.Throws<ArgumentException>(() => new EmailMessage(id: 1,
                    to: new[]
                    {
                        new EmailAddress("to1@gmail.com"),
                        null,
                        new EmailAddress("to2@gmail.com")
                    },
                    cc: Array.Empty<EmailAddress>(),
                    bcc: Array.Empty<EmailAddress>(),
                    from: new EmailAddress("from@gmail.com")));
        }

        [Fact]
        public void Constructor_ToAddressNull_ExceptionThrown()
        {
            Assert.Throws<ArgumentNullException>(() => new EmailMessage(id: 1,
                    to: (EmailAddress)null,
                    from: new EmailAddress("from@gmail.com")));
        }

        [Fact]
        public void Constructor_FromAddressNull_ExceptionThrown()
        {
            Assert.Throws<ArgumentNullException>(() => new EmailMessage(id: 1,
                    to: new EmailAddress("to@gmail.com"),
                    from: null));
        }
    }
}
