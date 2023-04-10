using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using IdentityServer4.EntityFramework.Entities;
using Statline.Common.Domain.Events;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model.Events;
using static IdentityServer4.IdentityServerConstants;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients
{
    /// <dev>
    /// NOTE: Working with storage (repository)
    /// is done in DDD style, meaning that Client entity is treated 
    /// as an Aggregate with tree of child Entities and Value Objects.
    /// This makes code to be more domain-centric rather than 
    /// data manipulation-centric. Also, if we need to switch data storage
    /// to a document-oriented database, this will be relatively easy to do.
    /// 
    /// In this particular case this approach is less efficient compared
    /// to manipulating on each aggregate piece directly. But this is
    /// for much part because of not so good entities design 
    /// (which is far from DDD). For example, a ClientScope is natural Value Object,
    /// but is designed as Entity with own ID. Further, even though ClientScope has
    /// its own ID, its actually not an independent Entity, but rather is owned by 
    /// particular Client (meaning ClientScope with same values are not shared).
    /// But performance here is not that critical, since this application has 
    /// administrative purpose and won't be executed often.
    /// </dev>
    public class ClientApplication
    {
        private readonly IClientRepository clientRepository;
        private readonly IMapper mapper;
        private readonly IDomainEventPublisher domainEventPublisher;
        private readonly IDateTimeService dateTimeService;

        public ClientApplication(
            IClientRepository clientRepository,
            IMapper mapper,
            IDomainEventPublisher domainEventPublisher,
            IDateTimeService dateTimeService)
        {
            Check.NotNull(clientRepository, nameof(clientRepository));
            Check.NotNull(mapper, nameof(mapper));
            Check.NotNull(domainEventPublisher, nameof(domainEventPublisher));
            Check.NotNull(dateTimeService, nameof(dateTimeService));

            this.clientRepository = clientRepository;
            this.mapper = mapper;
            this.domainEventPublisher = domainEventPublisher;
            this.dateTimeService = dateTimeService;
        }

        #region Client

        public async Task<IEnumerable<ClientSummaryInfo>> ListClientsAsync()
        {
            var clients = await clientRepository.ListClientsAsync();

            return mapper.Map<IEnumerable<ClientSummaryInfo>>(clients);
        }

        public async Task<ClientSummaryInfo> GetClientSummaryAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            return mapper.Map<ClientSummaryInfo>(client);
        }

        public async Task<string> CreateClientAsync(NewClientInfo newClientInfo)
        {
            Check.NotNull(newClientInfo, nameof(newClientInfo));

            var newClient = mapper.Map<Client>(newClientInfo);

            clientRepository.AddClient(newClient);

            await clientRepository.SaveChangesAsync();

            return newClient.ClientId;
        }

        public async Task DeleteClientAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            clientRepository.DeleteClient(client);

            await clientRepository.SaveChangesAsync();
        }

        #endregion Client

        #region Claims

        public async Task<ClientPartInfo<IEnumerable<ClaimInfo>>> GetClientClaimsAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            return mapper.Map<ClientPartInfo<IEnumerable<ClaimInfo>>>(client);
        }

        public async Task AddClientClaimAsync(
            int id,
            ClaimInfo claimInfo)
        {
            CheckId(id);
            Check.NotNull(claimInfo, nameof(claimInfo));

            var claim = mapper.Map<ClientClaim>(claimInfo);

            Client client = await clientRepository.GetById(id);

            client.Claims.Add(claim);

            await clientRepository.SaveChangesAsync();

            // TODO: Think how to move this to the domain layer.
            await domainEventPublisher.PublishAsync(
                new ClientClaimAddedEvent(id, claim));
        }

        public async Task DeleteClientClaimAsync(
            int id,
            ClaimInfo claimInfo)
        {
            CheckId(id);
            Check.NotNull(claimInfo, nameof(claimInfo));

            Client client = await clientRepository.GetById(id);

            // We don't care if there are several claims 
            // with same Type and Value, we delete just first 
            // of them.
            var index = client.Claims.FindIndex(claim =>
                claim.Type == claimInfo.Type &&
                claim.Value == claimInfo.Value);

            if (index == -1)
            {
                return;
            }

            var removedClaim = client.Claims[index];

            client.Claims.RemoveAt(index);

            await clientRepository.SaveChangesAsync();

            // TODO: Think how to move this to the domain layer.
            await domainEventPublisher.PublishAsync(
                new ClientClaimRemovedEvent(id, removedClaim));
        }

        #endregion Claims

        #region Properties

        public async Task<ClientPartInfo<ClientPropertiesInfo>>
            GetClientPropertiesAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            return mapper.Map<ClientPartInfo<ClientPropertiesInfo>>(client);
        }

        public async Task UpdateClientPropertiesAsync(
            int id,
            ClientPropertiesInfo clientProperties)
        {
            CheckId(id);
            Check.NotNull(clientProperties, nameof(clientProperties));

            Client client = await clientRepository.GetById(id);

            mapper.Map(clientProperties, client);

            await clientRepository.SaveChangesAsync();
        }

        #endregion Properties

        #region Secrets

        public async Task<ClientPartInfo<IEnumerable<SecretInfo>>>
            GetClientSecretsAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            return mapper.Map<ClientPartInfo<IEnumerable<SecretInfo>>>(client);
        }

        public async Task AddClientSecretAsync(int id, NewSecretInfo secretInfo)
        {
            CheckId(id);
            Check.NotNull(secretInfo, nameof(secretInfo));

            var newSecret = mapper.Map<ClientSecretExtended>(secretInfo);

            newSecret.CreationTime = 
                dateTimeService.GetCurrent().ToUniversalTime();

            if (newSecret.Type == SecretTypes.SharedSecret)
            {
                // This secret type is actually a user-provided password,
                // so we store a hash of it. Identity Server uses hash as well 
                // when authenticating a client with this type of secret.
                // TODO: Consider adding abstraction for hashing algorithm.
                newSecret.Value =
                    IdentityServer4.Models.HashExtensions.Sha512(newSecret.Value);
            }

            Client client = await clientRepository.GetById(id);

            if (client.ClientSecrets.Exists(cs =>
                 cs.Type == newSecret.Type &&
                 cs.Value == newSecret.Value))
            {
                return;
            }

            client.ClientSecrets.Add(newSecret);

            await clientRepository.SaveChangesAsync();
        }

        public async Task DeleteClientSecretAsync(int id, SecretInfo secretInfo)
        {
            CheckId(id);
            Check.NotNull(secretInfo, nameof(secretInfo));

            Client client = await clientRepository.GetById(id);

            var index = client.ClientSecrets.FindIndex(secret =>
                secret.Type == secretInfo.Type &&
                secret.Value == secretInfo.Value);

            if (index == -1)
            {
                return;
            }

            client.ClientSecrets.RemoveAt(index);

            await clientRepository.SaveChangesAsync();
        }

        #endregion Secrets

        #region Scopes

        public async Task<ClientPartInfo<IEnumerable<ScopeInfo>>>
            GetClientScopesAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            return mapper.Map<ClientPartInfo<IEnumerable<ScopeInfo>>>(client);
        }

        public async Task AddClientScopeAsync(int id, ScopeInfo newScope)
        {
            CheckId(id);
            Check.NotNull(newScope, nameof(newScope));

            Client client = await clientRepository.GetById(id);

            if (client.AllowedScopes.Exists(s => s.Scope == newScope.Name))
            {
                return;
            }

            var newClientScope = mapper.Map<ClientScope>(newScope);

            client.AllowedScopes.Add(newClientScope);

            await clientRepository.SaveChangesAsync();
        }

        public async Task DeleteClientScopeAsync(int id, ScopeInfo scope)
        {
            CheckId(id);
            Check.NotNull(scope, nameof(scope));

            Client client = await clientRepository.GetById(id);

            var index = client.AllowedScopes.FindIndex(
                clientScope => clientScope.Scope == scope.Name);

            if (index == -1)
            {
                return;
            }

            client.AllowedScopes.RemoveAt(index);

            await clientRepository.SaveChangesAsync();
        }

        #endregion Scopes

        #region Redirect URIs

        public async Task<ClientPartInfo<IEnumerable<Uri>>>
            GetClientRedirectUrisAsync(int id)
        {
            CheckId(id);

            var client = await clientRepository.GetById(id);

            return mapper.Map<ClientPartInfo<IEnumerable<Uri>>>(client);
        }

        public async Task AddClientRedirectUriAsync(int id, Uri redirectUri)
        {
            CheckId(id);
            Check.NotNull(redirectUri, nameof(redirectUri));

            Client client = await clientRepository.GetById(id);

            var redirectUriString = redirectUri.ToString();

            if (client.RedirectUris.Exists(s => s.RedirectUri == redirectUriString))
            {
                return;
            }

            var newClientRedirectUri = mapper.Map<ClientRedirectUri>(redirectUri);

            client.RedirectUris.Add(newClientRedirectUri);

            await clientRepository.SaveChangesAsync();
        }

        public async Task DeleteClientRedirectUriAsync(int id, Uri redirectUri)
        {
            CheckId(id);
            Check.NotNull(redirectUri, nameof(redirectUri));

            if (!redirectUri.IsAbsoluteUri)
            {
                throw new ArgumentException("Redirect URI must be absolute.", nameof(redirectUri));
            }

            Client client = await clientRepository.GetById(id);

            var redirectUriString = redirectUri.ToString();

            var index = client.RedirectUris.FindIndex(
                s => s.RedirectUri == redirectUriString);

            if (index == -1)
            {
                return;
            }

            client.RedirectUris.RemoveAt(index);

            await clientRepository.SaveChangesAsync();
        }

        #endregion Redirect URIs

        private static void CheckId(int id)
        {
            Check.BiggerOrEqual(id, other: 0, nameof(id));
        }
    }
}
