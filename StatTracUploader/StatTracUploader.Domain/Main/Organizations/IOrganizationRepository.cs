using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.Organizations
{
    public interface IOrganizationRepository
    {
        Task<ICollection<int>> GetFilteredOrganizationIdsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<Organization>> GetFilteredOrganizationsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<SubLocation>> GetFilteredOrganizationSubLocationsAsync(
            int organizationId,
            SubLocationFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<int>> GetFilteredPhoneIds(
            int organizationId,
            PhoneFilterCriteria filterCriteria,
            CancellationToken cancellationToken);
    }
}
