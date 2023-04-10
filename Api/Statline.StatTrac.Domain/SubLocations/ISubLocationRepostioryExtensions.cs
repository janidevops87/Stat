using Statline.Common.Repository;
using System.Linq;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.SubLocations;

public static class ISubLocationRepostioryExtensions
{
    public static async Task<SubLocation> GetSubLocationByIdAsync(
       this ISubLocationRepository subLocationRepository,
       SubLocationId id)
    {
        Check.NotNull(subLocationRepository);

        var foundSubLocation = await subLocationRepository.FindSubLocationByIdAsync(id);

        if (foundSubLocation is null)
        {
            throw new EntityDoesntExistException($"SubLocation with id '{id}' doesn't exist");
        }

        return foundSubLocation;
    }
}
