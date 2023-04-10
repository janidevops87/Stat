using Statline.Common.Repository;
using Statline.StatTrac.Domain.Common;
using System.Linq;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Organizations;

public static class IOrganizationRepositoryExtensions
{
    public static IAsyncEnumerable<OrganizationInfo> GetFilteredOrganizations(
        this IOrganizationRepository organizationRepository,
        OrganizationFilterCriteria filterCriteria)
    {
        Check.NotNull(organizationRepository);
        Check.NotNull(filterCriteria).Validate(nameof(filterCriteria));

        return organizationRepository.GetFilteredOrganizationInfosCore(filterCriteria);
    }

    public static IAsyncEnumerable<int> GetFilteredOrganizationIds(
        this IOrganizationRepository organizationRepository,
        OrganizationFilterCriteria filterCriteria)
    {
        Check.NotNull(organizationRepository);
        Check.NotNull(filterCriteria).Validate(nameof(filterCriteria));

        return organizationRepository.GetFilteredOrganizationsCore(
            filterCriteria,
            selector: organization => organization.OrganizationId);
    }

    public static IAsyncEnumerable<TResult> GetFilteredOrganizations<TResult>(
        this IOrganizationRepository organizationRepository,
        OrganizationFilterCriteria filterCriteria,
        Expression<Func<Organization, TResult>> selector)
    {
        Check.NotNull(organizationRepository);
        Check.NotNull(filterCriteria).Validate(nameof(filterCriteria));

        return organizationRepository.GetFilteredOrganizationsCore(
            filterCriteria,
            selector);
    }

    private static IAsyncEnumerable<OrganizationInfo> GetFilteredOrganizationInfosCore(
        this IOrganizationRepository organizationRepository,
        OrganizationFilterCriteria filterCriteria)
    {
        return organizationRepository.GetFilteredOrganizationsCore(
            filterCriteria,
            selector: org => new OrganizationInfo(org.OrganizationId, org.OrganizationName));
    }

    private static IAsyncEnumerable<TResult> GetFilteredOrganizationsCore<TResult>(
        this IOrganizationRepository organizationRepository,
        OrganizationFilterCriteria filterCriteria,
        Expression<Func<Organization, TResult>> selector)
    {
        return organizationRepository.QueryOrganizations(
            PredicateFromOrganizationFilterCriteria(filterCriteria),
            selector);
    }

    public static async Task<bool> OrganizationWithIdExistsAsync(
        this IOrganizationRepository organizationRepository,
        OrganizationId organizationId)
    {
        return await Check.NotNull(organizationRepository)
            .AnyOrganizationExistsAsync(r => r.OrganizationId == organizationId.Value);
    }

    /// <summary>
    /// Checks if an organization with the given ID <paramref name="organizationId"/> exists
    /// and throws <see cref="EntityDoesntExistException"/> if not.
    /// </summary>
    /// <remarks>
    /// Use this organization check when the <paramref name="organizationId"/> identifies 
    /// the organization entity to be operated on or is logical parent of such entity.
    /// </remarks>
    public static async Task CheckOrganizationWithIdExistsAsync(
        this IOrganizationRepository organizationRepository,
        OrganizationId organizationId)
    {
        var organizationExists = await organizationRepository.OrganizationWithIdExistsAsync(organizationId);

        if (!organizationExists)
        {
            throw new EntityDoesntExistException(
                $"Organization with id '{organizationId}' doesn't exist.");
        }
    }

    /// <summary>
    /// Checks if an organization with the given ID <paramref name="organizationId"/> exists
    /// and throws <see cref="InvalidInputDataException"/> if not.
    /// </summary>
    /// <remarks>
    /// Use this organization check when the <paramref name="organizationId"/> is part of
    /// input data and the identified organization is not the main entity to be operated on
    /// and is not logical parent of such entity.
    /// </remarks>
    public static async Task ValidateOrganizationIdAsync(
       this IOrganizationRepository organizationRepository,
       OrganizationId organizationId)
    {
        var organizationExists = await organizationRepository.OrganizationWithIdExistsAsync(organizationId);

        if (!organizationExists)
        {
            throw new InvalidInputDataException(
                $"Organization with id '{organizationId}' doesn't exist.");
        }
    }

    public static async Task<TResult> GetOrganizationByIdAsync<TResult>(
       this IOrganizationRepository organizationRepository,
       OrganizationId id,
       Expression<Func<Organization, TResult>> selector)
       where TResult : notnull
    {
        Check.NotNull(organizationRepository);

        var foundOrganization = await organizationRepository.FindOrganizationByIdAsync(id, selector);

        if (foundOrganization is null)
        {
            throw new EntityDoesntExistException($"Organization with id '{id}' doesn't exist");
        }

        return foundOrganization;
    }

    private static Expression<Func<Organization, bool>> PredicateFromOrganizationFilterCriteria(
        OrganizationFilterCriteria filterCriteria)
    {
        var phoneNumber = filterCriteria.PhoneNumber;

        return organization =>
            phoneNumber == null || // This is for future if we decide to add more filters.
            (organization.OrganizationPhones.Any(orgPhone =>
                orgPhone.PhoneAreaCode == phoneNumber.AreaCode &&
                orgPhone.PhonePrefix == phoneNumber.Prefix &&
                orgPhone.PhoneNumber == phoneNumber.Number));
    }
}
