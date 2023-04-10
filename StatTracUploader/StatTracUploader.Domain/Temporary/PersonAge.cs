using Statline.Common.Utilities;
using System;
using System.Globalization;

namespace Statline.StatTracUploader.Domain.Temporary
{
    // Ideally this should be struct, but that's not supported by EF.
    public record PersonAge
    {
        private readonly int value;
        private readonly AgeUnit unit;

        public int Value
        {
            get => value;
            init { this.value = Check.BiggerOrEqual(value, 0, nameof(Value)); }
        }

        public AgeUnit Unit
        {
            get => unit;
            init
            {
                unit = Enum.IsDefined(value) ? value : throw new ArgumentException("Unknown age unit", nameof(Unit));
            }
        }

        public PersonAge(int value, AgeUnit unit)
        {
            Value = value;
            Unit = unit;
        }

        public override string ToString()
        {
            return
                $"{value.ToString(CultureInfo.InvariantCulture)} " +
                $"{Unit.ToString().ToLower()}";
        }

    }
}
