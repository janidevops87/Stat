using AutoMapper;
using Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class ClientMappingProfile : Profile
    {
        public ClientMappingProfile()
        {
            CreateMap<
                ClientSummaryInfo,
                ClientSummaryViewModel>(MemberList.Destination);

            CreateMap<NewClientViewModel, NewClientInfo>(MemberList.Destination)
                .ForCtorParam("tenantId", x => x.MapFrom(m => (TenantId)m.Tenant.SelectedTenantId));

            CreateMap<ClaimViewModel, ClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<SecretInfo, SecretViewModel>(MemberList.Destination)
                .ForMember(x => x.CreationTime, opt => opt.MapFrom(x => x.CreationTime.ToUniversalTime()))
                .ReverseMap();

            CreateMap<SecretViewModel, NewSecretInfo>(MemberList.Destination);

            CreateMap<ScopeInfo, ScopeViewModel>(MemberList.Destination)
                .ForMember(x => x.Value, x => x.MapFrom(m => m.Name))
                .ReverseMap()
                .ForCtorParam("name", x => x.MapFrom(m => m.Value));

            CreateMap<Uri, RedirectUriViewModel>(MemberList.Destination)
               .ForMember(x => x.Value, cfg => cfg.MapFrom((src, dst) => src))
               .ReverseMap()
               .ConvertUsing(s => s.Value);

            CreateMap<IEnumerable<ClaimInfo>, EditClaimsViewModel>(MemberList.Source)
                .ForMember(m => m.Claims, cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap();

            CreateMap<IEnumerable<SecretInfo>, EditSecretsViewModel>(MemberList.Source)
                .ForMember(m => m.Secrets, cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap();

            CreateMap<IEnumerable<Uri>, EditRedirectUrisViewModel>(MemberList.Source)
                .ForMember(m => m.RedirectUris, cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap();

            CreateMap<EditPropertiesViewModel, ClientPropertiesInfo>()
                .ForCtorParam("clientId", x => x.MapFrom(m => m.EditableClientId))
                .ForCtorParam("allowedGrantTypes", x => x.MapFrom(m => m.GrantTypes.AllowedGrantTypes))
                .ReverseMap()
                .ForPath(x => x.GrantTypes.AllowedGrantTypes, x => x.MapFrom(m => m.AllowedGrantTypes))
                .ForPath(x => x.EditableClientId, x => x.MapFrom(m => m.ClientId));

            CreateMap<ClientPartInfo<IEnumerable<ScopeInfo>>, EditScopesViewModel>(MemberList.Destination)
                .ForMember(m => m.AllowedScopes, o => o.MapFrom(m => m.PartInfo));

            CreateMap<ClientPartInfo<IEnumerable<ClaimInfo>>, EditClaimsViewModel>(MemberList.Destination)
               .ForMember(m => m.Claims, o => o.MapFrom(m => m.PartInfo));

            CreateMap<ClientPartInfo<IEnumerable<SecretInfo>>, EditSecretsViewModel>(MemberList.Destination)
               .ForMember(m => m.Secrets, o => o.MapFrom(m => m.PartInfo.OrderByDescending(s => s.CreationTime)));

            CreateMap<ClientPartInfo<IEnumerable<Uri>>, EditRedirectUrisViewModel>(MemberList.Destination)
               .ForMember(m => m.RedirectUris, o => o.MapFrom(m => m.PartInfo));

            CreateMap<ClientPartInfo<ClientPropertiesInfo>, EditPropertiesViewModel>(MemberList.Destination)
                .ConvertUsing((src, tgt, ctx) =>
                {
                    tgt = ctx.Mapper.Map<EditPropertiesViewModel>(src.PartInfo);
                    tgt.ClientId = src.ClientId;
                    tgt.Id = src.Id;
                    return tgt;
                });
        }
    }
}
