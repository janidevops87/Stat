using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Persons;

public class PersonRepository :
    RepositoryBase<ReferralTransactionalDbContext, Person>,
    IPersonRepository
{
    public PersonRepository(
        ReferralTransactionalDbContext DbContext)
        : base(DbContext)
    {
    }

    public async Task<bool> AnyEmployeeExistsAsync(
        Expression<Func<StatEmployee, bool>> predicate)
    {
        Check.NotNull(predicate);

        return await DbContext.StatEmployees
            .TagWithCallerName()
            .AnyAsync(predicate)
            .ConfigureAwait(false);
    }

    public IAsyncEnumerable<StatEmployee> QueryEmployees(
        Expression<Func<StatEmployee, bool>> predicate)
    {
        Check.NotNull(predicate, nameof(predicate));

        var employees = DbContext.StatEmployees
            .TagWithCallerName()
            .Where(predicate);

        return employees.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> QueryEmployees<TResult>(
        Expression<Func<StatEmployee, bool>> predicate,
        Expression<Func<StatEmployee, TResult>> selector)
    {
        Check.NotNull(predicate, nameof(predicate));
        Check.NotNull(selector, nameof(selector));

        var results = DbContext.StatEmployees
            .TagWithCallerName()
            .Where(predicate)
            .Select(selector);

        return results.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> QueryEmployeesOrdered<TResult, TOrderKey>(
        Expression<Func<StatEmployee, bool>> predicate,
        Expression<Func<StatEmployee, TResult>> selector,
        params (Expression<Func<StatEmployee, object?>> orderKeySelector, Ordering ordering)[] orderingInfos)
    {
        Check.NotNull(predicate, nameof(predicate));
        Check.NotNull(selector, nameof(selector));
        Check.NotNull(orderingInfos, nameof(orderingInfos));

        var query = DbContext.StatEmployees
            .TagWithCallerName()
            .Where(predicate);

        query = AddOrderingsToQuery(query, orderingInfos);

        var persons = query.Select(selector);

        return persons.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<Person> QueryPersons(
        Expression<Func<Person, bool>> predicate)
    {
        var persons = DbContext.Persons
            .TagWithCallerName()
            .Include(p => p.Race)
            .Include(p => p.Gender)
            .Where(predicate);

        return persons.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> QueryPersons<TResult>(
        Expression<Func<Person, bool>> predicate,
        Expression<Func<Person, TResult>> selector)
    {
        var results = DbContext.Persons
            .TagWithCallerName()
            .Include(p => p.Race)
            .Include(p => p.Gender)
            .Where(predicate)
            .Select(selector);

        return results.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> QueryPersonsOrdered<TResult>(
        Expression<Func<Person, bool>> predicate,
        Expression<Func<Person, TResult>> selector,
        params (Expression<Func<Person, object?>> orderKeySelector, Ordering ordering)[] orderingInfos)
    {
        Check.NotNull(predicate, nameof(predicate));
        Check.NotNull(selector, nameof(selector));
        Check.NotNull(orderingInfos, nameof(orderingInfos));

        var query = DbContext.Persons
            .TagWithCallerName()
            .Include(p => p.Race)
            .Include(p => p.Gender)
            .Where(predicate);

        query = AddOrderingsToQuery(query, orderingInfos);

        var persons = query.Select(selector);

        return persons.AsAsyncEnumerable();
    }

    public async Task<TResult?> FindPersonByIdAsync<TResult>(
       int id,
       Expression<Func<Person, TResult>> selector) where TResult : notnull
    {
        Check.Bigger(id, 0);
        Check.NotNull(selector);

        return await DbContext.Persons
            .TagWithCallerName()
            .Include(p => p.Race)
            .Include(p => p.Gender)
            .Where(person => person.PersonId == id)
            .Select(selector)
            .SingleOrDefaultAsync()
            .ConfigureAwait(false);
    }

    public async Task AddPersonAsync(Person person)
    {
        var createdPersonList = await DbContext.Set<PersonInsertResult>()
            .FromSqlInterpolated($@"EXEC PersonInsert
                @PersonID                    = NULL, -- Output parameter, can't use it here.
                @PersonFirst                 = {person.PersonFirst},
                @PersonMI                    = {person.PersonMi},
                @PersonLast                  = {person.PersonLast},
                @PersonTypeID                = {person.PersonTypeId},
                @PersonType                  = NULL, -- Not used by the sproc.
                @OrganizationID              = {person.OrganizationId},
                @Organization                = NULL, -- Not used by the sproc.
                @PersonNotes                 = {person.PersonNotes},
                @PersonBusy                  = {person.PersonBusy},
                @Verified                    = {person.Verified},
                @Inactive                    = {person.Inactive},
                @LastModified                = {person.LastModified},
                @PersonBusyUntil             = {person.PersonBusyUntil},
                @PersonTempNoteActive        = {person.PersonTempNoteActive},
                @PersonTempNoteExpires       = {person.PersonTempNoteExpires},
                @PersonTempNote              = {person.PersonTempNote},
                @Unused                      = {person.Unused},
                @UpdatedFlag                 = {person.UpdatedFlag},
                @AllowInternetScheduleAccess = {person.AllowInternetScheduleAccess},
                @PersonSecurity              = {person.PersonSecurity},
                @PersonArchive               = {person.PersonArchive},
                @LastStatEmployeeID          = {person.LastStatEmployeeId},
                @AuditLogTypeID              = {person.AuditLogTypeId},
                @GenderID                    = {person.GenderId},
                @Gender                      = NULL, -- Not used by the sproc.
                @RaceID                      = {person.RaceId},
                @Race                        = NULL, -- Not used by the sproc.
                @Credential                  = {person.Credential},
                @TrainedRequestorID          = {person.TrainedRequestorId},
                @TrainedRequestor            = NULL -- Not used by the sproc.")
            .TagWithCallerName()
            .ToArrayAsync()
            .ConfigureAwait(false);

        var personInsertResult = createdPersonList.Single();

        person.PersonId = personInsertResult.PersonId;
    }

    // TODO: This is a good candidate for moving
    // to some common code.
    private static IQueryable<TItem> AddOrderingsToQuery<TItem>(
        IQueryable<TItem> query,
        (Expression<Func<TItem, object?>> OrderKeySelector, Ordering Ordering)[] orderingInfos)
    {
        if (orderingInfos.Any())
        {
            var orderInfo = orderingInfos[0];

            var orderedQuery = orderInfo.Ordering == Ordering.Ascending ?
                query.OrderBy(orderInfo.OrderKeySelector) :
                query.OrderByDescending(orderInfo.OrderKeySelector);

            for (int i = 1; i < orderingInfos.Length; i++)
            {
                orderInfo = orderingInfos[i];

                orderedQuery = orderInfo.Ordering == Ordering.Ascending ?
                    orderedQuery.ThenBy(orderInfo.OrderKeySelector) :
                    orderedQuery.ThenByDescending(orderInfo.OrderKeySelector);
            }

            query = orderedQuery;
        }

        return query;
    }
}
