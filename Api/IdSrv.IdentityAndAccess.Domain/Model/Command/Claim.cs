using System;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public sealed class Claim : IEquatable<Claim>
    {
        public Claim(string type, string value)
        {
            Check.NotEmpty(type, nameof(type));
            Check.NotEmpty(value, nameof(value));

            Type = type;
            Value = value;
        }

        private Claim() { }

        public string Type { get; private set; }
        public string Value { get; private set; }

        public bool Equals(Claim other)
        {
            if (other == null)
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return
                Type.Equals(other.Type, StringComparison.Ordinal) &&
                Value.Equals(other.Value, StringComparison.Ordinal);
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as Claim);
        }

        public override int GetHashCode()
        {
            return Type.GetHashCode() ^ Value.GetHashCode();
        }
    }
}
