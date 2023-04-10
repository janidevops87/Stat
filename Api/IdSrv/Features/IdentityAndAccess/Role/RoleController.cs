using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.Features.IdentityAndAccess.Role.ViewModels;
using Statline.IdentityServer.Helper.ModelStateTransfer;
using Statline.IdentityServer.IdentityAndAccess.App.Roles;
using Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Role
{

    [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
    public class RoleController : Controller
    {
        private readonly RoleManagementApplication roleManagementApplication;
        private readonly IMapper mapper;

        public RoleController(
            RoleManagementApplication roleManagementApplication,
            IMapper mapper)
        {
            Check.NotNull(roleManagementApplication, nameof(roleManagementApplication));
            Check.NotNull(mapper, nameof(mapper));
            this.roleManagementApplication = roleManagementApplication;
            this.mapper = mapper;
        }


        #region Roles

        public async Task<IActionResult> Index()
        {
            var roles = await roleManagementApplication.ListRolesAsync();

            var roleViewModels = mapper.Map<IEnumerable<RoleListSummaryViewModel>>(roles);

            return View(roleViewModels);
        }

        public IActionResult Edit(string id) =>
          RedirectToAction(
              actionName: nameof(EditProperties),
              routeValues: new { id });

        [HttpGet]
        [ImportModelState]
        public IActionResult Add() => View();

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> Add(
            NewRoleViewModel newRole)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(nameof(Add));
            }

            var newRoleInfo = mapper.Map<NewRoleInfo>(newRole);

            try
            {
                await roleManagementApplication.CreateRoleAsync(newRoleInfo);
            }
            catch (EntityAlreadyExistsException)
            {
                ModelState.AddModelError(
                    nameof(newRole.Name),
                    "A role with such name already exists");

                return RedirectToAction(nameof(Add));
            }

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(string id)
        {
            await roleManagementApplication.DeleteRoleAsync(id);

            return RedirectToAction(nameof(Index));
        }

        #endregion Roles

        #region Properties

        [ImportModelState]
        public async Task<IActionResult> EditProperties(string id)
        {
            var properties = await roleManagementApplication.GetRolePropertiesAsync(id);

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
                var propsInfo = mapper.Map<RolePropertiesInfo>(propsViewModel);

                await roleManagementApplication.UpdateRolePropertiesAsync(id, propsInfo);
            }

            return RedirectToAction(nameof(EditProperties), new { id });
        }

        #endregion Properties
    }
}