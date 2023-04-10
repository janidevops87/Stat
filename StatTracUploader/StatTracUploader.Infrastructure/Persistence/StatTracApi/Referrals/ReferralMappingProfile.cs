using AutoMapper;
using Statline.StatTracUploader.Domain.Main.Referrals;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Referrals;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Referrals
{
    public class ReferralMappingProfile : Profile
    {
        public ReferralMappingProfile()
        {
            CreateMap<Referral, NewReferral>(MemberList.Destination);
            CreateMap<
                Domain.Main.Referrals.DuplicateReferralsFilterCriteria,
                Services.StatTracApi.Model.Referrals.DuplicateReferralsFilterCriteria>(MemberList.Source)
                .ForMember(dst => dst.FilterType,
                    cfg => cfg.MapFrom((_, __) => DuplicateReferralsFilterType.MedicalRecordNumber));
        }
    }
}
