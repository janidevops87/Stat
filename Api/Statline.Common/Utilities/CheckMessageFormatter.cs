using System;

namespace Statline.Common.Utilities
{
    internal class CheckMessageFormatter
    {
        public string ArgumentPropertyNull(string propertyName, string parameterName)
        {
            return $"The property '{propertyName}' of the argument '{parameterName}' cannot be null.";
        }

        public string CollectionArgumentIsEmpty(string parameterName)
        {
            return $"The collection argument '{parameterName}' must contain at least one element.";
        }

        public string ArgumentIsEmpty(string parameterName)
        {
            return $"The string argument '{parameterName}' cannot be empty.";
        }

        public string ArgumentIsLessThan<T>(string parameterName, T otherValue)
        {
            return $"Argument {parameterName} must be bigger or equal to {otherValue.ToString()}";
        }

        public string CollectionElementIsNull(string parameterName)
        {
            return $"The collection argument '{parameterName}' must not contain nulls.";
        }

        public string CollectionElementIsEmpty(string parameterName)
        {
            return $"The collection argument '{parameterName}' must not contain nulls or empty strings.";
        }
    }
}
