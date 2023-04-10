using AutoMapper;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Enums
{
    public class EnumMappingProfile : Profile
    {
        public EnumMappingProfile()
        {
            CreateMap<
                Services.StatTracApi.Model.Enums.EnumValue,
                Domain.Main.Enums.EnumValue>(MemberList.Destination);
        }
    }
}
