using Statline.StatTrac.Api.Client;
using Statline.StatTrac.Api.Client.Dto.Common;
using Statline.StatTrac.Api.Client.Dto.Persons.Filtered;
using Statline.StatTrac.Api.Client.Dto.Phones.Filtered;

namespace Statline.StatTrac.Integration.App.Copernicus;

internal static class IStatTracApiClientExtensions
{
    public static async Task<bool> AnyOrganizationPersonWithNameExistsAsync(
        this IStatTracApiClient apiClient,
        int organizationId,
        PersonName personName)
    {
        var ids = await apiClient.GetFilteredOrganizationPersonIdsAsync(
            organizationId,
            new PersonFilterCriteria(
                personName.FirstName, 
                personName.LastName, 
                ActiveStateFilter.ActiveOnly));

        return ids.Any();
    }

    public static async Task<bool> OrganizationPhoneExistsAsync(
        this IStatTracApiClient apiClient,
        int organizationId,
        string phoneNumber)
    {
        var ids = await apiClient.GetFilteredOrganizationPhoneIdsAsync(
            organizationId,
            new PhoneFilterCriteria(phoneNumber));

        return ids.Any();
    }
}
