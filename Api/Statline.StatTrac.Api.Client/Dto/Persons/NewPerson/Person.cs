using Statline.StatTrac.Api.Client.Dto.Common;

namespace Statline.StatTrac.Api.Client.Dto.Persons.NewPerson;

public class Person
{
    public PersonName Name { get; }

    public Person(PersonName name)
    {
        Name = Check.NotNull(name);
    }
}
