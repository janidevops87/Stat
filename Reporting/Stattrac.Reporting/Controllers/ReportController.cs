using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stattrac.Reporting.Repository;
using SsrsWcf;
using System.Net;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using System.Linq;
using Stattrac.Reporting.Models;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Runtime.Caching;
using System;

namespace Stattrac.Reporting.Controllers
{
    [Authorize(AuthenticationSchemes = CookieAuthenticationDefaults.AuthenticationScheme)]
    public class ReportController : Controller
    {
        private IDataProvider _dataProvider;
        private Settings _settings;
        private ILogger<ReportController> _logger;
        private static ObjectCache cache = System.Runtime.Caching.MemoryCache.Default;

        public ReportController(IDataProvider dataProvider, IOptions<Settings> settings,
            ILogger<ReportController> logger)
        {
            _dataProvider = dataProvider;
            _settings = settings.Value;
            _logger = logger;
        }
        [Route("report")]
        [HttpPost]
        public async Task<IActionResult> GetReport([FromBody] ReportModel reportModel)
        {
            try
            {
                EndpointAddress rsEndpointAddress = new EndpointAddress(_settings.Ssrs.EndPoint);
                BasicHttpBinding rsBinding = new BasicHttpBinding();
                rsBinding.Security.Mode = BasicHttpSecurityMode.Transport;
                rsBinding.Security.Transport.ClientCredentialType = HttpClientCredentialType.Windows;
                rsBinding.MaxReceivedMessageSize = 100000000;
                rsBinding.OpenTimeout = new System.TimeSpan(0, 10, 0);
                rsBinding.ReceiveTimeout = new System.TimeSpan(0, 10, 0);
                rsBinding.SendTimeout = new System.TimeSpan(0, 10, 0);
                var rsExec = new ReportExecutionServiceSoapClient(rsBinding, rsEndpointAddress);

                NetworkCredential clientCredentials = new NetworkCredential(_settings.Ssrs.UserName, _settings.Ssrs.Password, _settings.Ssrs.Domain);
                rsExec.ClientCredentials.Windows.AllowedImpersonationLevel = System.Security.Principal.TokenImpersonationLevel.Impersonation;
                rsExec.ChannelFactory.Credentials.Windows.ClientCredential = clientCredentials;

                rsExec.Endpoint.EndpointBehaviors.Add(new ReportingServiceEndPointBehavior());
                string historyID = null;

                TrustedUserHeader trustedUserHeader = null;// new TrustedUserHeader();
                ExecutionHeader execHeader = new ExecutionHeader();

                //var extensions = await rsExec.ListRenderingExtensionsAsync(trustedUserHeader);
                Dictionary<string, string> params1 = new Dictionary<string, string>();
                string[] temp = reportModel.Parameters.Split('|');
                for (int j = 0; j < temp.Length; j++)
                {
                    string[] temp2 = temp[j].Split('=');
                    params1.Add(temp2[0], temp2[1]);
                }
                LoadReportResponse taskLoadReport = await rsExec.LoadReportAsync(trustedUserHeader, reportModel.ReportUrl, historyID);
                execHeader.ExecutionID = taskLoadReport.executionInfo.ExecutionID;
                //set to start at beginning of array
                ParameterValue[] parameters = new ParameterValue[params1.Count];
                int i = 0;
                //parameters
                foreach (ReportParameter pm in taskLoadReport.executionInfo.Parameters)
                {
                    if (params1.ContainsKey(pm.Name) && !string.IsNullOrWhiteSpace(params1[pm.Name].ToString()))
                    {
                        parameters[i] = new ParameterValue();
                        parameters[i].Name = pm.Name;
                        parameters[i].Value = params1[pm.Name].ToString();
                        i++;
                    }
                }

                await rsExec.SetExecutionParametersAsync(execHeader, trustedUserHeader, parameters, "en-us");

                if (taskLoadReport.executionInfo != null)
                {
                    execHeader.ExecutionID = taskLoadReport.executionInfo.ExecutionID;
                }

                string deviceInfo = null;

                RenderRequest renderReq = new RenderRequest(execHeader, trustedUserHeader, reportModel.Format, deviceInfo);
                RenderResponse taskRender = await rsExec.RenderAsync(renderReq);

                if (taskRender.Result != null)
                {
                    if (reportModel.Format.ToUpper() == "MHTML")
                    {
                        string mhtml = Encoding.UTF8.GetString(taskRender.Result, 0, taskRender.Result.Length);
                        MHTMLParser parser = new MHTMLParser(mhtml);
                        string converted = parser.getHTMLText();
                        return Content(converted);
                    }
                    else
                    {
                        return File(taskRender.Result, "application/octet-stream");
                    }
                }
                else
                {
                    return Content("Error generating report.");
                }
            }
            catch (System.Exception ex)
            {
                _logger.LogError(ex, $"Report Render By:{HttpContext.User.Identity.Name}", null);
                string errorMessage = ex.Message;
                while (ex.InnerException != null)
                {
                    ex = ex.InnerException;
                    errorMessage += " *** " + ex.Message;
                }
                return BadRequest(errorMessage);
            }
        }

