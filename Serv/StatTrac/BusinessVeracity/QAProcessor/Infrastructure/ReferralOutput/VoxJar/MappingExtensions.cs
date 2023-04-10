using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;
using System.Dynamic;
using System.Globalization;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;

internal static class MappingExtensions
{
    public static IDictionary<string, object?> ToMetadataDictionary(this Agent agent)
    {
        dynamic metadata = new ExpandoObject();

        #pragma warning disable format
        metadata.TeamName                           = agent.TeamName;
        metadata.InContactLocation                  = agent.Location;
        metadata.InContactReportsTo                 = agent.ReportToName;
        metadata.InContactProfileName               = agent.ProfileName;
        metadata.InContactIsSupervisor              = agent.IsSupervisor;
        metadata.InContactTimeZoneOffset            = agent.TimeZoneOffset;
        metadata.InContactID                        = agent.AgentId.ToString(CultureInfo.InvariantCulture);
        metadata.InContactIsBillable                = agent.IsBillable;
        metadata.InContactUserName                  = agent.UserName;
        metadata.InContactUserID                    = agent.UserID;
        metadata.InContactLastLogin                 = agent.LastLogin;
        metadata.InContactLastUpdated               = agent.LastUpdated;
        metadata.InContactCustom1                   = agent.Custom1;
        metadata.InContactCustom2                   = agent.Custom2;
        metadata.InContactCustom3                   = agent.Custom3;
        metadata.InContactCustom4                   = agent.Custom4;
        metadata.InContactCustom5                   = agent.Custom5;
        metadata.InContactTimeZone                  = agent.TimeZone;
        metadata.InContactCountryName               = agent.CountryName;
        metadata.InContactState                     = agent.State;
        metadata.InContactCity                      = agent.City;
        metadata.InContactDefaultDialingPatternName = agent.DefaultDialingPatternName;
        metadata.InContactMaxConcurrentChats        = agent.MaxConcurrentChats;
        metadata.InContactCreateData                = agent.CreateDate;
        metadata.InContactHireDate                  = agent.HireDate;
        metadata.InContactHourlyCost                = agent.HourlyCost;
        metadata.InContactRehireStatus              = agent.RehireStatus;
        metadata.InContactEmplymentType             = agent.EmploymentTypeName;
        metadata.InContactReferral                  = agent.Referral;
        metadata.InContactAtHome                    = agent.AtHome;
        metadata.InContactHiringSource              = agent.HiringSource;
        metadata.InContactNtLoginName               = agent.NtLoginName;
        metadata.InContactSipUser                   = agent.SipUser;
        metadata.InContactSystemUser                = agent.SystemUser;
        metadata.InContactSystemDomain              = agent.SystemDomain;
        metadata.InContactCrmUserName               = agent.CrmUserName;
        metadata.InContactUseAgentTimeZone          = agent.UseAgentTimeZone;
        metadata.InContactSendEmailNotifications    = agent.SendEmailNotifications;
        metadata.InContactTelephone1                = agent.Telephone1;
        metadata.InContactTelephone2                = agent.Telephone2;
        metadata.InContactUserType                  = agent.UserType;
        metadata.InContactIsWhatIfAgent             = agent.IsWhatIfAgent;
        metadata.InContactDeliveryMode              = agent.DeliveryMode;
        metadata.InContactAgentDeliveryMode         = agent.AgentDeliveryMode;
        #pragma warning restore format

        return metadata;
    }

