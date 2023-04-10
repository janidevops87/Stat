using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Stattrac.Reporting.Models;
using Stattrac.Reporting.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Controllers
{
    [AllowAnonymous]
    public class LoginController : Controller
    {
        private IDataProvider _dataProvider;
        private IEmailService _emailService;
        private Settings _settings;
        private ILogger<LoginController> _logger;

        public LoginController(IDataProvider dataProvider, IEmailService emailService, 
            IOptions<Settings> settings, ILogger<LoginController> logger)
        {
            _dataProvider = dataProvider;
            _emailService = emailService;
            _settings = settings.Value;
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        [Route("login")]
        [HttpPost]
        public async Task<IActionResult> Login([FromBody] dynamic data)
        {
            var json = JsonConvert.DeserializeObject(data.ToString());
            var username = json.username.ToString().Replace("{", "").Replace("}", "");
            var password = json.password.ToString().Replace("{", "").Replace("}", "");

            bool authenticated = false;
            try
            {

                WebPerson user = await _dataProvider.GetUser(username);

                string saltValue = string.Empty;
                string hashedPassword = string.Empty;

                if (user != null)
                {
                    saltValue = user.SaltValue ?? string.Empty;
                    hashedPassword = user.HashedPassword ?? string.Empty;

                    if (hashedPassword != null)
                    {
                        string targetPassword = Security.CreatePasswordHash(String.Concat(password, saltValue));
                        if (hashedPassword.Equals(targetPassword))
                        {
                            if (user.PasswordExpiration < DateTime.UtcNow)
                            {
                                string generatedToken = PasswordResetHelper.GenerateToken();
                                PasswordResetHelper.Add(username, generatedToken);
                                var ret = $"/newpassword?username={username}&token={generatedToken}&expired=1";
                                return Unauthorized(ret);
                            }
                            authenticated = true;
                        }
                    }
                }
                if (!authenticated)
                {
                    _logger.LogWarning($"Login failed for {username}");
                    ModelState.AddModelError("", "Login failed. Please check usern ame and/or password.");
                    return Unauthorized("Login failed. Please check your user name and/or password.");
                }
                else
                {
                    int? passwordExpirationWarning = null;
                    int dayUntilExpiration = (int)(((user?.PasswordExpiration ?? DateTime.UtcNow.AddDays(100)) - DateTime.UtcNow).TotalDays);
                    if (dayUntilExpiration <= _settings.PasswordExpirationWarning)
                        passwordExpirationWarning = dayUntilExpiration;
                    //passwordExpirationWarning = 3;
                    var userFullName = user.PersonFirst + " " + user.PersonLast;
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, user.WebPersonUserName),
                        new Claim("WebPersonId", user.WebPersonId.ToString()),
                        new Claim("UserFullName", userFullName),
                        new Claim("UserOrganizationId", user.UserOrganizationId.ToString()),
                        new Claim("PasswordExpirationWarning", (passwordExpirationWarning?.ToString()??"null")),
                        new Claim("TimeZone", (user.TimeZone??"null")),
                        new Claim("StatEmployeeId", user.StatEmployeeId.ToString()),
                        new Claim("CanSchedule", (user.CanSchedule.ToString()))
                    };

                    var claimsIdentity = new ClaimsIdentity(claims,
                        CookieAuthenticationDefaults.AuthenticationScheme);
                    var authProperties = new AuthenticationProperties();
                    await HttpContext.SignInAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        new ClaimsPrincipal(claimsIdentity),
                        authProperties);
                    
                    _logger.LogWarning($"Logged in {username}, Browser:{HttpContext.Request.Headers["User-Agent"]},");
                    return Content("{\"UserFullName\":\"" + userFullName + "\"" +
                        ",\"UserOrganizationId\":" + user.UserOrganizationId.ToString() +
                        ",\"WebPersonId\":" + user.WebPersonId.ToString() +
                        ",\"PasswordExpirationWarning\":" + (passwordExpirationWarning?.ToString() ?? "null") +
                        //make this 15 secs less than session timeout so that client side can have time
                        //to send an http request after auto logout is canceled to reset the session timeout
                        ",\"AutoLogOut\":" + (_settings.AutoLogOut-15).ToString() + 
                        ",\"AutoLogOutWarning\":" + _settings.AutoLogOutWarning.ToString() +
                        ",\"DefaultReportGroupId\": " + user.DefaultReportGroupId.ToString() +
                        ",\"CanSchedule\":" + user.CanSchedule.ToString() +
                        ",\"TimeZone\": \""+ user.TimeZone + "\"}", "application/json");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"LoginController.Login:username={username}");
                return Unauthorized();
            }
        }

        [Route("logout")]
        [HttpPost]
        public async Task<IActionResult> Logout()
        {
            try
            {
                var username = HttpContext.User.Claims.First(c => c.Type == "UserFullName").Value;
                _logger.LogWarning($"Logged out {username}");
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            }
            catch (System.Exception ex)
            {
                _logger.LogError(ex,"Logout");
            }
            return Ok();
        }

        [Authorize]
        [Route("usernameandorganization")]
        [HttpGet]
        public async Task<IActionResult> GetUserNameAndOrganization()
        {
            try
            {
                var userFullName = HttpContext.User.Claims.First(c => c.Type == "UserFullName").Value;
                var userOrganizationId = HttpContext.User.Claims.First(c => c.Type == "UserOrganizationId").Value;
                var webPersonId = HttpContext.User.Claims.First(c => c.Type == "WebPersonId").Value;
                var passwordExpirationWarning = HttpContext.User.Claims.First(c => c.Type == "PasswordExpirationWarning").Value;
                var timeZone = HttpContext.User.Claims.First(c => c.Type == "TimeZone").Value;
                var canSchedule = HttpContext.User.Claims.First(c => c.Type == "CanSchedule").Value;
                
                return Content("{\"UserFullName\":\"" + userFullName + "\"" +
                        ",\"UserOrganizationId\":\"" + userOrganizationId.ToString() +
                        "\",\"PasswordExpirationWarning\":" + (passwordExpirationWarning?.ToString() ?? "null") +
                        ",\"WebPersonId\":" + webPersonId.ToString() +
                        //make this 15 secs less than session timeout so that client side can have time
                        //to send an http request after auto logout is canceled to reset the session timeout
                        ",\"AutoLogOut\":" + (_settings.AutoLogOut - 15).ToString() +
                        ",\"AutoLogOutWarning\":" + _settings.AutoLogOutWarning.ToString() +
                        ",\"CanSchedule\":" + canSchedule +
                        ",\"TimeZone\": \"" + timeZone + "\"}", "application/json");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "LoginController.GetUserNameAndOrganization");
                return Unauthorized();
            }
        }
        [Route("validatepasswordchangerequest")]
        [HttpGet]
        public async Task<IActionResult> ValidatePasswordChangeRequest()
        {
            try
            {
                string generatedToken = PasswordResetHelper.GenerateToken();
                PasswordResetHelper.Add(HttpContext.User.Identity.Name, generatedToken);
                return Ok();
            }
            catch (System.Exception ex)
            {
                _logger.LogError(ex, "LoginController.ValidatePasswordChangeRequest");
                return Unauthorized("We cannot validate your credentials. Please try to login again.");
            }
        }
        
        [Route("resetpassword")]
        [HttpGet]
        public async Task<IActionResult> ResetPassword(string username)
        {
            try
            {
                string generatedToken = PasswordResetHelper.GenerateToken();
                PasswordResetHelper.Add(username, generatedToken);
                WebPerson user = await _dataProvider.GetUser(username);

                if ( user == null || user.Email == null)
                {
                    return BadRequest("We are unable to proceed. Please contact Statline Help Desk @ 1-866-344-7039");
                }

                var emailBody = "Here is your password reset link which is valid for 1 hour.<br>" +
                    $"<a href='{Request.Scheme}://{Request.Host}{Request.PathBase}/newpassword?username={username}&token={generatedToken}'>Reset Password</a>";
                await _emailService.SendEmailAsync(user.Email, "Your Statline Request", emailBody);
                _logger.LogWarning($"Email sent for password reset request. {username}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"LoginController.ResetPassword: username={username}");
                throw;
            }
            return Ok();
        }

        [Route("validateresetrequest")]
        [HttpGet]
        public async Task<IActionResult> ValidateResetRequest(string username, string token)
        {
            try
            {
                string savedToken = PasswordResetHelper.Get(username);
                if (savedToken == null || savedToken != token)
                {
                    return BadRequest("We cannot find your password reset request in the system. Please try to reset it again from the login page.");
                }
                else
                {
                    return Ok();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"LoginController.ValidateResetRequest: username={username}");
                throw;
            }
        }

        [Route("setpassword")]
        [HttpGet]
        public async Task<IActionResult> SetPassword(string username, string password, string passwordOld)
        {
            try
            {
                if (username == null) //coming from password change request
                {
                    username = HttpContext.User.Identity.Name;
                }

                var user = await _dataProvider.GetUser(username);
                string saltValue = user.SaltValue;
                string hashedPassword = user.HashedPassword;

                if (user != null)
                {
                    //password change is requested, check current password
                    if (passwordOld != null) 
                    {
                        if (hashedPassword != null)
                        {
                            string testHash = Security.CreatePasswordHash(String.Concat(passwordOld, saltValue));
                            if (!hashedPassword.Equals(testHash))
                            {
                                return Unauthorized("Your current password is not correct.");
                            }
                        }
                    }
                    
                    saltValue = Security.GenerateSaltValue(password);
                    string testHash2 = Security.CreatePasswordHash(String.Concat(password, user.SaltValue));
                    if (hashedPassword == testHash2)
                    {
                        return BadRequest("Your new password cannot be the same as your old password.");
                    }

                    string newHash = Security.CreatePasswordHash(String.Concat(password, saltValue));
                    int ret = await _dataProvider.UpdatePassword(user.WebPersonId, saltValue, newHash, DateTime.UtcNow.AddDays(_settings.PasswordExpiration));
                    PasswordResetHelper.Remove(user.WebPersonUserName);
                    return Ok();
                }
                else
                {
                    return BadRequest("Invalid user name.");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"LoginController.SetPassword: username={username}");
                throw;
            }
        }

        [Route("oldsiteexpiration")]
        [HttpGet]
        public async Task<IActionResult> GetOldSiteExpiration()
        {
            try
            {                
                return Content("{\"OldSiteExpiration\":\"" + _settings.OldSiteExpiration  + "\"}", "application/json");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "LoginController.GetOldSiteExpiration");
                return Unauthorized();
            }
        }
    }
}