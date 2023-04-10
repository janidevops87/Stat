using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.Enums
{
    public interface IEnumRepository
    {
        Task<ICollection<EnumValue>> GetAllCausesOfDeathAsync(
            CancellationToken cancellationToken);

        Task<ICollection<EnumValue>> GetAllRacesAsync(
            CancellationToken cancellationToken);
    }
}
