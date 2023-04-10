using Statline.StatTrac.BusinessVeracity.Common.Domain;
using System.Collections.Immutable;
using LogEventDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto.LogEvent;
using ReferralDetailsDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto.ReferralDetails;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi;

public static class DtoTranslationExtensions
{
    public static ReferralDetails ToReferralDetails(this ReferralDetailsDto dto)
    {
        return new ReferralDetails
        (
            #pragma warning disable format
            CallId:                             dto.CallId,
            ReferralId:                         dto.ReferralId,
            CallDateTime :                      dto.CallDateTime,
            Caller:                             dto.Caller,
            CallerOrganizationUnit:             dto.CallerOrganizationUnit,
            CallerPhone:                        dto.CallerPhone,
            CallNumber:                         dto.CallNumber,
            CauseOfDeathName:                   dto.CauseOfDeathName,
            MedicalHistory:                     dto.MedicalHistory,
            OrganizationName:                   dto.OrganizationName,
            PatientHasHeartbeat:                dto.PatientHasHeartbeat,
            ReferralBoneAppropriateId:          dto.ReferralBoneAppropriateId,
            ReferralDonorDeathDate:             dto.ReferralDonorDeathDate,
            ReferralDonorDeathTime:             dto.ReferralDonorDeathTime,
            ReferralDonorOnVentilator:          dto.ReferralDonorOnVentilator,
            ReferralEyesTransAppropriateId:     dto.ReferralEyesTransAppropriateId,
            ReferralOrganAppropriateId:         dto.ReferralOrganAppropriateId,
            ReferralSkinAppropriateId:          dto.ReferralSkinAppropriateId,
            ReferralTissueAppropriateId:        dto.ReferralTissueAppropriateId,
            ReferralTypeName:                   dto.ReferralTypeName,
            ReferralValvesAppropriateId:        dto.ReferralValvesAppropriateId,
            StatEmployee:                       dto.StatEmployee,
            SourceCode:                         dto.SourceCode,
            CallType:                           dto.CallType
            #pragma warning restore format
        )
        {
            LogEvents = dto.ReferralLogEvents.Select(ToReferralLogEvent).ToImmutableArray()
        };
    }

    public static ReferralLogEvent ToReferralLogEvent(this LogEventDto dto)
    {
        return new ReferralLogEvent
        (
            #pragma warning disable format
            LogEventId:                     dto.LogEventId,
            ReferralId:                     dto.ReferralId,
            LogEventTypeId:                 (ReferralLogEventType?)dto.LogEventTypeId,
            LogEventTypeName:               dto.LogEventTypeName,
            LogEventDateTime:               dto.LogEventDateTime,
            LogEventPhone:                  dto.LogEventPhone,
            OrganizationId:                 dto.OrganizationId,
            LogEventOrg:                    dto.LogEventOrg,
            LogEventCreatedBy:              dto.LogEventCreatedBy
            #pragma warning restore format
        );
    }
}
