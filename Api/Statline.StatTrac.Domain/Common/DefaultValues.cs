namespace Statline.StatTrac.Domain.Common;

public static class DefaultValues
{
    // Some of properties of referral are expected to have
    // default non-null values when values are not provided.
    // So unless client explicitly assigns such property with null
    // it will have default value.
    public const int MinusOne = -1;
    public const int Zero = 0;
}