        [Route("userreports")]
        public async Task<IActionResult> GetUserReports()
        {
            return Ok(await _dataProvider.GetReports(HttpContext.User.Identity.Name));
        }

        [Route("reportdefaults")]
        public async Task<IActionResult> GetReportDefaults(int reportId, int userOrganizationId, int webPersonId)
        {
            return Ok(await _dataProvider.GetReportDefaults(reportId, userOrganizationId, webPersonId));
        }

        [Route("reportParametersControl")]
        public async Task<IActionResult> GetreportParameters(int reportID)
        {
            return Ok(await _dataProvider.GetReportParameterControls(reportID));
        }

        [Route("DateTypeDropdown")]
        public async Task<IActionResult> GetDateTypeDropwDownList(int reportID)
        {
            return Ok(await _dataProvider.GetReportDateTypeDropDownList(reportID));
        }

        [Route("ReportGroupDropdown")]
        public async Task<IActionResult> GetReportGroupDropDownList(int userOrganizationId)
        {
            return Ok(await _dataProvider.GetReportGroupDropDownList(userOrganizationId));
        }

        [Route("ReportOrganizationDropdown")]
        public async Task<IActionResult> GetReportOrganizationDropDownList(int reportGroupId, int? lastRowId, string searchterm)
        {
            return Ok(await _dataProvider.GetReportOrganizationDropDownList(reportGroupId, lastRowId, searchterm));
        }

        [Route("ReportSourceCodeDropdown")]
        public async Task<IActionResult> GetReportSourceCodeDropDownList(int webReportGroupId, int? sourceCodeTypeId)
        {
            return Ok(await _dataProvider.GetReportSourceCodeDropDownList(webReportGroupId, sourceCodeTypeId));
        }

        [Route("ReportCoordinatorDropdown")]
        public async Task<IActionResult> GetReportCoordinatorDropDownList(int userOrganizationId, int webreportGroupId)
        {
            return Ok(await _dataProvider.GetReportCoordinatorDropDownList(userOrganizationId, webreportGroupId));
        }

        [Route("ReportSortTypeDropdown")]
        public async Task<IActionResult> GetReportSortTypeDropDownList(int reportID)
        {
            return Ok(await _dataProvider.GetSortTypeDropDownList(reportID));
        }

        [Route("ReferralTypeDropdown")]
        public async Task<IActionResult> GetReferralTypeDropDownList(int reportGroupId, int? sourceCodeId)
        {
            return Ok(await _dataProvider.GetReferralTypeDropDownList(reportGroupId, sourceCodeId));
        }
        [Route("CauseOfDeathDropdown")]
        public async Task<IActionResult> GetCauseOfDeathDropDownList()
        {
            return Ok(await _dataProvider.GetCauseOfDeathDropDownList());
        }

        [Route("MonthDropdown")]
        public async Task<IActionResult> GetMonthDropDownList()
        {
            return Ok(await _dataProvider.GetMonthDropDownList());
        }

        [Route("YearDropdown")]
        public async Task<IActionResult> GetYearDropDownList()
        {
            return Ok(await _dataProvider.GetYearDropDownList());
        }

        [Route("OrganizationTypeDropdown")]
        public async Task<IActionResult> GetOrganizationTypeDropDownList()
        {
            return Ok(await _dataProvider.GetOrganizationTypeDropDownList());
        }

        [Route("QATrackingTypeDropdown")]
        public async Task<IActionResult> GetQATrackingTypeDropDownList(int organizationId)
        {
            return Ok(await _dataProvider.GetQATrackingTypeDropDownList(organizationId));
        }

        [Route("AlertGroupDropdown")]
        public async Task<IActionResult> GetAlertGroupDropDownList(int? alertTypeId, string sourceCodeName)
        {
            return Ok(await _dataProvider.GetAlertGroupDropDownList(alertTypeId, sourceCodeName));
        }

        [Route("RecentReports")]
        public async Task<IActionResult> GetRecentReports()
        {
            return Ok(await _dataProvider.GetRecentReports(int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value)));
        }

        [Route("UpdateRecentReports")]
        public async Task<IActionResult> UpdateRecentReports(int reportId)
        {
            var webPersonId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
            return Ok(await _dataProvider.UpdateRecentReports(webPersonId, reportId));
        }

