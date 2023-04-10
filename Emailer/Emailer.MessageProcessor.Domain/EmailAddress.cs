using Statline.Common.Utilities;
using System;
using System.ComponentModel.DataAnnotations;

namespace Emailer.MessageProcessor.Domain
{
    /// <summary>
    /// A simple typed wrapper for an email address.
    /// The goal is to not depend on any API like
    /// System.Net.Mail and do basic validation.
    /// If better validation is needed, switch to System.Net.Mail.MailAddress.
    /// </summary>
    public class EmailAddress : IEquatable<EmailAddress>
    {
        private const char HostSeparator = '@';

        private static readonly EmailAddressAttribute addressValidator = new();

        public string Address { get; }
        public string? DisplayName { get; }

        public string Host
        {
            get
            {
                // This is a very simple host parsing because
                // we support only simple address format 
                // (without white-spaces, brackets and so on).
                var separatorIndex = Address.IndexOf(HostSeparator);

                return Address[(separatorIndex + 1)..];
            }
        }

        public string User
        {
            get
            {
                var separatorIndex = Address.IndexOf(HostSeparator);
                return Address.Substring(0, separatorIndex);
            }
        }

        public EmailAddress(string address, string? displayName = null)
        {
            ValidateAddress(address);

            Address = address;
            DisplayName = string.IsNullOrWhiteSpace(displayName) ? null : displayName;
        }

        public override string ToString()
        {
            if (DisplayName == null)
            {
                return Address;
            }
            else
            {
                return $"\"{DisplayName}\" <{Address}>";
            }
        }

        public static implicit operator EmailAddress(string address)
        {
            return new EmailAddress(address);
        }

        public static implicit operator string(EmailAddress? address)
        {
            if (address is null)
            {
                throw new ArgumentNullException(nameof(address));
            }

            return address.ToString();
        }

        public static bool operator ==(EmailAddress? left, EmailAddress? right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(EmailAddress? left, EmailAddress? right)
        {
            return !(left == right);
        }

        public bool Equals(EmailAddress? address)
        {
            if (address is null)
            {
                return false;
            }

            return
                string.Equals(Address, address.Address, StringComparison.OrdinalIgnoreCase) &&
                string.Equals(DisplayName, address.DisplayName);
        }

        public override bool Equals(object? obj)
        {
            if (ReferenceEquals(this, obj))
            {
                return true;
            }

            return Equals(obj as EmailAddress);
        }

        public override int GetHashCode()
        {
            return
                Address.GetHashCode() ^
                DisplayName?.GetHashCode() ?? 0;
        }

        // TODO: This should better be implemented using regexp.
        // (but read this first: http://stackoverflow.com/questions/201323/using-a-regular-expression-to-validate-an-email-address#201378)
        private static void ValidateAddress(string address)
        {
            Check.NotNull(address, nameof(address));

            if (!addressValidator.IsValid(address))
            {
                throw new ArgumentException(
                    "Provided value is not a valid email address.",
                    nameof(address));
            }
        }

    }
}
