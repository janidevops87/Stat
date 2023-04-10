using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Stattrac.Reporting.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Repository
{
    public class EfProvider : IDataProvider
    {
        private readonly ReportDbContext _reportDbContext;
        private readonly RegistryDbContext _registryDbContext;
        private ILogger _logger;


        public EfProvider(ILogger<EfProvider> logger, ReportDbContext reportDbContext, RegistryDbContext registryDbContext)
        {
            _reportDbContext = reportDbContext;
            _registryDbContext = registryDbContext;
            _logger = logger;
        }

        public async Task<List<Report>> GetReports(string userName)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.Reports.FromSqlRaw(@"EXECUTE dbo.sps_ReportListByUser @UserName;", new SqlParameter("@UserName", userName)).ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReports:username={userName}");
                throw;
            }
        }

        public async Task<List<ReportDefaults>> GetReportDefaults(int reportId, int userOrganizationId, int webPersonId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportDefaults.FromSqlRaw(@"EXECUTE dbo.sps_ReportGetParameterDefaults @ReportId, @UserOrganizationId, @WebPersonId;",
                    new SqlParameter("@ReportID", reportId),
                    new SqlParameter("@UserOrganizationId", userOrganizationId),
                    new SqlParameter("WebPersonId", webPersonId)).ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportDefaults:reportId={reportId}, userOrganizationId={userOrganizationId}");
                throw;
            }
        }

        public async Task<WebPerson> GetUser(string userName)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.WebPerson
                    .FromSqlRaw(@"EXECUTE dbo.sps_GetWebPersonByUserName @UserName; ", new SqlParameter("@UserName", userName))?
                    .ToList().FirstOrDefault());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetUser:username={userName}");
                throw;
            }
        }


        public async Task<int> UpdatePassword(int webPersonId, string saltValue, string hashedPassword, DateTime passwordExpiration)
        {
            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE WebPersonPasswordUpdate @WebPersonId, @SaltValue, @HashedPassword, @PasswordExpiration;",
                    new SqlParameter("@SaltValue", saltValue),
                    new SqlParameter("@HashedPassword", hashedPassword),
                    new SqlParameter("@PasswordExpiration", passwordExpiration),
                    new SqlParameter("@WebPersonId", webPersonId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetUser:webPersonId={webPersonId}");
                throw;
            }
        }

        public async Task<List<ReportParameterControl>> GetReportParameterControls(int reportID)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ParameterControls
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportParametersByReport @ReportId;",
                    new SqlParameter("@ReportId", reportID))?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportParameterControls:reportID={reportID}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetReportDateTypeDropDownList(int reportID)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportDateTypeDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportDateTypeDropDown @ReportId;",
                    new SqlParameter("@ReportId", reportID))?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportDateTypeDropDownList:reportID={reportID}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetReportGroupDropDownList(int userOrgId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportGroupDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportGroupDropDown @UserOrgId;",
                    new SqlParameter("@UserOrgId", userOrgId))?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportGroupDropDownList:userOrgId={userOrgId}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetReportOrganizationDropDownList(int reportGroupId, int? lastRowId, string searchterm)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.ReportOrganizationDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportOrganizationDropDown @ReportGroupId, @LastRowId, @SearchTerm;",
                    new SqlParameter("@ReportGroupId", reportGroupId),
                    new SqlParameter("@LastRowId", lastRowId ?? 0),
                    new SqlParameter("@SearchTerm", (object)searchterm ?? DBNull.Value))?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportOrganizationDropDownList:reportGroupId={reportGroupId}");
                throw;
            }
        }

        public async Task<List<DropDownListStringId>> GetReportSourceCodeDropDownList(int webReportGroupId, int? sourceCodeTypeId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.ReportSourceCodeDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportSourceCodeDropDown @WebReportGroupId, @SourceCodeTypeId;",
                    new SqlParameter("@WebReportGroupId", webReportGroupId),
                    new SqlParameter("@SourceCodeTypeId", (object)sourceCodeTypeId ?? DBNull.Value) { IsNullable = true })?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportSourceCodeDropDownList:webReportGroupId={webReportGroupId}, sourceCodeTypeId={sourceCodeTypeId?.ToString()}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetReportCoordinatorDropDownList(int userOrgId, int webreportGroupId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportCoordinatorDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportCoordinatorDropDown @UserOrgId, @webReportGroupId;",
                    new SqlParameter("@UserOrgId", userOrgId),
                    new SqlParameter("@webReportGroupId", webreportGroupId))?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReportCoordinatorDropDownList:userOrgId={userOrgId}, webreportGroupId={webreportGroupId}");
                throw;
            }
        }

        public async Task<List<DropDownListStringId>> GetSortTypeDropDownList(int reportID)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.SortTypeDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportSortTypeDropDown @ReportId;",
                    new SqlParameter("@ReportId", reportID))?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetSortTypeDropDownList:reportID={reportID}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetReferralTypeDropDownList(int reportGroupId, int? sourceCodeId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.GetReferralTypeDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportReferralTypeDropDown @ReportGroupID, @SourceCodeID;",
                    new SqlParameter("@ReportGroupID", reportGroupId),
                    new SqlParameter("@SourceCodeID", (object)sourceCodeId ?? DBNull.Value) { IsNullable = true })?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetReferralTypeDropDownList:reportGroupId={reportGroupId}, sourceCodeId={sourceCodeId}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetCauseOfDeathDropDownList()
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportCauseOfDeathDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportCauseOfDeathDropDown;")?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetCauseOfDeathDropDownList");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetMonthDropDownList()
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportMonthDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportMonthDropDown;")?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetMonthDropDownList");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetYearDropDownList()
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportYearDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportYearDropDown;")?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetYearDropDownList");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetOrganizationTypeDropDownList()
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportOrganizationTypeDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportOrganizationTypeDropDown;")?.ToList());

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetOrganizationTypeDropDownList");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetQATrackingTypeDropDownList(int organizationId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportQATrackingTypeDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportQATrackingTypeDropDown @OrganizationId;",
                    new SqlParameter("@OrganizationId", organizationId))?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetQATrackingTypeDropDownList:organizationId={organizationId}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetAlertGroupDropDownList(int? alertTypeId, string sourceCodeName)
        {
            try
            {
                SqlParameter alert = new SqlParameter("@AlertTypeId", (object)alertTypeId ?? DBNull.Value) { IsNullable = true };
                SqlParameter source = new SqlParameter("@SourceCodeName", (object)sourceCodeName ?? DBNull.Value) { IsNullable = true };

                return await Task.Run(() => _reportDbContext.ReportAlertGroupDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportAlertGroupDropDown @AlertTypeId, @SourceCodeName;",
                    alert, source)?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetAlertGroupDropDownList:alertTypeId={alertTypeId?.ToString()},sourceCodeName={sourceCodeName}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetMessageImportOrganizationsDropDownList(string sourceCodeName, int? sourceCodeTypeId, int? organizationId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.MessageImportOrganizationsDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportMessageImportOrganizationsDropDown @SourceCodeName, @SourceCodeTypeId, @OrganizationId;",
                    new SqlParameter("@SourceCodeName", (object)sourceCodeName ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@SourceCodeTypeId", (object)sourceCodeTypeId ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@OrganizationId", (object)organizationId ?? DBNull.Value) { IsNullable = true }
                    )?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetMessageImportOrganizationsDropDownList:organizationId={organizationId?.ToString()},sourceCodeName={sourceCodeName},sourceCodeTypeId={sourceCodeTypeId?.ToString()}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetPersonListByOrganizationDropDownList(int? organizationId, int? inactive)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.PersonListByOrganizationDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportPersonListByOrganizationDropDown @OrganizationId, @Inactive;",
                    new SqlParameter("@OrganizationId", (object)organizationId ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@Inactive", (object)inactive ?? DBNull.Value) { IsNullable = true }
                    )?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetMessageImportOrganizationsDropDownList:organizationId={organizationId},inactive={inactive?.ToString()}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetStattracUserDropDownList(int? userOrgId, int? webReportGroupId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.StattracUserDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportStatTracUserDropDown @UserOrgID, @webReportGroupID;",
                    new SqlParameter("@UserOrgID", (object)userOrgId ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@webReportGroupID", (object)webReportGroupId ?? DBNull.Value) { IsNullable = true }
                    )?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetStattracUserDropDownList:userOrgId={userOrgId?.ToString()},webReportGroupId={webReportGroupId?.ToString()}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetPendingReferralTypeDropDownList(int reportGroupId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetPendingReferralTypeDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportPendingReferralTypeDropDown @ReportGroupID;",
                    new SqlParameter("@ReportGroupID", reportGroupId)
                    )?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetPendingReferralTypeDropDownList:userOrgId={reportGroupId}");
                throw;
            }
        }
        public async Task<List<DropDownList>> GetScheduleOrganizationDropDownList(int organizationId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetScheduleOrganizationDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportScheduleOrganizationDropDown @OrganizationId;",
                    new SqlParameter("@OrganizationId", organizationId)
                    )?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<DropDownList>> GetScheduleGroupsDropDownList(int organizationId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetScheduleGroupsDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportScheduleGroupsDropDown @OrganizationId;",
                    new SqlParameter("@OrganizationId", organizationId)
                    )?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<DropDownList>> GetScreeningCriteriaOrganizationsDropDown()
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetScreeningCriteriaOrganizationsDropDown
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportScreeningCriteriaOrganizationsDropDown;")?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<DropDownList>> GetScreeningCriteriaGroupsDropdownList(int organizationId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetScreeningCriteriaGroupsDropdownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportScreeningCriteriaGroupsDropDown @OrganizationId;",
                    new SqlParameter("@OrganizationId", organizationId))?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<DropDownList>> GetSchedulePeopleDropDownList(int organizationId, int scheduleGroupId)
        {
            try
            {
                return await _reportDbContext.GetSchedulePeopleDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_Portal_SchedulePersonDropDown @OrganizationID, @ScheduleGroupID",
                    new SqlParameter("@OrganizationId", organizationId),
                    new SqlParameter("@ScheduleGroupID", scheduleGroupId)
                    )?.ToListAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetSchedulePeopleDropDownList {organizationId},{scheduleGroupId},");
                throw;
            }
        }

        public async Task<List<Schedule>> GetSchedules(int organizationId, int scheduleGroupId, string startDt, string EndDt, string timeZone)
        {
            try
            {
                var ret = _reportDbContext.GetSchedules
                    .FromSqlRaw(@"EXECUTE dbo.sps_Portal_GetSchedule @UserOrganizationID, @ScheduleGroupID, @StartDateTime, @EndDateTime, @TimeZone",
                    new SqlParameter("@UserOrganizationID", organizationId),
                    new SqlParameter("@ScheduleGroupID", scheduleGroupId),
                    new SqlParameter("@StartDateTime", DateTime.Parse(startDt)),
                    new SqlParameter("@EndDateTime", DateTime.Parse(EndDt)),
                    new SqlParameter("@TimeZone", timeZone)
                    );
                return await ret.ToListAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetSchedules {organizationId},{scheduleGroupId},{startDt},{EndDt},{timeZone}");
                throw;
            }
        }
        public async Task<List<DropDownList>> GetApproachPersonDropDownList(int organizationId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetApproachPersonDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportApproachPersonDropDown @OrganizationId;",
                    new SqlParameter("@OrganizationId", organizationId)
                    )?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<DropDownList>> GetStateDropDownList()
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetStateDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportStateDropDown;"
                    )?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<DropDownList>> GetOrganizationByStateAndTypeDropDownList(int? stateId, int? organizationTypeId)
        {
            try
            {

                return await Task.Run(() => _reportDbContext.GetOrganizationByStateAndTypeDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportOrgByStateAndTypeDropDown @StateId, @OrganizationTypeId;",
                    new SqlParameter("@StateId", (object)stateId ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@OrganizationTypeId", (object)organizationTypeId ?? DBNull.Value) { IsNullable = true }
                    )?.ToList());
            }
            catch
            {
                throw;
            }
        }

        public async Task<List<ReportRecent>> GetRecentReports(int webPersonId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportRecents
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportRecent @WebPersonId;",
                    new SqlParameter("@WebPersonId", webPersonId))?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetRecentReports:webPersonId={webPersonId}");
                throw;
            }
        }

        public async Task<int> UpdateRecentReports(int webPersonId, int reportId)
        {
            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE dbo.spu_ReportRecent @WebPersonID, @ReportID;",
                    new SqlParameter("@WebPersonID", webPersonId),
                    new SqlParameter("@ReportID", reportId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"UpdateRecentReports:webPersonId={webPersonId}, reportId={reportId}");
                throw;
            }
        }

        public async Task<List<ReportFavorite>> GetFavoriteReports(int webPersonId)
        {
            try
            {
                return await Task.Run(() => _reportDbContext.ReportFavorites
                    .FromSqlRaw(@"EXECUTE sps_ReportFavorite @WebPersonId;",
                    new SqlParameter("@WebPersonId", webPersonId))?.ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"GetFavoriteReports:webPersonId={webPersonId}");
                throw;
            }
        }
        public async Task<int> UpdateFavoriteReports(int reportID, int webPersonID, string sortReports)
        {
            var reportIdParam = new SqlParameter("@ReportID", reportID);
            if (reportID == 0)
                reportIdParam.Value = DBNull.Value;

            var sortReportsParam = new SqlParameter("@SortReports", sortReports);
            if (sortReports == null)
                sortReportsParam.Value = DBNull.Value;

            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE dbo.spu_ReportFavorite @WebPersonID, @ReportID, @SortReports;",
                    new SqlParameter("@WebPersonID", webPersonID),
                    reportIdParam, sortReportsParam);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"UpdateFavoriteReports:reportID={reportID}, webPersonId ={webPersonID}, sortReports={sortReports}");
                throw;
            }
        }
        public async Task<int> DeleteFavoriteReport(int reportID, int webPersonID)
        {
            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE dbo.spd_ReportFavorite @WebPersonID, @ReportID ",
                    new SqlParameter("@ReportID", reportID),
                    new SqlParameter("@WebPersonID", webPersonID)
                    );
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"DeleteFavoriteReport:reportID={reportID}, webPersonId ={webPersonID}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetEventMainCategoryDropDownList(string state)
        {
            try
            {

                return await Task.Run(() => _registryDbContext.GetEventMainCategoryDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportEventMainCategoryDropDown @State;",
                    new SqlParameter("@State", state)
                    )?.ToList());
            }
            catch(Exception ex)
            {
                _logger.LogError(ex, $"GetEventMainCategoryDropDownList:state={state}");
                throw;
            }
        }

        public async Task<List<DropDownList>> GetEventSubCategoryDropDownList(int eventCategoryId, string state)
        {
            try
            {

                return await Task.Run(() => _registryDbContext.GetEventSubCategoryDropDownList
                    .FromSqlRaw(@"EXECUTE dbo.sps_ReportEventSubCategoryDropDown @EventCategoryId, @State;",
                    new SqlParameter("@EventCategoryId", eventCategoryId),
                    new SqlParameter("@State", state)
                    )?.ToList());
            }
            catch(Exception ex)
            {
                _logger.LogError(ex, $"GetEventSubCategoryDropDownList:eventCategoryId={eventCategoryId}, state ={state}");
                throw;
            }
        }

        public async Task<List<RegistryState>> GetRegistryOwnerStates(int userOrgId, bool displayAllStates)
        {
            try
            {

                return await Task.Run(() => _registryDbContext.GetRegistryOwnerStates
                    .FromSqlRaw(@"EXECUTE dbo.GetRegistryOwnerStateForReportPortal @UserOrgID, @DisplayAllStates;",
                    new SqlParameter("@UserOrgID", userOrgId),
                    new SqlParameter("@DisplayAllStates", displayAllStates)
                    )?.ToList());
            }
            catch(Exception ex)
            {
                _logger.LogError(ex, $"GetRegistryOwnerStates:userOrgId={userOrgId}, displayAllStates ={displayAllStates}");
                throw;
            }
        }


        public async Task<int> CreateSchedule(string shiftName, int scheduleGroupId,
            string startDt, string EndDt, string timeZone,
            int? PersonId1, int? PersonId2, int? PersonId3, int? PersonId4, int? PersonId5,
            string repeatEnd, string weekDays, int webPersonId)
        {
            var arr = weekDays.ToCharArray();
            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE dbo.Portal_ScheduleCreateShift  @ScheduleItemID,
                        @ScheduleGroupID, @ScheduleItemName,@ScheduleItemStartDate,
                        @ScheduleItemEndDate, @TimeZone, @PersonId1, @PersonId2, 
                        @PersonId3, @PersonId4, @PersonId5, @RepeatShiftEndDate,
                        @RepeatMonday, @RepeatTuesday, @RepeatWednesday, @RepeatThursday,
                        @RepeatFriday, @RepeatSaturday, @RepeatSunday, @WebPersonId",
                    new SqlParameter("@ScheduleItemID", DBNull.Value),
                    new SqlParameter("@ScheduleGroupID", scheduleGroupId),
                    new SqlParameter("@ScheduleItemName", shiftName),
                    new SqlParameter("@ScheduleItemStartDate", DateTime.Parse(startDt)),
                    new SqlParameter("@ScheduleItemEndDate", DateTime.Parse(EndDt)),
                    new SqlParameter("@TimeZone", timeZone),
                    new SqlParameter("@PersonId1", (object)PersonId1 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId2", (object)PersonId2 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId3", (object)PersonId3 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId4", (object)PersonId4 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId5", (object)PersonId5 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@RepeatShiftEndDate", (object)repeatEnd ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@RepeatMonday", arr[1]),
                    new SqlParameter("@RepeatTuesday", arr[2]),
                    new SqlParameter("@RepeatWednesday", arr[3]),
                    new SqlParameter("@RepeatThursday", arr[4]),
                    new SqlParameter("@RepeatFriday", arr[5]),
                    new SqlParameter("@RepeatSaturday", arr[6]),
                    new SqlParameter("@RepeatSunday", arr[0]),
                    new SqlParameter("@WebPersonId", webPersonId)
                    );
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "EF:CreateSchedule");
                throw;
            }
        }

        public async Task<int> UpdateSchedule(int scheduleItemID, string shiftName, int scheduleGroupId,
            string startDt, string EndDt, string timeZone,
            int? PersonId1, int? PersonId2, int? PersonId3, int? PersonId4, int? PersonId5, int webPersonId)
        {
            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE Portal_ScheduleInsertUpdate  @ScheduleItemID,
                        @ScheduleGroupID, @ScheduleItemName,@ScheduleItemStartDate,
                        @ScheduleItemEndDate, @TimeZone, @PersonId1, @PersonId2, 
                        @PersonId3, @PersonId4, @PersonId5, @WebPersonId",
                    new SqlParameter("@ScheduleItemID", scheduleItemID),
                    new SqlParameter("@ScheduleGroupID", scheduleGroupId),
                    new SqlParameter("@ScheduleItemName", shiftName),
                    new SqlParameter("@ScheduleItemStartDate", DateTime.Parse(startDt)),
                    new SqlParameter("@ScheduleItemEndDate", DateTime.Parse(EndDt)),
                    new SqlParameter("@TimeZone", timeZone),
                    new SqlParameter("@PersonId1", (object)PersonId1 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId2", (object)PersonId2 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId3", (object)PersonId3 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId4", (object)PersonId4 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@PersonId5", (object)PersonId5 ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@WebPersonId", webPersonId)
                    );
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "EF:CreateSchedule");
                throw;
            }
        }

        public async Task<int> SaveScheduleChanges(string updates, string deletes, int webPersonId)
        {
            try
            {
                return await _reportDbContext.Database.ExecuteSqlRawAsync(
                    @"EXECUTE Portal_SaveScheduleChanges @updates, @deletes, @WebPersonId",
                    new SqlParameter("@updates", (object)updates ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@deletes", (object)deletes ?? DBNull.Value) { IsNullable = true },
                    new SqlParameter("@WebPersonId", webPersonId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "EF: SaveChanges");
                throw;
            }
        }
        public async Task<int> ShiftStatus(int organizationId, int scheduleGroupId, 
            int? scheduleItemID, string startDt, string EndDt, string timeZone)
        {
            try
            {
                var ret =  await _reportDbContext.ShiftStatus.FromSqlRaw(
                    @"EXECUTE Portal_CheckForOverlapsAndGaps @OrganizationID, 
                        @ScheduleGroupID, @StartDateTime, @EndDateTime, 
                        @TimeZone, @ScheduleItemId",
                    new SqlParameter("@OrganizationId", organizationId),
                    new SqlParameter("@ScheduleGroupID", scheduleGroupId),
                    new SqlParameter("@StartDateTime", DateTime.Parse(startDt)),
                    new SqlParameter("@EndDateTime", DateTime.Parse(EndDt)),
                    new SqlParameter("@TimeZone", timeZone),
                    new SqlParameter("@ScheduleItemID", (object)scheduleItemID ?? DBNull.Value))?.ToListAsync();
                if (ret == null || ret.Count == 0)
                    ret = new List<ShiftStatusContainer> { new ShiftStatusContainer { ShiftStatus = 0 } };
                return ret[0].ShiftStatus;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "EF: ShiftStatus");
                throw;
            }
        }

        public async Task<ScheduleLock> ModifyScheduleLock( int scheduleGroupId, int statEmployeeId, int scheduleLock)
        {
            try
            {
                var ret = await _reportDbContext.GetScheduleLock.FromSqlRaw(
                    @"EXECUTE UpdateScheduleLock @ScheduleGroupID, @StatEmployeeId, @RemoveLock",
                    new SqlParameter("@ScheduleGroupID", scheduleGroupId),
                    new SqlParameter("@StatEmployeeId", statEmployeeId),
                    new SqlParameter("@RemoveLock", scheduleLock))?.ToListAsync();
                return ret[0];
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "EF: ModifyScheduleLock");
                throw;
            }
        }
    }
}
