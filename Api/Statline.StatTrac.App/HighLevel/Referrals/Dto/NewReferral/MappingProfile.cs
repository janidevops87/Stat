using AutoMapper;

namespace Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<ReferralInfo, Domain.Referrals.Factory.ReferralInfo>(MemberList.Source);
        CreateMap<CallInfo, Domain.Referrals.Factory.CallInfo>(MemberList.Source);
        CreateMap<CallerInfo, Domain.Referrals.Factory.CallerInfo>(MemberList.Source);
        CreateMap<DonorInfo, Domain.Referrals.Factory.DonorInfo>(MemberList.Source);
        CreateMap<DonorHighRiskInfo, Domain.Referrals.Factory.DonorHighRiskInfo>(MemberList.Source);
        CreateMap<DonorPersonInfo, Domain.Referrals.Factory.DonorPersonInfo>(MemberList.Source);
    }
}
