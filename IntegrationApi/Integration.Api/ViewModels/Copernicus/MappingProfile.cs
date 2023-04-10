using AutoMapper;
using Statline.StatTrac.Integration.App.Copernicus;

namespace Statline.StatTrac.Integration.Api.ViewModels.Copernicus;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<NewReferralViewModel, NewReferralInfo>(MemberList.Source);
    }
}
