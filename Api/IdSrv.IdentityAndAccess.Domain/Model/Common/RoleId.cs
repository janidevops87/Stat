using System;
using Statline.Common.Primitives;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common
{
    /// <summary>
    /// Represents strongly typed/named wrapper over <see cref="Identifier{TId}"/>
    /// for Role ID.
    /// </summary>
    public sealed class RoleId :
        IEquatable<RoleId>,
        IEquatable<string>
    {
        private readonly Identifier<string> value;

        public string Value => value.Value;

        public RoleId(string value)
        {
            Check.NotEmpty(value, nameof(value));
            this.value = value;
        }

        public bool Equals(RoleId other) =>
            other != null && value.Equals(other.Value);
        public bool Equals(string other) => value.Equals(other);
        public override bool Equals(object obj) => Equals(obj as RoleId);
        public override string ToString() => value.ToString();
        public override int GetHashCode() => value.GetHashCode();
        public static bool operator ==(RoleId left, RoleId right)
            => Equals(left, right);
        public static bool operator !=(RoleId left, RoleId right)
            => !(left == right);
        public static implicit operator String(RoleId id) => id?.value;
        public static implicit operator RoleId(string idValue) =>
            idValue == null ? null : new RoleId(idValue);
    }
}
