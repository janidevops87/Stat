using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels;
using Statline.IdentityServer.Helper.ModelStateTransfer;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Api;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api
{
    [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
    public class ApiResourceController : Controller
    {
        private readonly ApiResourceApplication apiResourceApplication;
        private readonly IMapper mapper;

        public ApiResourceController(
            ApiResourceApplication apiResourceApplication,
            IMapper mapper)
        {
            this.apiResourceApplication = apiResourceApplication;
            this.mapper = mapper;
        }

        #region ApiResource

        public async Task<IActionResult> Index()
        {
            var apiResources = await apiResourceApplication.ListApiResourcesAsync();

            var viewModels = mapper.Map<IEnumerable<ApiResourceSummaryViewModel>>(apiResources);

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
            NewApiResourceViewModel newApiResource)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(nameof(Add));
            }

            var newApiResourceInfo = mapper.Map<NewApiResourceInfo>(newApiResource);

            try
            {
                await apiResourceApplication.CreateApiResourceAsync(newApiResourceInfo);
            }
            catch (EntityAlreadyExistsException)
            {
                ModelState.AddModelError(
                    nameof(newApiResource.Name),
                    "An API Resource with such name already exists");

                return RedirectToAction(nameof(Add));
            }

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(int id)
        {
            await apiResourceApplication.DeleteApiResourceAsync(id);

            return RedirectToAction(nameof(Index));
        }

        #endregion ApiResource

        #region Properties

        [ImportModelState]
        public async Task<IActionResult> EditProperties(int id)
        {
            var properties = await apiResourceApplication.GetApiResourcePropertiesAsync(id);

            var viewModel = mapper.Map<EditPropertiesViewModel>(properties);

            viewModel.ApiResourceId = id;

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
                var propsInfo = mapper.Map<ApiResourcePropertiesInfo>(propsViewModel);

                await apiResourceApplication.UpdateApiResourcePropertiesAsync(id, propsInfo);
            }

            return RedirectToAction(nameof(EditProperties), new { id });
        }

        #endregion Properties

        #region UserClaims

        public async Task<IActionResult> EditUserClaims(int id)
        {
            var claims = await apiResourceApplication.GetApiResourceUserClaimsAsync(id);

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

                await apiResourceApplication.AddApiResourceUserClaimAsync(id, claim);
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

            await apiResourceApplication.DeleteApiResourceUserClaimAsync(id, claim);

            return RedirectToAction(nameof(EditUserClaims), new { id });
        }

        #endregion UserClaims

        #region Scopes

        [ImportModelState]
        public async Task<IActionResult> EditScopes(int id)
        {
            var scopes = await apiResourceApplication.GetApiResourceScopesAsync(id);

            var viewModel = mapper.Map<EditScopesViewModel>(scopes);

            return View(viewModel);
        }

        [ImportModelState]
        public async Task<IActionResult> AddScope(int id)
        {
            var resourceSummary =
                await apiResourceApplication.GetApiResourceSummaryAsync(id);

            return View(new ScopeViewModel
            {
                ApiResourceId = id,
                ApiResourceName = resourceSummary.Name
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddScope(
            int id,
            ScopeViewModel scopeViewModel)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(
                    actionName: nameof(AddScope),
                    routeValues: new { id });
            }

            var scope = mapper.Map<ScopeInfo>(scopeViewModel);

            await apiResourceApplication.AddApiResourceScopeAsync(id, scope);

            return RedirectToAction(
                actionName: nameof(EditScopes),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteScope(
            int id,
            string scopeName)
        {
            await apiResourceApplication.DeleteApiResourceScopeAsync(id, scopeName);

            return RedirectToAction(
                actionName: nameof(EditScopes),
                routeValues: new { id });
        }

        #endregion Scopes
    }
}