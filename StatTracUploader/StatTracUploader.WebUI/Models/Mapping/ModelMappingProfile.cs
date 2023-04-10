using AutoMapper;
using Statline.StatTracUploader.App.Uploader;
using Statline.StatTracUploader.WebUI.Models;
using System;

namespace Statline.StatTracUploader.Models
{
    public class ModelMappingProfile : Profile
    {
        public const string TimeZoneInfoKey = "TimeZoneInfo";

        public ModelMappingProfile()
        {
            CreateMap<UploadedReferralInfo, UploadedReferralModel>(MemberList.Destination)
                .ForMember(dst => dst.AddedToSystemOn, cfg => cfg.MapFrom(
                    (src, dst, dstMember, ctx) =>
                    {
                        var timeZoneInfo = (TimeZoneInfo)ctx.Items[TimeZoneInfoKey];
                        return src.AddedToSystemOn.ConvertToTimeZone(timeZoneInfo);
                    }))
                .ForMember(dst => dst.CallReceivedOn, cfg => cfg.MapFrom(
                    (src, dst, dstMember, ctx) =>
                    {
                        var timeZoneInfo = (TimeZoneInfo)ctx.Items[TimeZoneInfoKey];
                        return src.CallReceivedOn.ConvertToTimeZone(timeZoneInfo);
                    }));
        }
    }
}
