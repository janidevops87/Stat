using Statline.StatTrac.Domain.Enums;

namespace Statline.StatTrac.App.Enums;

public class EnumsApplication
{
    private readonly IEnumRepositoryFactory enumRepositoryFactory;

    public EnumsApplication(IEnumRepositoryFactory enumRepositoryFactory)
    {
        this.enumRepositoryFactory = Check.NotNull(enumRepositoryFactory);
    }

    public IAsyncEnumerable<EnumValueInfo> GetAllCausesOfDeath()
    {
        return enumRepositoryFactory.Create<CauseOfDeath>()
            .GetCausesOfDeath(cod => new EnumValueInfo(cod.CauseOfDeathId, cod.CauseOfDeathName));
    }

    public IAsyncEnumerable<EnumValueInfo> GetAllRaces()
    {
        return enumRepositoryFactory.Create<Race>()
            .GetRaces(race => new EnumValueInfo(race.RaceId, race.RaceName));
    }

    public IAsyncEnumerable<EnumValueInfo> GetAllRacesOrderedByNameAscending()
    {
        return enumRepositoryFactory.Create<Race>()
            .GetRacesOrdered(
                race => new EnumValueInfo(race.RaceId, race.RaceName),
                race => race.RaceName);
    }
}
