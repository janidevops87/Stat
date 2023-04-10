using System;
using Statline.Common.Primitives;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common
{
    /// <summary>
    /// Represents strongly typed/named wrapper over <see cref="Identifier{TId}"/>
    /// for User ID.
    /// </summary>
    public sealed class UserId :
        IEquatable<UserId>,
        IEquatable<string>
    {
        private readonly Identifier<string> value;

        public string Value => value.Value;

        public UserId(string value)
        {
            Check.NotEmpty(value, nameof(value));
            this.value = value;
        }

        public bool Equals(UserId other) =>
            other != null && value.Equals(other.Value);
        public bool Equals(string other) => value.Equals(other);
        public override bool Equals(object obj) => Equals(obj as UserId);
        public override string ToString() => value.ToString();
        public override int GetHashCode() => value.GetHashCode();
        public static bool operator ==(UserId left, UserId right)
            => Equals(left, right);
        public static bool operator !=(UserId left, UserId right)
            => !(left == right);
        public static implicit operator String(UserId id) => id?.value;
        public static implicit operator UserId(string idValue) =>
            idValue == null ? null : new UserId(idValue);
    }
}
