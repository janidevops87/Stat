using AutoMapper;
using Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<ReferralViewModel, ReferralInfo>(MemberList.Source);
        CreateMap<CreatedReferralInfo, CreatedReferralViewModel>(MemberList.Destination);
        CreateMap<CallViewModel, CallInfo>(MemberList.Source);
        CreateMap<CallerViewModel, CallerInfo>(MemberList.Source);
        CreateMap<DonorViewModel, DonorInfo>(MemberList.Source);
        CreateMap<DonorHighRiskViewModel, DonorHighRiskInfo>(MemberList.Source);
        CreateMap<DonorPersonViewModel, DonorPersonInfo>(MemberList.Source);
        CreateMap<ReferralId, int>().ConvertUsing(id => id.Value);
    }
}
