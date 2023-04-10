using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Calls;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Enums;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Heartbeat;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.LogEvents;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Organizations;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Persons;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Referrals;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi
{
    internal interface IStatTracApiClient
    {
        Task<ApiHealthReport> GetApiHealthReportAsync(CancellationToken cancellationToken);

        Task<int> GetSourceCodeIdAsync(string sourceCode, CancellationToken cancellationToken);

        Task<ICollection<StatEmployee>> GetFilteredEmployeesAsync(
            string? firstName, 
            string? lastName,
            bool? inactive,
            CancellationToken cancellationToken);

        Task<ICollection<int>> GetFilteredPersonIdsOrderedAsync(
            PersonFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<Organization>> GetFilteredOrganizationsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<int>> GetFilteredOrganizationIdsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<SubLocation>> GetFilteredOrganizationSubLocationsAsync(
            int organizationId,
            SubLocationFilterCriteria filterCriteria,
            CancellationToken cancellationToken);

        Task<ICollection<int>> GetFilteredOrganizationPhoneIds(
            int organizationId,
            PhoneFilterCriteria filterCriteriaDto,
            CancellationToken cancellationToken);

        Task<ICollection<EnumValue>> GetAllCausesOfDeathAsync(
            CancellationToken cancellationToken);

        Task<ICollection<EnumValue>> GetAllRacesAsync(
            CancellationToken cancellationToken);

        Task<ICollection<int>> GetDuplicateReferralIdsAsync(
            DuplicateReferralsFilterCriteria filterCriteria, 
            CancellationToken cancellationToken);

        Task<int> AddLogEventAsync(
            NewLogEvent logEvent, 
            CancellationToken cancellationToken);

        Task<int> AddReferralAsync(
            NewReferral referral,
            CancellationToken cancellationToken);

        Task<int> AddCallAsync(
            NewCall newCall, 
            CancellationToken cancellationToken);
    }
}
