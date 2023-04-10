using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;
using System.Collections.Immutable;

using CommonDtoTranslationExtensions = 
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi.DtoTranslationExtensions;

using HighRiskCallReferralDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto.HighRiskCallReferral;

using ReferralDetailsDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto.ReferralDetails;


namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralSource.StatTracApi;

internal static class DtoTranslationExtensions
{
    public static HighRiskReferralDetails ToHighRiskReferralDetails(
       this (HighRiskCallReferralDto HighRiskDto, ReferralDetailsDto Referral) dto)
    {
        var referralDto = dto.Referral;

        return new HighRiskReferralDetails
        (
            #pragma warning disable format
            HighRiskLogEventId:                 dto.HighRiskDto.LogEventId,
            HighRiskType:                       dto.HighRiskDto.RiskType,
            CallId:                             referralDto.CallId,
            ReferralId:                         referralDto.ReferralId,
            CallDateTime :                      referralDto.CallDateTime,
            Caller:                             referralDto.Caller,
            CallerOrganizationUnit:             referralDto.CallerOrganizationUnit,
            CallerPhone:                        referralDto.CallerPhone,
            CallNumber:                         referralDto.CallNumber,
            CauseOfDeathName:                   referralDto.CauseOfDeathName,
            MedicalHistory:                     referralDto.MedicalHistory,
            OrganizationName:                   referralDto.OrganizationName,
            PatientHasHeartbeat:                referralDto.PatientHasHeartbeat,
            ReferralBoneAppropriateId:          referralDto.ReferralBoneAppropriateId,
            ReferralDonorDeathDate:             referralDto.ReferralDonorDeathDate,
            ReferralDonorDeathTime:             referralDto.ReferralDonorDeathTime,
            ReferralDonorOnVentilator:          referralDto.ReferralDonorOnVentilator,
            ReferralEyesTransAppropriateId:     referralDto.ReferralEyesTransAppropriateId,
            ReferralOrganAppropriateId:         referralDto.ReferralOrganAppropriateId,
            ReferralSkinAppropriateId:          referralDto.ReferralSkinAppropriateId,
            ReferralTissueAppropriateId:        referralDto.ReferralTissueAppropriateId,
            ReferralTypeName:                   referralDto.ReferralTypeName,
            ReferralValvesAppropriateId:        referralDto.ReferralValvesAppropriateId,
            StatEmployee:                       referralDto.StatEmployee,
            SourceCode:                         referralDto.SourceCode,
            CallType:                           referralDto.CallType
            #pragma warning restore format
        )
        {
            LogEvents = referralDto.ReferralLogEvents
                .Select(CommonDtoTranslationExtensions.ToReferralLogEvent).ToImmutableArray()
        };
    }
}
