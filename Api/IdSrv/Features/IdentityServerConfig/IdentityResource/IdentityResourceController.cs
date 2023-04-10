using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.IdentityServer.Features.IdentityServerConfig.Identity.ViewModels;
using Statline.IdentityServer.Helper.ModelStateTransfer;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Identity
{
    [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
    public class IdentityResourceController : Controller
    {
        private readonly IdentityResourceApplication identityResourceApplication;
        private readonly IMapper mapper;

        public IdentityResourceController(
            IdentityResourceApplication identityResourceApplication,
            IMapper mapper)
        {
            this.identityResourceApplication = identityResourceApplication;
            this.mapper = mapper;
        }

        #region IdentityResource

        public async Task<IActionResult> Index()
        {
            var identityResources = await identityResourceApplication.ListIdentityResourcesAsync();

            var viewModels = mapper.Map<IEnumerable<IdentityResourceSummaryViewModel>>(identityResources);

            return View(viewModels);
        }

        public IActionResult Edit(int id) =>
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
            NewIdentityResourceViewModel newIdentityResource)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(nameof(Add));
            }

            var newIdentityResourceInfo = mapper.Map<NewIdentityResourceInfo>(newIdentityResource);

            try
            {
                await identityResourceApplication.CreateIdentityResourceAsync(newIdentityResourceInfo);
            }
            catch (EntityAlreadyExistsException)
            {
                ModelState.AddModelError(
                    nameof(newIdentityResource.Name),
                    "An Identity Resource with such name already exists");

                return RedirectToAction(nameof(Add));
            }

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(int id)
        {
            await identityResourceApplication.DeleteIdentityResourceAsync(id);

            return RedirectToAction(nameof(Index));
        }

        #endregion IdentityResource

        #region Properties

        [ImportModelState]
        public async Task<IActionResult> EditProperties(int id)
        {
            var properties = await identityResourceApplication.GetIdentityResourcePropertiesAsync(id);

            var viewModel = mapper.Map<EditPropertiesViewModel>(properties);

            viewModel.IdentityResourceId = id;

            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> EditProperties(
           int id,
           EditPropertiesViewModel propsViewModel)
        {
            if (ModelState.IsValid)
            {
                var propsInfo = mapper.Map<IdentityResourcePropertiesInfo>(propsViewModel);

                await identityResourceApplication.UpdateIdentityResourcePropertiesAsync(id, propsInfo);
            }

            return RedirectToAction(nameof(EditProperties), new { id });
        }

        #endregion Properties

        #region UserClaims

        public async Task<IActionResult> EditUserClaims(int id)
        {
            var claims = await identityResourceApplication.GetIdentityResourceUserClaimsAsync(id);

            var viewModel = mapper.Map<EditUserClaimsViewModel>(claims);

            return View(viewModel);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddUserClaim(
            int id,
            UserClaimViewModel claimViewModel)
        {
            if (ModelState.IsValid)
            {
                var claim = mapper.Map<UserClaimInfo>(claimViewModel);

                await identityResourceApplication.AddIdentityResourceUserClaimAsync(id, claim);
            }

            return RedirectToAction(
                actionName: nameof(EditUserClaims),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteUserClaim(
            int id,
            UserClaimViewModel claimViewModel)
        {
            var claim = mapper.Map<UserClaimInfo>(claimViewModel);

            await identityResourceApplication.DeleteIdentityResourceUserClaimAsync(id, claim);

            return RedirectToAction(nameof(EditUserClaims), new { id });
        }

        #endregion UserClaims
    }
}