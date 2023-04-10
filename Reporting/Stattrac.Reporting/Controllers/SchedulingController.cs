using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Stattrac.Reporting.Repository;

namespace Stattrac.Reporting.Controllers
{
    [Authorize]
    public class SchedulingController : Controller
    {
        private IDataProvider _dataProvider;
        private IEmailService _emailService;
        private Settings _settings;
        private ILogger<SchedulingController> _logger;

        public SchedulingController(IDataProvider dataProvider, IEmailService emailService,
            IOptions<Settings> settings, ILogger<SchedulingController> logger)
        {
            _dataProvider = dataProvider;
            _emailService = emailService;
            _settings = settings.Value;
            _logger = logger;
        }

        [Route("SchedulePeople")]
        [HttpGet]
        public async Task<IActionResult> GetSchedulePeople(int organizationId, int scheduleGroupId)
        {
            try
            {
                return Ok( await _dataProvider.GetSchedulePeopleDropDownList(organizationId, scheduleGroupId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.GetSchedulePeople:organizationId=" +
                    $"{organizationId}, scheduleGroupId={scheduleGroupId}");
                return BadRequest(ex.Message);
            }
        }

        [Route("Schedules")]
        [HttpGet]
        public async Task<IActionResult> GetSchedules(int organizationId, int scheduleGroupId, string startDt, string EndDt)
        {
            var canSchedule = HttpContext.User.Claims.First(c => c.Type == "CanSchedule").Value;
            if (canSchedule != "1")
            {
                return Unauthorized("You don't have access to schedules, please contact your system administrator.");
            }
            var timeZone = HttpContext.User.Claims.First(c => c.Type == "TimeZone").Value;
            try
            {
                return Ok(await _dataProvider.GetSchedules(organizationId, scheduleGroupId, startDt, EndDt, timeZone));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.GetSchedulePeople:organizationId=" +
                    $"{organizationId}, scheduleGroupId={scheduleGroupId}");
                return BadRequest(ex.Message);
            }
        }

        [Route("createschedule")]
        [HttpGet]
        public async Task<IActionResult> CreateSchedule(string shiftName, int scheduleGroupId,
            string startDt, string EndDt, 
            int? PersonId1, int? PersonId2, int? PersonId3, int? PersonId4, int? PersonId5,
            string repeatEnd, string weekDays)
        {
            var canSchedule = HttpContext.User.Claims.First(c => c.Type == "CanSchedule").Value;
            var webPersonId =int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
            if (canSchedule != "1")
            {
                return Unauthorized("You don't have access to schedules, please contact your system administrator.");
            }
            var timeZone = HttpContext.User.Claims.First(c => c.Type == "TimeZone").Value;
            try
            {
                return Ok(await _dataProvider.CreateSchedule(shiftName, scheduleGroupId, startDt, 
                    EndDt, timeZone, PersonId1, PersonId2, PersonId3, PersonId4, PersonId5, repeatEnd, weekDays, webPersonId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.CreateSchedule:shiftName=" +
                    $"{shiftName}, scheduleGroupId={scheduleGroupId}");
                return BadRequest(ex.Message);
            }
        }

        [Route("updateschedule")]
        [HttpGet]
        public async Task<IActionResult> UpdateSchedule(int scheduleItemID, string shiftName, int scheduleGroupId,
            string startDt, string EndDt,
            int? PersonId1, int? PersonId2, int? PersonId3, int? PersonId4, int? PersonId5)
        {
            var timeZone = HttpContext.User.Claims.First(c => c.Type == "TimeZone").Value;
            var webPersonId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
            try
            {
                return Ok(await _dataProvider.UpdateSchedule(scheduleItemID, shiftName, scheduleGroupId, startDt,
                    EndDt, timeZone, PersonId1, PersonId2, PersonId3, PersonId4, PersonId5, webPersonId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.CreateSchedule:shiftName=" +
                    $"{shiftName}, scheduleGroupId={scheduleGroupId}");
                return BadRequest(ex.Message);
            }
        }

        [Route("saveschedulechanges")]
        [HttpGet]
        public async Task<IActionResult> SaveChanges(string updates, string deletes)
        {
            try
            {
                var webPersonId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
                return Ok(await _dataProvider.SaveScheduleChanges(updates, deletes, webPersonId));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.SaveChanges:updates=" +
                    $"{updates}, deletes={deletes}");
                return BadRequest(ex.Message);
            }
        }

        [Route("shiftStatus")]
        [HttpGet]
        public async Task<IActionResult> ShiftStatus(int organizationId, int scheduleGroupId, 
            int? scheduleItemID, string startDt, string EndDt)
        {
            try
            {
                var timeZone = HttpContext.User.Claims.First(c => c.Type == "TimeZone").Value;
                var webPersonId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value);
                return Ok(await _dataProvider.ShiftStatus(organizationId,  scheduleGroupId,  scheduleItemID,
                     startDt, EndDt, timeZone));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.ShiftStatus:organizationId=" +
                    $"{organizationId}, scheduleGroupId={scheduleGroupId}, " +
                    $"startDt={startDt}, EndDt={EndDt}");
                return BadRequest(ex.Message);
            }
        }

        [Route("modifyScheduleLock")]
        [HttpGet]
        public async Task<IActionResult> ModifyScheduleLock(int scheduleGroupId, int lockType) //1 = delete, 0 = get
        {
            var statEmployeeId = int.Parse(HttpContext.User.Claims.First(c => c.Type == "StatEmployeeId").Value);
            try
            {
                var scheduleLock = await _dataProvider.ModifyScheduleLock(scheduleGroupId, statEmployeeId, lockType);
                if (lockType == 0 && scheduleLock.StatEmployeeId != statEmployeeId)
                {
                    return Unauthorized(); //schedule is locked by someone else
                }
                return Ok();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"SchedulingController.SetLock:statEmployeeId=" +
                    $"{statEmployeeId}, scheduleGroupId={scheduleGroupId}");
                return BadRequest(ex.Message);
            }
        }
    }
}