        [Route("FavoriteReports")]
        public async Task<IActionResult> GetFavoriteReports()
        {
            return Ok(await _dataProvider.GetFavoriteReports(int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value)));
        }

        [Route("UpdateFavoriteReports")]
        [HttpGet]
        public async Task<IActionResult> UpdateFavoriteReports(int reportID, string sortReports)
        {
            var webPersonId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
            return Ok(await _dataProvider.UpdateFavoriteReports(reportID, webPersonId, sortReports));
        }

        [Route("DeleteFavoriteReport")]
        [HttpGet]
        public async Task<IActionResult> DeleteFavoriteReport(int reportID)
        {
            var webPersonId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
            return Ok(await _dataProvider.DeleteFavoriteReport(reportID, webPersonId));
        }

        [Route("MessageImportOrganizationsDropDown")]
        public async Task<IActionResult> MessageImportOrganizationsDropDown(string sourceCodeName, int? sourceCodeTypeId, int? organizationId)
        {
            return Ok(await _dataProvider.GetMessageImportOrganizationsDropDownList(sourceCodeName, sourceCodeTypeId, organizationId));
        }

        [Route("PersonListByOrganizationDropDown")]
        public async Task<IActionResult> PersonListByOrganizationDropDown(int? organizationId, int? inactive)
        {
            return Ok(await _dataProvider.GetPersonListByOrganizationDropDownList(organizationId, inactive));
        }

        [Route("StatTracUserDropDown")]
        public async Task<IActionResult> StatTracUserDropDown(int? userOrgId, int? reportGroupId)
        {
            return Ok(await _dataProvider.GetStattracUserDropDownList(userOrgId, reportGroupId));
        }

        [Route("PendingReferralTypeDropDown")]
        public async Task<IActionResult> PendingReferralTypeDropDown(int reportGroupId)
        {
            return Ok(await _dataProvider.GetPendingReferralTypeDropDownList(reportGroupId));
        }

        [Route("ScheduleOrganizationsDropdown")]
        public async Task<IActionResult> GetScheduleOrganizationsDropDownList(int organizationId)
        {
            return Ok(await _dataProvider.GetScheduleOrganizationDropDownList(organizationId));
        }

        [Route("ScreeningCriteriaGroupsDropdown")]
        public async Task<IActionResult> GetScreeningCriteriaGroupsDropdownList(int organizationId)
        {
            return Ok(await _dataProvider.GetScreeningCriteriaGroupsDropdownList(organizationId));
        }

        [Route("ScreeningCriteriaOrganizationsDropDown")]
        public async Task<IActionResult> GetScreeningCriteriaOrganizationsDropDown()
        {
            return Ok(await _dataProvider.GetScreeningCriteriaOrganizationsDropDown());
        }



        [Route("ScheduleGroupsDropdown")]
        public async Task<IActionResult> GetScheduleGroupsDropDownList(int organizationId)
        {
            return Ok(await _dataProvider.GetScheduleGroupsDropDownList(organizationId));
        }

        [Route("ApproacherPersonDropDown")]
        public async Task<IActionResult> ApproacherPersonDropDown(int organizationId)
        {
            return Ok(await _dataProvider.GetApproachPersonDropDownList(organizationId));
        }

        [Route("StateDropDown")]
        public async Task<IActionResult> StateDropDown()
        {
            return Ok(await _dataProvider.GetStateDropDownList());
        }

        [Route("OrganizationByStateAndTypeDropDown")]
        public async Task<IActionResult> OrganizationByStateAndTypeDropDown(int? stateId, int? organizationTypeId)
        {
            return Ok(await _dataProvider.GetOrganizationByStateAndTypeDropDownList(stateId, organizationTypeId));
        }

        [Route("EventMainCategoryDropDownList")]
        public async Task<IActionResult> EventMainCategoryDropDownList(string state)
        {
            return Ok(await _dataProvider.GetEventMainCategoryDropDownList(state));
        }

        [Route("EventSubCategoryDropDownList")]
        public async Task<IActionResult> EventSubCategoryDropDownList(int eventCategoryId, string state)
        {
            return Ok(await _dataProvider.GetEventSubCategoryDropDownList(eventCategoryId,state));
        }

        [Route("RegistryOwnerStates")]
        public async Task<IActionResult> RegistryOwnerStates(int userOrgId, bool displayAllStates)
        {
            return Ok(await _dataProvider.GetRegistryOwnerStates(userOrgId, displayAllStates));
        }

        [Route("saveparams")]
        public async Task<IActionResult> SetReportParameters(string paramsId, string reportModel)
        {
            if (String.IsNullOrWhiteSpace(paramsId) || String.IsNullOrWhiteSpace(reportModel))
                return BadRequest("Invalid parameters");
            CacheItemPolicy cacheItemPolicy = new CacheItemPolicy();
            cacheItemPolicy.SlidingExpiration = TimeSpan.FromDays(1);
            cache.Set(HttpContext.User.Identity.Name + paramsId, reportModel, cacheItemPolicy);
            return Ok();

        }
        [Route("getparams")]
        public async Task<IActionResult> GetReportParameters(string paramsId)
        {
            if (cache.Get(HttpContext.User.Identity.Name + paramsId) == null)
                return NotFound("This report page is not valid anymore, please close this and re-run the report.");
            return Ok(cache.Get(HttpContext.User.Identity.Name + paramsId)?.ToString());
        }
    }
}