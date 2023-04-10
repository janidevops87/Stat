using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Phones;

public static class IPhoneRepositoryExtensions
{
    public static async Task<bool> OrganizationPhoneWithPhoneNumberExistsAsync(
        this IPhoneRepository phoneRepository,
        OrganizationId organizationId,
        PhoneNumber phoneNumber)
    {
        Check.NotNull(phoneNumber);

        return await Check.NotNull(phoneRepository)
            .AnyOrganizationPhoneExistsAsync(orgPhone =>
                orgPhone.PhoneAreaCode == phoneNumber.AreaCode &&
                orgPhone.PhonePrefix == phoneNumber.Prefix &&
                orgPhone.PhoneNumber == phoneNumber.Number &&
                orgPhone.OrganizationId == organizationId.Value);
    }

    public static IAsyncEnumerable<TResult> GetFilteredOrganizationPhones<TResult>(
        this IPhoneRepository phoneRepository,
        OrganizationId organizationId,
        PhoneFilterCriteria filterCriteria,
        Expression<Func<OrganizationPhone, TResult>> selector)
    {
        Check.NotNull(phoneRepository);
        Check.NotNull(filterCriteria).Validate(nameof(filterCriteria));
        Check.NotNull(selector);

        return GetFilteredOrganizationPhonesCore(
            phoneRepository,
            organizationId,
            filterCriteria,
            selector);
    }

    public static IAsyncEnumerable<PhoneId> GetFilteredOrganizationPhoneIds(
        this IPhoneRepository phoneRepository,
        OrganizationId organizationId,
        PhoneFilterCriteria filterCriteria)
    {
        Check.NotNull(phoneRepository);
        Check.NotNull(filterCriteria).Validate(nameof(filterCriteria));

        return phoneRepository.GetFilteredOrganizationPhonesCore(
            organizationId,
            filterCriteria,
            orgPhone => orgPhone.PhoneId);
    }
   
    private static IAsyncEnumerable<TResult> GetFilteredOrganizationPhonesCore<TResult>(
           this IPhoneRepository phoneRepository,
           OrganizationId organizationId,
           PhoneFilterCriteria filterCriteria,
           Expression<Func<OrganizationPhone, TResult>> selector)
    {
        return phoneRepository.QueryOrganizationPhones(
            PredicateFromOrganizationPhoneFilterCriteria(organizationId, filterCriteria),
            selector);
    }

    private static Expression<Func<OrganizationPhone, bool>> PredicateFromOrganizationPhoneFilterCriteria(
        OrganizationId organizationId,
        PhoneFilterCriteria filterCriteria)
    {
        var phoneNumber = filterCriteria.PhoneNumber;

        return orgPhone =>
            // Whatever the filter is, we want to exclude all
            // phones with nulls.
            orgPhone.PhoneAreaCode != null &&
            orgPhone.PhonePrefix != null &&
            orgPhone.PhoneNumber != null &&

            orgPhone.OrganizationId == organizationId.Value &&

            (phoneNumber == null || // To suppress warnings and for potentially more filters in future.
            orgPhone.PhoneAreaCode == phoneNumber.AreaCode &&
            orgPhone.PhonePrefix == phoneNumber.Prefix &&
            orgPhone.PhoneNumber == phoneNumber.Number) &&
            // Formal rule:
            // 0 = false (active),
            // null = false (active),
            // any other value(inc. -1) = true (inactive)
            (filterCriteria.ActiveState == ActiveStateFilter.ActiveAndInactive ||
                (
                    (orgPhone.OrganizationPhoneInactive == IntegerBoolean.OneTrue || 
                    orgPhone.OrganizationPhoneInactive == IntegerBoolean.MinusOneTrue) == 
                    (filterCriteria.ActiveState == ActiveStateFilter.InactiveOnly)
                )
            );
    }
}
