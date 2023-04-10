using System;
using Statline.Common.Primitives;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model
{
    /// <summary>
    /// Represents strongly typed/named wrapper over <see cref="Identifier{TId}"/>
    /// for Tenant ID.
    /// </summary>
    public sealed class TenantId :
    IEquatable<TenantId>,
    IEquatable<int>
    {
        private readonly Identifier<int> value;

        public int Value => value.Value;

        public TenantId(int value)
        {
            Check.BiggerOrEqual(value, other: 0, nameof(value));
            this.value = value;
        }

        public bool Equals(TenantId other) =>
            other != null && value.Equals(other.Value);
        public bool Equals(int other) => value.Equals(other);
        public override bool Equals(object obj) => Equals(obj as TenantId);
        public override string ToString() => value.ToString();
        public override int GetHashCode() => value.GetHashCode();
        public static bool operator ==(TenantId left, TenantId right)
            => Equals(left, right);
        public static bool operator !=(TenantId left, TenantId right)
            => !(left == right);
        public static implicit operator Int32? (TenantId id) => id?.value;
        public static explicit operator Int32(TenantId id) =>
            id?.value ?? throw new InvalidCastException(
                "Can't cast null to Int32");
        public static implicit operator TenantId(int idValue)
            => new TenantId(idValue);
        public static implicit operator TenantId(int? idValue) =>
            idValue.HasValue ? new TenantId(idValue.Value) : null;
    }
}
