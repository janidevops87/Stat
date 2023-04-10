using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.Persons
{
    public interface IPersonRepository
    {
        Task<ICollection<StatEmployee>> GetFilteredEmployeesAsync(
            string? firstName,
            string? lastName,
            bool? inactive,
            CancellationToken cancellationToken);

        Task<ICollection<int>> GetFilteredPersonIdsOrderedAsync(
            PersonFilterCriteria filterCriteria,
            CancellationToken cancellationToken);
    }
}
