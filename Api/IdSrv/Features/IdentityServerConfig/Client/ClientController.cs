using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels;
using Statline.IdentityServer.Helper.ModelStateTransfer;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants;
using Statline.IdentityServer.IdentityServerConfig.App.Clients;
using Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client
{
    [Authorize(Policy = AuthorizationPolicies.ConfigurationViewingPolicy)]
    public class ClientController : Controller
    {
        private readonly ClientApplication clientApplication;
        private readonly IMapper mapper;

        public ClientController(
            ClientApplication clientApplication,
            IMapper mapper)
        {
            this.clientApplication = clientApplication;
            this.mapper = mapper;
        }

        #region Client

        public async Task<IActionResult> Index()
        {
            var clients = await clientApplication.ListClientsAsync();

            var viewModels = mapper.Map<IEnumerable<ClientSummaryViewModel>>(clients);

            return View(viewModels);
        }

        public IActionResult Edit(int id) =>
            RedirectToAction(
                actionName: nameof(EditProperties),
                routeValues: new { id });

        [HttpGet]
        [ImportModelState]
        [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
        public async Task<IActionResult> Add(
            [FromServices]TenantManagementApplication tenantManagementApplication)
        {
            var tenants = await tenantManagementApplication.ListTenantsAsync();

            var viewModel = new NewClientViewModel();

            viewModel.Tenant.AllTenants.AddRange(
                mapper.Map<IEnumerable<SelectListItem>>(tenants));

            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
        public async Task<IActionResult> Add(
            NewClientViewModel newClient)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(nameof(Add));
            }

            // TODO: Consider adding additional 
            // check for chosen Tenant existence.

            var newClientInfo = mapper.Map<NewClientInfo>(newClient);

            try
            {
                await clientApplication.CreateClientAsync(newClientInfo);
            }
            catch (EntityAlreadyExistsException)
            {
                ModelState.AddModelError(
                    nameof(newClient.ClientId),
                    "A client with such Client Id already exists");

                return RedirectToAction(nameof(Add));
            }

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Policy = AuthorizationPolicies.WholeApplicationAdministrationPolicy)]
        public async Task<IActionResult> Delete(int id)
        {
            await clientApplication.DeleteClientAsync(id);

            return RedirectToAction(nameof(Index));
        }

        #endregion Client

        #region Claims

        public async Task<IActionResult> EditClaims(int id)
        {
            var claims = await clientApplication.GetClientClaimsAsync(id);

            var viewModel = mapper.Map<EditClaimsViewModel>(claims);

            return View(viewModel);
        }

        [ImportModelState]
        [Authorize(Policy = AuthorizationPolicies.ConfigurationEditingPolicy)]
        public async Task<IActionResult> AddClaim(int id)
        {
            var clientSummary =
                await clientApplication.GetClientSummaryAsync(id);

            return View(new ClaimViewModel
            {
                Id = id,
                ClientId = clientSummary.ClientId
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        [Authorize(Policy = AuthorizationPolicies.ConfigurationEditingPolicy)]
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

            await clientApplication.AddClientClaimAsync(id, claim);

            return RedirectToAction(
                actionName: nameof(EditClaims),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Policy = AuthorizationPolicies.ConfigurationEditingPolicy)]
        public async Task<IActionResult> DeleteClaim(
            int id,
            ClaimViewModel claimViewModel)
        {
            var claim = mapper.Map<ClaimInfo>(claimViewModel);

            await clientApplication.DeleteClientClaimAsync(id, claim);

            return RedirectToAction(nameof(EditClaims), new { id });
        }

        #endregion Claims

        #region Properties

        [ImportModelState]
        public async Task<IActionResult> EditProperties(int id)
        {
            var properties = await clientApplication.GetClientPropertiesAsync(id);

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
                var propsInfo = mapper.Map<ClientPropertiesInfo>(propsViewModel);

                await clientApplication.UpdateClientPropertiesAsync(id, propsInfo);
            }

            return RedirectToAction(nameof(EditProperties), new { id });
        }

        #endregion Properties

        #region Secrets

        public async Task<IActionResult> EditSecrets(int id)
        {
            var secrets = await clientApplication.GetClientSecretsAsync(id);

            var viewModel = mapper.Map<EditSecretsViewModel>(secrets);

            return View(viewModel);
        }

        [ImportModelState]
        public async Task<IActionResult> AddSecret(int id)
        {
            var clientSummary =
                await clientApplication.GetClientSummaryAsync(id);

            return View(new SecretViewModel
            {
                Id = id,
                ClientId = clientSummary.ClientId
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddSecret(
            int id,
            SecretViewModel secretViewModel)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction(
                    actionName: nameof(AddSecret),
                    routeValues: new { id });
            }

            var secret = mapper.Map<NewSecretInfo>(secretViewModel);

            await clientApplication.AddClientSecretAsync(id, secret);

            return RedirectToAction(
                actionName: nameof(EditSecrets),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteSecret(
           int id,
           SecretViewModel secretViewModel)
        {
            var secret = mapper.Map<SecretInfo>(secretViewModel);

            await clientApplication.DeleteClientSecretAsync(id, secret);

            return RedirectToAction(
                actionName: nameof(EditSecrets),
                routeValues: new { id });
        }

        #endregion Secrets

        #region Scopes

        [ImportModelState]
        public async Task<IActionResult> EditScopes(int id)
        {
            var scopes = await clientApplication.GetClientScopesAsync(id);

            var viewModel = mapper.Map<EditScopesViewModel>(scopes);

            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddScope(
            int id,
            ScopeViewModel scopeViewModel)
        {
            if (ModelState.IsValid)
            {
                var scope = mapper.Map<ScopeInfo>(scopeViewModel);

                await clientApplication.AddClientScopeAsync(id, scope);
            }

            return RedirectToAction(
                actionName: nameof(EditScopes),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteScope(
            int id,
            ScopeViewModel scopeViewModel)
        {
            var scope = mapper.Map<ScopeInfo>(scopeViewModel);

            await clientApplication.DeleteClientScopeAsync(id, scope);

            return RedirectToAction(
                actionName: nameof(EditScopes),
                routeValues: new { id });
        }

        #endregion Scopes

        #region Redirect URIs

        [ImportModelState]
        public async Task<IActionResult> EditRedirectUris(int id)
        {
            var redirectUris = await clientApplication.GetClientRedirectUrisAsync(id);

            var viewModel = mapper.Map<EditRedirectUrisViewModel>(redirectUris);

            return View(viewModel);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [ExportModelState]
        public async Task<IActionResult> AddRedirectUri(
            int id,
            RedirectUriViewModel redirectUriViewModel)
        {
            if (ModelState.IsValid)
            {
                var redirectUri = mapper.Map<Uri>(redirectUriViewModel);

                await clientApplication.AddClientRedirectUriAsync(id, redirectUri);
            }

            return RedirectToAction(
                actionName: nameof(EditRedirectUris),
                routeValues: new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteRedirectUri(
           int id,
           RedirectUriViewModel redirectUriViewModel)
        {
            var redirectUri = mapper.Map<Uri>(redirectUriViewModel);

            await clientApplication.DeleteClientRedirectUriAsync(id, redirectUri);

            return RedirectToAction(
                actionName: nameof(EditRedirectUris),
                routeValues: new { id });
        }

        #endregion Redirect URIs
    }
}