using Stattrac.Reporting.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Repository
{
    public interface IDataProvider
    {
        public Task<List<Report>> GetReports(string userName);
        public Task<List<ReportDefaults>> GetReportDefaults(int reportId, int userOrganizationId, int webPersonId);
        public Task<WebPerson> GetUser(string userName);
        public Task<int> UpdatePassword(int webPersonId, string saltValue, string hashedPassword, DateTime passwordExpiration);
        public Task<List<ReportParameterControl>> GetReportParameterControls(int reportID);
        public Task<List<DropDownList>> GetReportDateTypeDropDownList(int reportID);
        public Task<List<DropDownList>> GetReportGroupDropDownList(int userOrgId);
        public Task<List<DropDownList>> GetReportOrganizationDropDownList(int reportGroupId, int? lastRowId, string searchterm);
        public Task<List<DropDownListStringId>> GetReportSourceCodeDropDownList(int webReportGroupId, int? sourceCodeTypeId);
        public Task<List<DropDownList>> GetReportCoordinatorDropDownList(int userOrgId, int webreportGroupId);
        public Task<List<DropDownListStringId>> GetSortTypeDropDownList(int reportID);
        public Task<List<DropDownList>> GetReferralTypeDropDownList(int reportGroupId, int? sourceCodeId);
        public Task<List<DropDownList>> GetCauseOfDeathDropDownList();
        public Task<List<DropDownList>> GetMonthDropDownList();
        public Task<List<DropDownList>> GetYearDropDownList();
        public Task<List<DropDownList>> GetOrganizationTypeDropDownList();
        public Task<List<DropDownList>> GetQATrackingTypeDropDownList(int organizationId);
        public Task<List<DropDownList>> GetAlertGroupDropDownList(int? alertTypeId, string sourceCodeName);
        public Task<List<DropDownList>> GetMessageImportOrganizationsDropDownList(string sourceCodeName, int? sourceCodeTypeId, int? organizationId);
        public Task<List<DropDownList>> GetPersonListByOrganizationDropDownList(int? organizationId, int? inactive);
        public Task<List<DropDownList>> GetStattracUserDropDownList(int? userOrgId, int? webReportGroupId);
        public Task<List<DropDownList>> GetPendingReferralTypeDropDownList(int reportGroupId);
        public Task<List<DropDownList>> GetScheduleOrganizationDropDownList(int organizationId);
        public Task<List<DropDownList>> GetSchedulePeopleDropDownList(int organizationId, int scheduleGroupId);
        public Task<int> CreateSchedule(string shiftName, int scheduleGroupId,
            string startDt, string EndDt, string timeZone,
            int? PersonId1, int? PersonId2, int? PersonId3, int? PersonId4, int? PersonId5,
            string repeatEnd, string weekDays, int webPersonId);

        public Task<int> UpdateSchedule(int scheduleItemID, string shiftName, int scheduleGroupId,
            string startDt, string EndDt, string timeZone,
            int? PersonId1, int? PersonId2, int? PersonId3, int? PersonId4, int? PersonId5, int webPersonId);

        public Task<int> SaveScheduleChanges(string updates, string deletes, int webPersonId);
        public Task<int> ShiftStatus(int organizationId, int scheduleGroupId, int? scheduleItemID, 
            string startDt, string EndDt, string timeZone);
        public Task<ScheduleLock> ModifyScheduleLock(int scheduleGroupId, int statEmployeeId, int scheduleLock);
        public Task<List<Schedule>> GetSchedules(int organizationId, int scheduleGroupId, string startDt, string EndDt, string timeZone);
        public Task<List<DropDownList>> GetScheduleGroupsDropDownList(int organizationId);
        public Task<List<DropDownList>> GetScreeningCriteriaOrganizationsDropDown();
        public Task<List<DropDownList>> GetScreeningCriteriaGroupsDropdownList(int organizationId);
        public Task<List<DropDownList>> GetApproachPersonDropDownList(int organizationId);
        public Task<List<DropDownList>> GetStateDropDownList();
        public Task<List<DropDownList>> GetOrganizationByStateAndTypeDropDownList(int? stateId, int? organizationTypeId);
        public Task<List<DropDownList>> GetEventMainCategoryDropDownList(string state);
        public Task<List<DropDownList>> GetEventSubCategoryDropDownList(int eventCategoryId, string state);
        
        public Task<List<ReportRecent>> GetRecentReports(int webPersonId);
        public Task<int> UpdateRecentReports(int webPersonId, int reportId);
        public Task<List<ReportFavorite>> GetFavoriteReports(int webPersonId);
        public Task<int> UpdateFavoriteReports(int reportID, int webPersonID, string sortReports);
        public Task<int> DeleteFavoriteReport(int reportID, int webPersonID);
        Task<List<RegistryState>> GetRegistryOwnerStates(int userOrgId, bool displayAllStates);
    }
}
