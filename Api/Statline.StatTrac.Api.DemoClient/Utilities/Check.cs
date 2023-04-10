using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace Statline.StatTrac.Api.DemoClient.Utilities
{
    [DebuggerStepThrough]
    public static class Check
    {
         static readonly CheckMessageFormatter MessagesFormatter =
            new CheckMessageFormatter();

        public static T NotNull<T>(T value, string parameterName)
        {
            if (ReferenceEquals(value, null))
            {
                NotEmpty(parameterName, nameof(parameterName));

                throw new ArgumentNullException(parameterName);
            }

            return value;
        }

        public static T NotNull<T>(
            T value,
            string parameterName,
            string propertyName)
        {
            if (ReferenceEquals(value, null))
            {
                NotEmpty(parameterName, nameof(parameterName));
                NotEmpty(propertyName, nameof(propertyName));

                throw new ArgumentNullException(MessagesFormatter.ArgumentPropertyNull(propertyName, parameterName));
            }

            return value;
        }

        public static IReadOnlyList<T> NotEmpty<T>(IReadOnlyList<T> value, string parameterName)
        {
            NotNull(value, parameterName);

            if (value.Count == 0)
            {
                NotEmpty(parameterName, nameof(parameterName));

                throw new ArgumentException(MessagesFormatter.CollectionArgumentIsEmpty(parameterName));
            }

            return value;
        }

        public static string NotEmpty(string value, string parameterName)
        {
            Exception e = null;

            if (ReferenceEquals(value, null))
            {
                e = new ArgumentNullException(parameterName);
            }
            else if (value.Trim().Length == 0)
            {
                e = new ArgumentException(MessagesFormatter.ArgumentIsEmpty(parameterName));
            }

            if (e != null)
            {
                NotEmpty(parameterName, nameof(parameterName));

                throw e;
            }

            return value;
        }

        public static IEnumerable<T> HasNoNulls<T>(IEnumerable<T> value, string parameterName)
            where T : class
        {
            NotNull(value, parameterName);

            if (value.Any(e => e == null))
            {
                NotEmpty(parameterName, nameof(parameterName));

                throw new ArgumentException(
                    MessagesFormatter.CollectionElementIsNull(parameterName));
            }

            return value;
        }

        public static IEnumerable<string> HasNoEmpties<T>(IEnumerable<string> value, string parameterName)
            where T : class
        {
            NotNull(value, parameterName);

            if (value.Any(string.IsNullOrWhiteSpace))
            {
                NotEmpty(parameterName, nameof(parameterName));

                throw new ArgumentException(
                    MessagesFormatter.CollectionElementIsEmpty(parameterName));
            }

            return value;
        }

        public static T BiggerOrEqual<T>(
            T value, T other, string parameterName)
            where T : IComparable<T>
        {
            Check.NotNull(value, nameof(value));

            if (value.CompareTo(other) < 0)
            {
                throw new ArgumentOutOfRangeException(
                    parameterName,
                    value,
                    MessagesFormatter.ArgumentIsLessThan(parameterName, other));
            }

            return value;
        }
    }

}
