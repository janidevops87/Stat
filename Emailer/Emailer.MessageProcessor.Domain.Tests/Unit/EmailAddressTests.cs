using System;
using Xunit;

namespace Emailer.MessageProcessor.Domain.Tests.Unit
{
    public class EmailAddressTests
    {
        [Fact]
        public void Constructor_AddressNull_ExceptionThrown()
        {
            Assert.Throws<ArgumentNullException>(
                () => new EmailAddress(address: null));
        }

        [Fact]
        public void Constructor_AddressEmpty_ExceptionThrown()
        {
            Assert.Throws<ArgumentException>(
                () => new EmailAddress(address: string.Empty));
        }

        [Theory]
        [InlineData("to_at_gmail.com")]
        [InlineData("to!gmail.com")]
        // TODO: Current email validation is very basic, need to
        // enhance it so cases below can be handled.
        //[InlineData("<to@gmail.com>")]
        //[InlineData("To <to@gmail.com>")]
        //[InlineData("to@gmail.com Hi there!")]
        public void Constructor_AddressInvalid_ExceptionThrown(string address)
        {
            Assert.Throws<ArgumentException>(
                () => new EmailAddress(address: address));
        }

        [Fact]
        public void Host_ReturnsCorrectHostName()
        {
            var address = new EmailAddress(address: "to@gmail.com");

            Assert.Equal("gmail.com", address.Host);
        }

        [Fact]
        public void Address_ReturnsAddress()
        {
            var address = new EmailAddress(address: "to@gmail.com", displayName: "To");

            Assert.Equal("to@gmail.com", address.Address);
        }

        [Fact]
        public void DisplayName_ReturnsDisplayName()
        {
            var address = new EmailAddress(address: "to@gmail.com", displayName: "To");

            Assert.Equal("To", address.DisplayName);
        }

        [Fact]
        public void DisplayName_NotSpecified_ReturnsDefaultDisplayName()
        {
            var address = new EmailAddress(address: "to@gmail.com");

            string expectedDisplayName = null;

            Assert.Equal(expectedDisplayName, address.DisplayName);
        }

        [Fact]
        public void DisplayName_WhitespaceSpecified_ReturnsDefaultDisplayName()
        {
            var address = new EmailAddress(address: "to@gmail.com", displayName: " ");

            string expectedDisplayName = null;

            Assert.Equal(expectedDisplayName, address.DisplayName);
        }
    }
}
