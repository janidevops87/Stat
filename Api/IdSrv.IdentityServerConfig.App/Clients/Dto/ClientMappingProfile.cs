using AutoMapper;
using AutoMapper.EquivalencyExpression;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using Entities = IdentityServer4.EntityFramework.Entities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class ClientMappingProfile : Profile
    {
        public ClientMappingProfile()
        {
            CreateMap<
                Entities.Client,
                ClientSummaryInfo>(MemberList.Destination)
                .ForMember(x => x.TenantId, o => o.MapFrom((x, y) => x.GetTenantId()));

            CreateMap<NewSecretInfo, ClientSecretExtended>(MemberList.Source);
            CreateMap<ClientSecretExtended, SecretInfo>(MemberList.Destination);

            CreateMap<Entities.ClientClaim, ClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<Entities.Client, ClientPropertiesInfo>(MemberList.Destination).ReverseMap();

            CreateMap<NewClientInfo, Entities.Client>(MemberList.Source)
                .AfterMap((x, y) => y.SetTenantId(x.TenantId));

            CreateMap<ScopeInfo, Entities.ClientScope>(MemberList.Destination)
                .ForMember(x => x.Scope, opt => opt.MapFrom(y => y.Name))
                .ReverseMap()
                .ForCtorParam("name", opt => opt.MapFrom(y => y.Scope));

            CreateMap<Uri, Entities.ClientRedirectUri>(MemberList.Destination)
                .ForMember(x => x.RedirectUri, cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap()
                .ConvertUsing(s => new Uri(s.RedirectUri, UriKind.RelativeOrAbsolute));

            CreateMap<string, Entities.ClientGrantType>(MemberList.Destination)
                .ForMember(x => x.GrantType, cfg => cfg.MapFrom((src, dst) => src))
                .EqualityComparison((x, y) => x == y.GrantType)
                .ReverseMap()
                .ConvertUsing(s => s.GrantType);

            CreateMap<Entities.Client, ClientPartInfo<IEnumerable<ScopeInfo>>>(MemberList.Destination)
               .ForMember(x => x.PartInfo, x => x.MapFrom(m => m.AllowedScopes));

            CreateMap<Entities.Client, ClientPartInfo<IEnumerable<ClaimInfo>>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, x => x.MapFrom(m => m.Claims));

            CreateMap<Entities.Client, ClientPartInfo<IEnumerable<SecretInfo>>>(MemberList.Destination)
                .ForMember(
                    x => x.PartInfo,
                    // Cast because we don't expect base class 
                    // instances to appear in this collection.
                    // We have these parent-child classes only because
                    // ClientSecret and Client are defined in a third-party library.
                    x => x.MapFrom(m => m.ClientSecrets.Cast<ClientSecretExtended>()));

            CreateMap<Entities.Client, ClientPartInfo<IEnumerable<Uri>>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, x => x.MapFrom(m => m.RedirectUris));

            CreateMap<Entities.Client, ClientPartInfo<ClientPropertiesInfo>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

        }
    }
}
