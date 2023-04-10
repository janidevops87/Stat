using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Threading.Tasks;
using IdentityServer4.Services;
using IdentityServer4.Stores;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.IdentityServer.Features.IdentityServerOperation.Account.ViewModels;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.App.Users;
using Statline.IdentityServer.IdentityAndAccess.App.Users.Dto;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;

namespace Statline.IdentityServer.Features.IdentityServerOperation.Account
{
    // This Authorize attribute might seem to be useless since
    // all actions allow anonymous user. But this way we
    // are sure that authorization is not forgotten if a new 
    // action is added which is not for anonymous access.
    [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
    public class AccountController : Controller
    {

        private readonly SignInManager<User> _signInManager;

        private readonly ILogger _logger;
        private readonly IIdentityServerInteractionService _interaction;
        private readonly IClientStore _clientStore;
        private readonly AccountService _account;

        public AccountController(
            SignInManager<User> signInManager,
            ILoggerFactory loggerFactory,
            IIdentityServerInteractionService interaction,
            IHttpContextAccessor httpContext,
            IClientStore clientStore,
            IAuthenticationSchemeProvider schemeProvider)
        {
            _signInManager = signInManager;
            _logger = loggerFactory.CreateLogger<AccountController>();
            _interaction = interaction;
            _clientStore = clientStore;

            _account = new AccountService(
                interaction,
                httpContext,
                schemeProvider,
                clientStore);
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        [HttpGet]
        public async Task<IActionResult> Login(string returnUrl)
        {
            var vm = await _account.BuildLoginViewModelAsync(returnUrl);

            if (vm.IsExternalLoginOnly)
            {
                // only one option for logging in
                return ExternalLogin(vm.ExternalProviders.First().AuthenticationScheme, returnUrl);
            }

            return View(vm);
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(
            LoginInputModel model,
            [FromServices]IOptions<DefaultAdminOptions> defaultAdminOptions)
        {
            if (ModelState.IsValid)
            {
                // Handle default admin which has 
                // restricted ability to log in.
                if (IsNotAllowedDefaultAdmin(
                    model.Username,
                    defaultAdminOptions.Value))
                {
                    ModelState.AddModelError(string.Empty,
                        "Default admin is not allowed to log in from your IP address.");
                    return View(await _account.BuildLoginViewModelAsync(model));
                }

                // This doesn't count login failures towards account lockout
                // To enable password failures to trigger account lockout, set lockoutOnFailure: true
                var result = await _signInManager.PasswordSignInAsync(model.Username, model.Password, model.RememberLogin, lockoutOnFailure: false);
                if (result.Succeeded)
                {
                    _logger.LogInformation(1, "User logged in.");
                    return RedirectToLocal(model.ReturnUrl);
                }

                if (result.IsLockedOut)
                {
                    _logger.LogWarning(2, "User account locked out.");
                    return View("Lockout");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                    return View(await _account.BuildLoginViewModelAsync(model));
                }
            }

            // If we got this far, something failed, redisplay form
            return View(await _account.BuildLoginViewModelAsync(model));
        }

        /// <summary>
        /// Show logout page
        /// </summary>
        [AllowAnonymous]
        [HttpGet]
        public async Task<IActionResult> Logout(string logoutId)
        {
            var vm = await _account.BuildLogoutViewModelAsync(logoutId);

            if (vm.ShowLogoutPrompt == false)
            {
                // no need to show prompt
                return await Logout(vm);
            }

            return View(vm);
        }

        /// <summary>
        /// Handle logout page postback
        /// </summary>
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public async Task<IActionResult> Logout(LogoutViewModel model)
        {
            var vm = await _account.BuildLoggedOutViewModelAsync(model.LogoutId);
            if (vm.TriggerExternalSignout)
            {
                string url = Url.Action("Logout", new { logoutId = vm.LogoutId });
                try
                {
                    // hack: try/catch to handle social providers that throw
                    await HttpContext.SignOutAsync(vm.ExternalAuthenticationScheme,
                        new Microsoft.AspNetCore.Authentication.AuthenticationProperties { RedirectUri = url });
                }
                catch (NotSupportedException) // this is for the external providers that don't have signout
                {
                }
                catch (InvalidOperationException) // this is for Windows/Negotiate
                {
                }
            }

            // delete authentication cookie
            await _signInManager.SignOutAsync();

            return View("LoggedOut", vm);
        }

        //
        // POST: /Account/ExternalLogin
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public IActionResult ExternalLogin(string provider, string returnUrl = null)
        {
            // Request a redirect to the external login provider.
            var redirectUrl = Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl });
            var properties = _signInManager.ConfigureExternalAuthenticationProperties(provider, redirectUrl);
            return Challenge(properties, provider);
        }

        //
        // GET: /Account/ExternalLoginCallback
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> ExternalLoginCallback(
            [FromServices]UserManagementApplication userManagementApplication,
            string returnUrl = null,
            string remoteError = null)
        {
            if (remoteError != null)
            {
                ModelState.AddModelError(string.Empty, $"Error from external provider: {remoteError}");
                return View(nameof(Login));
            }

            var info = await _signInManager.GetExternalLoginInfoAsync();

            if (info == null)
            {
                return RedirectToAction(nameof(Login));
            }

            var user =
                await userManagementApplication.GetUserSummaryByLoginInfoAsync(info);

            // TODO: Consider inheriting SignInManager
            // and overriding CanSignInAsync to check if the user is 
            // active during call to ExternalLoginSignInAsync.
            if (user != null &&
                !user.IsActive)
            {
                return View("Activate");
            }

            // Sign in the user with this external login provider 
            // if the user already has a login.
            var result = await _signInManager.ExternalLoginSignInAsync(
                info.LoginProvider,
                info.ProviderKey,
                isPersistent: false);

            if (result.Succeeded)
            {
                _logger.LogInformation(5, "User logged in with {Name} provider.", info.LoginProvider);
                return RedirectToLocal(returnUrl);
            }

            if (result.IsLockedOut)
            {
                return View("Lockout");
            }
            else
            {
                // If the user does not have an account, 
                // then ask the user to create an account.
                ViewData["ReturnUrl"] = returnUrl;
                ViewData["LoginProvider"] = info.LoginProvider;

                var email = info.Principal.FindFirstValue(ClaimTypes.Email);
                var viewModel = new ExternalLoginConfirmationViewModel { Email = email };

                return View("ExternalLoginConfirmation", viewModel);
            }
        }

        //
        // POST: /Account/ExternalLoginConfirmation
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ExternalLoginConfirmation(
            [FromServices]UserManagementApplication userManagementApplication,
            ExternalLoginConfirmationViewModel model,
            string returnUrl = null)
        {
            if (ModelState.IsValid)
            {
                // Get the information about the user from the external login provider
                var info = await _signInManager.GetExternalLoginInfoAsync();

                if (info == null)
                {
                    return View("ExternalLoginFailure");
                }

                var firstName = info.Principal.FindFirstValue(ClaimTypes.GivenName);
                var lastName = info.Principal.FindFirstValue(ClaimTypes.Surname);

                var newUser = new NewUserInfo(
                    userName: model.Email,
                    email: model.Email,
                    firstName: firstName,
                    lastName: lastName);

                try
                {
                    await userManagementApplication.RegisterNewUserWithExternalLoginAsync(
                        newUser,
                        info);

                    return View("Activate");
                }
                catch (ApplicationServiceException ex)
                {
                    AddError(ex);
                }
            }

            ViewData["ReturnUrl"] = returnUrl;

            return View(model);
        }

        [AllowAnonymous]
        public async Task<IActionResult> Error(string errorId)
        {
            var vm = new ErrorViewModel();

            // retrieve error details from identityserver
            var message = await _interaction.GetErrorContextAsync(errorId);
            if (message != null)
            {
                vm.Error = message;
            }

            return View("Error", vm);
        }

        #region Helpers

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }
        }

        private void AddError(Exception ex)
        {
            ModelState.AddModelError(string.Empty, ex.Message);
        }

        private IActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction(nameof(Home.HomeController.Index), "Home");
            }
        }

        // Default admin is minor helper functionality
        // which is OK to be placed inline here.
        // If it grows, should be extracted into a separate 
        // application service.
        private bool IsNotAllowedDefaultAdmin(
            string userName,
            DefaultAdminOptions defaultAdminOptions)
        {
            bool isDefaultAdmin = string.Equals(
                        userName,
                        defaultAdminOptions.UserName,
                        StringComparison.OrdinalIgnoreCase);

            if (!isDefaultAdmin)
                return false;

            var allowedIPs = GetAllowedIPs(defaultAdminOptions);

            var notAllowed =
                !allowedIPs.Contains(HttpContext.Connection.RemoteIpAddress);

            return notAllowed;
        }

        private static IEnumerable<IPAddress> GetAllowedIPs(
            DefaultAdminOptions defaultAdminOptions)
        {
            return defaultAdminOptions.AllowedIPs
                .Select(ipString =>
                {
                    IPAddress.TryParse(ipString, out var ipAddress);
                    return ipAddress;
                })
                .Where(ip => ip != null);
        }
        #endregion
    }
}
