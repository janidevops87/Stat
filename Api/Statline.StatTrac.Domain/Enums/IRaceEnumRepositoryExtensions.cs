using Statline.StatTrac.Domain.Common;
using System.Linq;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Enums;

public static class IRaceEnumRepositoryExtensions
{
    public static IAsyncEnumerable<TResult> GetRaces<TResult>(
        this IEnumRepository<Race> raceRepository,
        Expression<Func<Race, TResult>> selector)
        => Check.NotNull(raceRepository).GetEnumValues(selector);

    public static IAsyncEnumerable<Race> GetRaces(this IEnumRepository<Race> raceRepository)
        => raceRepository.GetRaces(race => race);

    public static IAsyncEnumerable<TResult> GetRacesOrdered<TResult, TOrderKey>(
        this IEnumRepository<Race> raceRepository,
        Expression<Func<Race, TResult>> selector,
        Expression<Func<Race, TOrderKey>> orderKeySelector,
        Ordering ordering = Ordering.Ascending)
        => Check.NotNull(raceRepository).GetEnumValuesOrdered(
            selector,
            orderKeySelector,
            ordering);

    public static IAsyncEnumerable<TResult> QueryRaces<TResult>(
        this IEnumRepository<Race> raceRepository,
        Expression<Func<Race, bool>> predicate,
        Expression<Func<Race, TResult>> selector)
        => Check.NotNull(raceRepository).QueryEnumValues(predicate, selector);

    public static async Task<int?> FindRaceIdByNameAsync(
         this IEnumRepository<Race> raceRepository,
         string raceName)
    {
        Check.NotEmpty(raceName);

        return await raceRepository.QueryRaces(
            r => raceName == r.RaceName,
            r => (int?)r.RaceId)
            .FirstOrDefaultAsync();
    }

    public static async Task<bool> RaceWithIdExistsAsync(
        this IEnumRepository<Race> raceRepository,
        int id)
        => await Check.NotNull(raceRepository).AnyEnumValueExistsAsync(r => r.RaceId == id);
}
