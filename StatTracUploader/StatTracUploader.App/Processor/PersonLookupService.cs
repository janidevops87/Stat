using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Common;
using Statline.StatTracUploader.Domain.Main.Persons;
using Statline.StatTracUploader.Domain.Temporary;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.App.Processor
{
    internal class PersonLookupService
    {
        private static readonly PersonName DefaultPersonName = new("StatTrac", "Uploader");

        private const int StatlineOrganizationId = 194;

        private readonly IPersonRepository personRepository;

        public PersonLookupService(IPersonRepository personRepository)
        {
            this.personRepository = Check.NotNull(personRepository, nameof(personRepository));
        }

        public async ValueTask<(int? Id, PersonName? Name)> GetCallerPersonOrDefaultPerson(
            Referral referral,
            ReferralExtraInfo referralExtraInfo,
            CancellationToken cancellationToken)
        {
            if (referralExtraInfo.CallerPersonId is not null)
            {
                return (referralExtraInfo.CallerPersonId, referral.CallerInformation.CallerName);
            }
            else
            {
                return await GetDefaultPersonAsync(cancellationToken);
            }
        }

        public async Task<(int? Id, PersonName? Name)> GetDefaultPersonAsync(
            CancellationToken cancellationToken)
        {
            var callerPersonId = await FindPersonAsync(
                DefaultPersonName,
                StatlineOrganizationId,
                cancellationToken);

            var callerPersonName = callerPersonId is null ? null : DefaultPersonName;

            return (callerPersonId, callerPersonName);
        }

        public async Task<int?> FindPersonAsync(
            PersonName personName,
            int organizationId,
            CancellationToken cancellationToken)
        {
            var personIds = await personRepository.GetFilteredPersonIdsOrderedAsync(
                new PersonFilterCriteria
                {
                    Name = personName,
                    Inactive = false,
                    OrganizationId = organizationId
                },
                cancellationToken).ConfigureAwait(false);

            return personIds.Count switch
            {
                0 => null,
                _ => personIds.First()
            };
        }

        public async Task<StatEmployee> GetEmployeeOrDefaultEmployeeAsync(
            PersonName employeeName,
            CancellationToken cancellationToken)
        {
            var candidateEmployees =
                await GetCandidateEmployeesAsync(employeeName, cancellationToken);

            if (candidateEmployees.Count == 1)
            {
                return candidateEmployees.First();
            }

            // If zero or multiple employees are found use default "StatTrac Uploader" employee.
            var defaultEmployee = await GetDefaultEmployeeAsync(cancellationToken);

            if (defaultEmployee is null)
            {
                throw new ReferralProcessingException(
                    $"Can't find an employee for name '{employeeName}', " +
                    $"and default employee '{DefaultPersonName}' doesn't exist.");
            }

            return defaultEmployee;
        }

        public async Task<StatEmployee?> GetDefaultEmployeeAsync(
            CancellationToken cancellationToken)
        {
            var candidateEmployees = await GetCandidateEmployeesAsync(
                    DefaultPersonName, cancellationToken);

            return candidateEmployees.FirstOrDefault();
        }

        private async Task<ICollection<StatEmployee>> GetCandidateEmployeesAsync(
            PersonName personName,
            CancellationToken cancellationToken)
        {
            return await personRepository.GetFilteredEmployeesAsync(
                                personName.FirstName,
                                personName.LastName,
                                inactive: false,
                                cancellationToken);
        }
    }
}
