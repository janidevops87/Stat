using System;
using System.Collections.Generic;
using System.Globalization;

namespace Statline.Common.Primitives
{
#pragma warning disable RECS0017 // Possible compare of value type with 'null'

    /// <summary>
    /// A common type for representing identifier values.
    /// </summary>
    /// <typeparam name="TId">
    /// The underlying identifier type 
    /// (e.g. <see cref="int"/>, <see cref="string"/> etc.)
    /// </typeparam>
    public readonly struct Identifier<TId> :
        IEquatable<Identifier<TId>>,
        IEquatable<TId>
        where TId : IEquatable<TId>
    {
        public TId Value { get; }

        public Identifier(TId value)
        {
            Value = value;
        }

        public bool Equals(Identifier<TId> other)
        {
            return Equals(other.Value);
        }

        public bool Equals(TId otherValue)
        {
            return EqualityComparer<TId>.Default.Equals(Value, otherValue);
        }

        public static bool Equals(Identifier<TId> left, Identifier<TId> right)
        {
            return EqualityComparer<Identifier<TId>>.Default.Equals(left, right);
        }

        public override bool Equals(object obj)
        {
            if (obj == null)
            {
                return false;
            }

            if (obj.GetType() != typeof(Identifier<TId>))
            {
                return false;
            }

            return Equals((Identifier<TId>)obj);
        }

        public override int GetHashCode()
            => Value == null ? 0 : Value.GetHashCode();

        public override string ToString()
        {
            if (Value is IFormattable formattable)
            {
                // Identifier is something which shouldn't 
                // look culture-specific.
                return formattable.ToString(format: null, CultureInfo.InvariantCulture);
            }

            return Value == null ? string.Empty : Value.ToString();
        }

        public static bool operator ==(Identifier<TId> left, Identifier<TId> right)
            => Equals(left, right);

        public static bool operator !=(Identifier<TId> left, Identifier<TId> right)
            => !(left == right);

        public static implicit operator TId(Identifier<TId> id)
        {
            return id.Value;
        }

        public static implicit operator Identifier<TId>(TId id)
        {
            return new Identifier<TId>(id);
        }
    }

#pragma warning restore RECS0017 // Possible compare of value type with 'null'
}
