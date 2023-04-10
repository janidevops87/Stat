using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels;
using Statline.IdentityServer.Helper.ModelStateTransfer;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant
{
    [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
    public class TenantController : Controller
    {
        private readonly TenantManagementApplication tenantManagementApplication;
        private readonly IMapper mapper;

        public TenantController(
            TenantManagementApplication tenantManagementApplication,
            IMapper mapper)
        {
            Check.NotNull(tenantManagementApplication, nameof(tenantManagementApplication));
            Check.NotNull(mapper, nameof(mapper));
            this.tenantManagementApplication = tenantManagementApplication;
            this.mapper = mapper;
        }

        #region Tenants

        public async Task<IActionResult> Index()
        {
            var tenants = await tenantManagementApplication.ListTenantsAsync();

            var tenantViewModels = mapper.Map<IEnumerable<TenantListSummaryViewModel>>(tenants);

            return View(tenantViewModels);
        }

        [HttpGet]
        [ImportModelState]
        public IActionResult Add() => View();

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> Add(
            NewTenantViewModel newTenant)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(nameof(Add));
            }

            var newTenantInfo = mapper.Map<NewTenantInfo>(newTenant);

            try
            {
                await tenantManagementApplication.CreateTenantAsync(newTenantInfo);
            }
            catch (EntityAlreadyExistsException)
            {
                ModelState.AddModelError(
                    nameof(newTenant.OrganizationName),
                    "A tenant with such Organization Name already exists");

                return RedirectToAction(nameof(Add));
            }

            return RedirectToAction(nameof(Index));
        }

        public IActionResult Edit(int id) =>
            RedirectToAction(
              actionName: nameof(EditProperties),
              routeValues: new { id });

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(int id)
        {
            await tenantManagementApplication.DeleteTenantAsync(id);

            return RedirectToAction(nameof(Index));
        }

        #endregion Tenants

        #region Properties

        [ImportModelState]
        public async Task<IActionResult> EditProperties(int id)
        {
            var properties = await tenantManagementApplication.GetTenantPropertiesAsync(id);

            var viewModel = mapper.Map<EditPropertiesViewModel>(properties);

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
                var propsInfo = mapper.Map<TenantPropertiesInfo>(propsViewModel);

                await tenantManagementApplication.UpdateTenantPropertiesAsync(id, propsInfo);
            }

            return RedirectToAction(nameof(EditProperties), new { id });
        }

        #endregion Properties

        #region Claims

        public async Task<IActionResult> EditClaims(int id)
        {
            var claims = await tenantManagementApplication.GetTenantClaimsAsync(id);

            var viewModel = mapper.Map<EditClaimsViewModel>(claims);

            return View(viewModel);
        }

        [ImportModelState]
        public async Task<IActionResult> AddClaim(int id)
        {
            var tenantSummary =
                await tenantManagementApplication.GetTenantSummaryAsync(id);

            return View(new ClaimViewModel
            {
                Id = id,
                OrganizationName = tenantSummary.OrganizationName
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddClaim(
            int id,
            ClaimViewModel claimViewModel)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(
                    actionName: nameof(AddClaim),
                    routeValues: new { id });
            }

            var claim = mapper.Map<ClaimInfo>(claimViewModel);

            await tenantManagementApplication.AddTenantClaimAsync(id, claim);

            return RedirectToAction(
                actionName: nameof(EditClaims),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteClaim(
            int id,
            ClaimViewModel claimViewModel)
        {
            var claim = mapper.Map<ClaimInfo>(claimViewModel);

            await tenantManagementApplication.DeleteTenantClaimAsync(id, claim);

            return RedirectToAction(nameof(EditClaims), new { id });
        }

        #endregion Claims
    }
}