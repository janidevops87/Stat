using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Organizations;

public class OrganizationFilterCriteria
{
    public PhoneNumber? PhoneNumber { get; set; }

    // TODO: Move to constructor?
    public void Validate(string parameterName)
    {
        // Check that at least some criteria
        // are specified.
        if (PhoneNumber is null)
        {
            throw new ArgumentException(
                "At least some filter criteria are required.", parameterName);
        }
    }
}