    public static void PopulateMetadata(this Contact contact, string? contactSecondaryDispositionName, string audioPath, dynamic metadata)
    {
#pragma warning disable format
        metadata.Skill                  = contact.SkillName;
        metadata.AgentPhone             = contact.IsOutbound ? contact.ToAddr : contact.FromAddr;
        metadata.AcwSeconds             = contact.AcwSeconds;
        metadata.AgentSeconds           = (float)contact.AgentSeconds;
        metadata.BusinessUnitID         = contact.BusinessUnitId;
        metadata.CallbackTime           = contact.CallbackTime;
        metadata.ConfSeconds            = (float)contact.ConfSeconds;
        metadata.DateACWWarehoused      = contact.DateACWWarehoused;
        metadata.DateContactWarehoused  = contact.DateContactWarehoused;
        metadata.FromAddress            = contact.FromAddr;
        metadata.ToAddress              = contact.ToAddr;
        metadata.HoldCount              = contact.HoldCount;
        metadata.HoldSeconds            = (float)contact.HoldSeconds;
        metadata.InQueueSeconds         = (float)contact.InQueueSeconds;
        metadata.IsTakeover             = contact.IsTakeover;
        metadata.IsWarehoused           = contact.IsWarehoused;
        metadata.PointOfContact         = contact.PointOfContactName;
        metadata.PostQueueSeconds       = (float)contact.PostQueueSeconds;
        metadata.PreQueueSeconds        = (float)contact.PreQueueSeconds;
        metadata.ReleaseSeconds         = (float)contact.ReleaseSeconds;
        metadata.ServiceLevelFlag       = contact.ServiceLevelFlag;
        metadata.State                  = contact.State;
        metadata.TransferIndicator      = contact.TransferIndicatorName;
        metadata.SecondaryDisposition   = contactSecondaryDispositionName;
        metadata.FileType               = Path.GetExtension(audioPath).TrimStart('.');
#pragma warning restore format
    }

    public static void PopulateMetadata(this ReferralLogEvent referralLogEvent, dynamic metadata)
    {
#pragma warning disable format
        metadata.ReferralEventTypeID         = referralLogEvent.LogEventTypeId;
        metadata.ReferralEventType           = referralLogEvent.LogEventTypeName;
        metadata.ReferralEventDateTime       = referralLogEvent.LogEventDateTime;
        metadata.ReferralEventPhone          = referralLogEvent.LogEventPhone;
        metadata.ReferralEventOrganizationID = referralLogEvent.OrganizationId;
        metadata.ReferralEventOrganization   = referralLogEvent.LogEventOrg;
        metadata.ReferralEventCreatedBy      = referralLogEvent.LogEventCreatedBy;
#pragma warning restore format
    }

    public static void PopulateMetadata(
        this HighRiskReferralDetails referralDetails, 
        dynamic metadata)
    {
#pragma warning disable format
        metadata.ReferralNumber          = referralDetails.CallNumber;
        metadata.ReferralDateTime        = referralDetails.CallDateTime;
        metadata.ReferralTakenBy         = referralDetails.StatEmployee;
        metadata.ReferralType            = referralDetails.ReferralTypeName;
        metadata.CallerPhone             = referralDetails.CallerPhone;
        metadata.CallerName              = referralDetails.Caller;
        metadata.CallerOrganization      = referralDetails.OrganizationName;
        metadata.CallerOrganizationUnit  = referralDetails.CallerOrganizationUnit;
        metadata.PatientCauseOfDeath     = referralDetails.CauseOfDeathName;
        metadata.PatientOnVentilator     = referralDetails.ReferralDonorOnVentilator;
        metadata.PatientDeathDate        = referralDetails.ReferralDonorDeathDate;
        metadata.PatientDeathTime        = referralDetails.ReferralDonorDeathTime;
        metadata.AppropriateOrganID      = referralDetails.ReferralOrganAppropriateId;
        metadata.AppropriateBoneID       = referralDetails.ReferralBoneAppropriateId;
        metadata.AppropriateSoftTissueID = referralDetails.ReferralTissueAppropriateId;
        metadata.AppropriateSkinID       = referralDetails.ReferralSkinAppropriateId;
        metadata.AppropriateValvesID     = referralDetails.ReferralValvesAppropriateId;
        metadata.AppropriateEyesID       = referralDetails.ReferralEyesTransAppropriateId;
        metadata.PatientHasHeartbeat     = referralDetails.PatientHasHeartbeat;
        metadata.MedicalHistory          = referralDetails.MedicalHistory;
        metadata.CallType                = referralDetails.CallType;
        metadata.SourceCode              = referralDetails.SourceCode;
        metadata.HighRiskType            = referralDetails.HighRiskType;
#pragma warning restore format
    }

}
