using System.Linq;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Enums;

public static class ICauseOfDeathEnumRepositoryExtensions
{
    public static IAsyncEnumerable<TResult> GetCausesOfDeath<TResult>(
        this IEnumRepository<CauseOfDeath> codRepository,
        Expression<Func<CauseOfDeath, TResult>> selector)
        => Check.NotNull(codRepository).GetEnumValues(selector);

    public static IAsyncEnumerable<CauseOfDeath> GetCausesOfDeath(
      this IEnumRepository<CauseOfDeath> codRepository)
      => codRepository.GetCausesOfDeath(cod => cod);

    public static IAsyncEnumerable<TResult> QueryCausesOfDeath<TResult>(
        this IEnumRepository<CauseOfDeath> codRepository,
        Expression<Func<CauseOfDeath, bool>> predicate,
        Expression<Func<CauseOfDeath, TResult>> selector)
        => Check.NotNull(codRepository).QueryEnumValues(predicate, selector);

    public static async Task<int?> FindCauseOfDeathIdByNameAsync(
        this IEnumRepository<CauseOfDeath> codRepository,
        string causeOfDeathName)
    {
        Check.NotEmpty(causeOfDeathName);

        return await codRepository.QueryCausesOfDeath(cod =>
            causeOfDeathName == cod.CauseOfDeathName,
            cod => (int?)cod.CauseOfDeathId)
            .FirstOrDefaultAsync();
    }

    public static async Task<bool> CauseOfDeathWithIdExistsAsync(
        this IEnumRepository<CauseOfDeath> codRepository,
        int id)
        => await Check.NotNull(codRepository).AnyEnumValueExistsAsync(cod => cod.CauseOfDeathId == id);
}
