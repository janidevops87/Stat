using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using System.Globalization;

using ContactDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Contacts.Contact;

using AgentDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Agents.Agent;

using DispositionDto =
    Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Dispositions.Disposition;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.CallInformation.InContactPreloaded;

internal static class DtoTranslationExtensions
{
    public static Contact ToContact(this ContactDto contactDto)
    {
        return new Contact
       (
            #pragma warning disable format
            AcwSeconds             : contactDto.ACWSeconds,
            AgentSeconds           : contactDto.agentSeconds,
            BusinessUnitId         : contactDto.businessUnitId,
            CallbackTime           : parseNullableFloat(contactDto.callbackTime),
            ConfSeconds            : contactDto.confSeconds,
            ContactId              : contactDto.contactId,
            ContactStart           : contactDto.contactStart,
            DateACWWarehoused      : contactDto.dateACWWarehoused,
            DateContactWarehoused  : contactDto.dateContactWarehoused,
            FirstName              : contactDto.firstName,
            LastName               : contactDto.lastName,
            FromAddr               : contactDto.fromAddr,
            HoldCount              : contactDto.holdCount,
            HoldSeconds            : contactDto.holdSeconds,
            InQueueSeconds         : contactDto.inQueueSeconds,
            IsOutbound             : contactDto.isOutbound,
            IsTakeover             : contactDto.isTakeover,
            IsWarehoused           : contactDto.isWarehoused,
            MasterContactId        : contactDto.masterContactId,
            PointOfContactName     : contactDto.pointOfContactName,
            PostQueueSeconds       : contactDto.postQueueSeconds,
            PreQueueSeconds        : contactDto.preQueueSeconds,
            PrimaryDispositionId   : contactDto.primaryDispositionId,
            ReleaseSeconds         : contactDto.releaseSeconds,
            SecondaryDispositionId : contactDto.secondaryDispositionId,
            ServiceLevelFlag       : parseInt(contactDto.serviceLevelFlag),
            SkillName              : contactDto.skillName,
            State                  : contactDto.state,
            ToAddr                 : contactDto.toAddr,
            TransferIndicatorName  : contactDto.transferIndicatorName
            #pragma warning restore format
         );

        static float? parseNullableFloat(string? value)
        {
            return Convert.ToSingle(value, CultureInfo.InvariantCulture);
        }

        static int parseInt(string value)
        {
            return Convert.ToInt32(value, CultureInfo.InvariantCulture);
        }
    }

    public static Agent ToAgent(this AgentDto dto)
    {
        return new Agent
        (
                #pragma warning disable format
                AgentId                   : dto.agentId,
                UserName                  : dto.userName,
                FirstName                 : dto.firstName,
                LastName                  : dto.lastName,
                UserID                    : dto.userID,
                EmailAddress              : dto.emailAddress,
                TeamName                  : dto.teamName,
                IsBillable                : dto.isBillable,
                ReportToName              : dto.reportToName,
                IsSupervisor              : dto.isSupervisor,
                LastLogin                 : dto.lastLogin,
                LastUpdated               : dto.lastUpdated,
                Location                  : dto.location,
                Custom1                   : dto.custom1,
                Custom2                   : dto.custom2,
                Custom3                   : dto.custom3,
                Custom4                   : dto.custom4,
                Custom5                   : dto.custom5,
                ProfileName               : dto.profileName,
                TimeZone                  : dto.timeZone,
                CountryName               : dto.countryName,
                State                     : dto.state,
                City                      : dto.city,
                DefaultDialingPatternName : dto.defaultDialingPatternName,
                MaxConcurrentChats        : dto.maxConcurrentChats,
                CreateDate                : dto.createDate,
                HireDate                  : dto.hireDate,
                HourlyCost                : dto.hourlyCost,
                RehireStatus              : dto.rehireStatus,
                EmploymentTypeName        : dto.employmentTypeName,
                Referral                  : dto.referral,
                AtHome                    : dto.atHome,
                HiringSource              : dto.hiringSource,
                NtLoginName               : dto.ntLoginName,
                SipUser                   : dto.sipUser,
                SystemUser                : dto.systemUser,
                SystemDomain              : dto.systemDomain,
                CrmUserName               : dto.crmUserName,
                UseAgentTimeZone          : dto.useAgentTimeZone,
                SendEmailNotifications    : dto.sendEmailNotifications,
                Telephone1                : dto.telephone1,
                Telephone2                : dto.telephone2,
                UserType                  : dto.userType,
                IsWhatIfAgent             : dto.isWhatIfAgent,
                TimeZoneOffset            : dto.timeZoneOffset,
                DeliveryMode              : dto.deliveryMode,
                AgentDeliveryMode         : dto.agentDeliveryMode);
                #pragma warning restore format
    }

    public static Disposition ToDisposition(this DispositionDto dto)
    { 
        return new Disposition(
                DispositionId: dto.dispositionId,
                DispositionName: dto.dispositionName);
    }

    public static ContactInfo ToContactInfo(
        this ApiClients.InContactApi.Dto.Contacts.CompletedContact dto)
    {
        return new ContactInfo(dto.contactId, dto.masterContactId);
    }
}
