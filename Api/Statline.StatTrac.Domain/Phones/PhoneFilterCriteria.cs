using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Phones;

public class PhoneFilterCriteria
{
    public PhoneNumber? PhoneNumber { get; set; }
    public ActiveStateFilter ActiveState { get; set; } = ActiveStateFilter.ActiveAndInactive;

    // TODO: Move to constructor?
    public void Validate(string parameterName)
    {
        // Check that at least some criteria
        // are specified.
        // This property is nullable for future
        // support of more filtering criteria.
        if (PhoneNumber is null)
        {
            throw new ArgumentException(
                "At least some filter criteria are required.", parameterName);
        }
    }
}
