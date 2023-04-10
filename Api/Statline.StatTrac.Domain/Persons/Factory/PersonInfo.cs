using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Persons.Factory;

public class PersonInfo
{
    public PersonName Name { get;}

    public PersonInfo(PersonName name)
    {
        Name = Check.NotNull(name);
    }
}
