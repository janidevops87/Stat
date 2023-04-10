using System;
using Statline.Common.Primitives;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common
{
    // TODO: Think how to make the code below more 
    // reusable, since ID types will mostly contain 
    // the same code.
    //
    // I see two options:
    //
    // 1. Use T4 code generation to automatically create
    // ID types from list of names and inner types. 
    // The drawback are:
    // a) inability to add custom logic,
    // but can be worked around with partial methods
    // to some degree. 
    // b) T4 tools complicate code understanding and 
    // require additional setup for build environment.
    // c) not sure how to test such code.
    //
    // 2. Use generic reference type wrappers with inheritance
    // (e.g. class StringId : EntityId<string, StringId>{}).
    // This will allow to define base classes for specific
    // classes of IDs (like positive integer IDs or non-empty strings IDs).
    // The drawbacks are: 
    // a) even with generics tricks it's
    // impossible to inherit strongly typed operations 
    // (IEquatable.Equals, ==, !=) further than
    // immediate inheritor.
    // b) possible performance/memory usage penalties due to 
    // using reference types where value types really should 
    // be used.
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
        public static implicit operator Int32?(TenantId id) => id?.value;
        public static explicit operator Int32(TenantId id) => 
            id?.value ?? throw new InvalidCastException(
                "Can't cast null to Int32");
        public static implicit operator TenantId(int idValue) 
            => new TenantId(idValue);
        public static implicit operator TenantId(int? idValue) => 
            idValue.HasValue ? new TenantId(idValue.Value) : null;
    }
}
