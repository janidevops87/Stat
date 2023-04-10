using AutoMapper;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.LowLevel.Referrals.Mapping;

public class ReferralMappingProfile : Profile
{
    public const string TimeZoneAbbreviationKey = "TimeZoneAbbreviation";

    public ReferralMappingProfile()
    {
        RecognizeDestinationPrefixes("Referral");
        CreateMap<NewReferralInfo, Referral>(MemberList.Source)
            .ForMember(dst => dst.CurrentReferralTypeId, cfg => cfg.MapFrom(src => src.CurrentTypeId))
            .ForMember(dst => dst.ReferralExtubated, cfg => cfg.MapFrom(src => src.ExtubatedAt))
            .ForMember(dst => dst.ReferralDonorName, cfg => cfg.MapFrom(
                (src, dst) =>
                {
                    if (src.DonorFirstName is null)
                    {
                        return src.DonorLastName;
                    }

                    if (src.DonorLastName is null)
                    {
                        return src.DonorFirstName;
                    }

                    return $"{src.DonorFirstName} {src.DonorLastName}";
                }))

            .ForMember(
                dst => dst.ReferralDonorAdmitDate,
                cfg => cfg.MapFrom(
                    src => src.DonorAdmitDateTime == null ? (DateOnly?)null : DateOnly.FromDateTime(src.DonorAdmitDateTime.Value)))
            .ForMember(dst => dst.ReferralDonorAdmitTime, cfg => cfg.MapFrom(
                (src, dst, dstMember, ctx) =>
                {
                    return MapTimeWithTimeZoneToString(src.DonorAdmitDateTime, ctx);
                }))

           .ForMember(
                dst => dst.ReferralDonorDeathDate,
                cfg => cfg.MapFrom(
                    src => src.DonorDeathDateTime == null ? (DateOnly?)null : DateOnly.FromDateTime(src.DonorDeathDateTime.Value)))
            .ForMember(dst => dst.ReferralDonorDeathTime, cfg => cfg.MapFrom(
                (src, dst, dstMember, ctx) =>
                {
                    return MapTimeWithTimeZoneToString(src.DonorDeathDateTime, ctx);
                }))

            .ForMember(
                dst => dst.ReferralDonorBrainDeathDate,
                cfg => cfg.MapFrom(
                    src => src.DonorBrainDeathDateTime == null ? (DateOnly?)null : DateOnly.FromDateTime(src.DonorBrainDeathDateTime.Value)))
            .ForMember(dst => dst.ReferralDonorBrainDeathTime, cfg => cfg.MapFrom(
                (src, dst, dstMember, ctx) =>
                {
                    return MapTimeWithTimeZoneToString(src.DonorBrainDeathDateTime, ctx);
                }))

            .ForMember(
                dst => dst.ReferralDonorLsaDate,
                cfg => cfg.MapFrom(
                    src => src.DonorLsaDateTime == null ? (DateOnly?)null : DateOnly.FromDateTime(src.DonorLsaDateTime.Value)))
            .ForMember(dst => dst.ReferralDonorLsaTime, cfg => cfg.MapFrom(
                (src, dst, dstMember, ctx) =>
                {
                    return MapTimeWithTimeZoneToString(src.DonorLsaDateTime, ctx);
                }));

        CreateMap<Referral, ReferralInfo>(MemberList.Source)
            .ForMember(dst => dst.ExtubatedAt, cfg => cfg.MapFrom(src => src.ReferralExtubated));
    }

    private static string? MapTimeWithTimeZoneToString(
        DateTime? sourceDateTime,
        ResolutionContext ctx)
    {
        if (sourceDateTime is null)
        {
            return null;
        }

        var timeZoneAbbreviation = ctx.Items[TimeZoneAbbreviationKey];

        return $"{sourceDateTime:HH:mm}" +
            (timeZoneAbbreviation is null ? string.Empty : $" {timeZoneAbbreviation}");
    }
}
