using AutoMapper;
using Statline.StatTrac.App.LowLevel.Referrals;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Referrals.Mapping;

public class ReferralMappingProfile : Profile
{
    public ReferralMappingProfile()
    {
        CreateMap<DuplicateReferralsFilterCriteriaViewModel, DuplicateReferralsFilterCriteria>(MemberList.Destination);
        CreateMap<NewReferralViewModel, App.LowLevel.Referrals.NewReferralInfo>(MemberList.Source)
            .ForMember(d => d.Dob, opt => opt.MapFrom((s, d) => s.Dob?.ToDateOnly()));
        CreateMap<ReferralInfo, ReferralViewModel>(MemberList.Source);
    }
}
