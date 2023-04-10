using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Statline.Common.Utilities;
using Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels;
using Statline.IdentityServer.Helper.ModelStateTransfer;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants;
using Statline.IdentityServer.IdentityAndAccess.App.Users;
using Statline.IdentityServer.IdentityAndAccess.App.Users.Dto;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User
{
    [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
    public class UserController : Controller
    {
        private readonly UserManagementApplication userManagementApplication;
        private readonly IMapper mapper;

        public UserController(
            UserManagementApplication userManagementApplication,
            IMapper mapper)
        {
            Check.NotNull(userManagementApplication, nameof(userManagementApplication));
            Check.NotNull(mapper, nameof(mapper));
            this.userManagementApplication = userManagementApplication;
            this.mapper = mapper;
        }

        #region Users

        public async Task<IActionResult> Index(
            [FromServices]UserQueryApplication userQueryApplication)
        {
            var users = await userQueryApplication.ListUsersAsync();

            var userViewModels = mapper.Map<IEnumerable<UserListSummaryViewModel>>(users);

            return View(userViewModels);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(string id)
        {
            await userManagementApplication.DeleteUserAsync(id);

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Activate(
            string id,
            string returnUrl)
        {
            await userManagementApplication.ActivateUser(id);

            return Redirect(returnUrl);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Deactivate(
            string id,
            string returnUrl)
        {
            await userManagementApplication.DeactivateUser(id);

            return Redirect(returnUrl);
        }

        public IActionResult Edit(string id) =>
          RedirectToAction(
              actionName: nameof(EditProperties),
              routeValues: new { id });

        #endregion Users

        #region Properties

        [ImportModelState]
        public async Task<IActionResult> EditProperties(string id)
        {
            var properties = await userManagementApplication.GetUserPropertiesAsync(id);

            var viewModel = mapper.Map<EditPropertiesViewModel>(properties);

            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> EditProperties(
           string id,
           EditPropertiesViewModel propsViewModel)
        {
            if (ModelState.IsValid)
            {
                var propsInfo = mapper.Map<UserPropertiesInfo>(propsViewModel);

                await userManagementApplication.UpdateUserPropertiesAsync(id, propsInfo);
            }

            return RedirectToAction(nameof(EditProperties), new { id });
        }

        #endregion Properties

        #region Claims

        public async Task<IActionResult> EditClaims(string id)
        {
            var claims = await userManagementApplication.GetUserClaimsAsync(id);

            var viewModel = mapper.Map<EditClaimsViewModel>(claims);

            return View(viewModel);
        }

        [ImportModelState]
        public async Task<IActionResult> AddClaim(
            string id,
            [FromServices]UserQueryApplication userQueryApplication)
        {
            var userSummary =
                await userQueryApplication.GetUserSummaryAsync(id);

            return View(new ClaimViewModel
            {
                Id = id,
                UserName = userSummary.UserName
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddClaim(
            string id,
            ClaimViewModel claimViewModel)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(
                    actionName: nameof(AddClaim),
                    routeValues: new { id });
            }

            var claim = mapper.Map<ClaimInfo>(claimViewModel);

            await userManagementApplication.AddUserClaimAsync(id, claim);

            return RedirectToAction(
                actionName: nameof(EditClaims),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteClaim(
            string id,
            ClaimViewModel claimViewModel)
        {
            var claim = mapper.Map<ClaimInfo>(claimViewModel);

            await userManagementApplication.DeleteUserClaimAsync(id, claim);

            return RedirectToAction(nameof(EditClaims), new { id });
        }

        #endregion Claims

        #region Roles

        public async Task<IActionResult> EditRoles(string id)
        {
            var roles = await userManagementApplication.GetUserRolesAsync(id);

            var viewModel = mapper.Map<EditRolesViewModel>(roles);

            return View(viewModel);
        }

        [ImportModelState]
        public async Task<IActionResult> AddToRole(
            [FromServices]UserManagementApplication userManagementApplication,
            [FromServices]UserQueryApplication userQueryApplication,
            string id)
        {
            // TODO: Consider querying roles along with the user
            // using query model instead of command model.
            var roles = 
                await userManagementApplication.ListUserCandidateRolesAsync(id);

            var userSummary =
                await userQueryApplication.GetUserSummaryAsync(id);

            return View(new SelectRoleViewModel
            {
                Id = id,
                UserName = userSummary.UserName,
                AllRoles = { mapper.Map<IEnumerable<SelectListItem>>(roles) }
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddToRole(
            string id,
            SelectRoleViewModel selectRoleViewModel)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(
                    actionName: nameof(AddToRole),
                    routeValues: new { id });
            }

            var role = mapper.Map<RoleInfo>(selectRoleViewModel);

            await userManagementApplication.AddUserToRoleAsync(id, role);

            return RedirectToAction(
                actionName: nameof(EditRoles),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RemoveFromRole(
            string id,
            RoleViewModel roleViewModel)
        {
            var role = mapper.Map<RoleInfo>(roleViewModel);

            await userManagementApplication.RemoveUserFromRoleAsync(id, role);

            return RedirectToAction(nameof(EditRoles), new { id });
        }

        #endregion Roles

        #region Registration

        [HttpGet]
        [ImportModelState]
        public async Task<IActionResult> ConfirmRegistration(
            [FromServices]TenantManagementApplication tenantManagementApplication,
            [FromServices]UserQueryApplication userQueryApplication,
            string id)
        {
            var tenants = await tenantManagementApplication.ListTenantsAsync();

            // TODO: Consider adding another query method
            // with simpler returned model matching the needs.
            var userSummary =
                await userQueryApplication.GetUserSummaryAsync(id);

            var viewModel = new ConfirmRegistrationViewModel
            {
                Id = id,
                UserName = userSummary.UserName,
            };

            viewModel.Tenant.AllTenants.AddRange(
                mapper.Map<IEnumerable<SelectListItem>>(tenants));

            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> ConfirmRegistration(
           string id,
           ConfirmRegistrationViewModel confirmRegistrationViewModel)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(
                    actionName: nameof(ConfirmRegistration),
                    routeValues: new { id });
            }

            await userManagementApplication.ConfirmNewUserRegistrationAsync(
                id,
                confirmRegistrationViewModel.Tenant.SelectedTenantId);

            return RedirectToAction(nameof(Edit), new { id });
        }

        #endregion Registration
    }
}