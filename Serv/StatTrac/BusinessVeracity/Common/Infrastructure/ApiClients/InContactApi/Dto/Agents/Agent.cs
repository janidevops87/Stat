namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Agents;
#pragma warning disable IDE1006 // Naming Styles

// The docs at https://developer.niceincontact.com/API/AdminAPI#/Agents/get-agents
// state that many of the properties are required, however they can be null in practice,
// so I made them nullable.
public class Agent
{
    public bool? locked { get; set; }
    public string? userNameDomain { get; set; }
    public string? combinedUserNameDomain { get; set; }
    public int? rowNumber { get; set; }
    public int agentId { get; set; }
    public string userName { get; set; } = default!;
    public string firstName { get; set; } = default!;
    public string middleName { get; set; } = default!;
    public string lastName { get; set; } = default!;
    public string? userID { get; set; }
    public string? emailAddress { get; set; }
    public bool isActive { get; set; }
    public int teamId { get; set; }
    public string? teamName { get; set; }
    public bool? isBillable { get; set; }

    public int? reportToId { get; set; }
    public string reportToName { get; set; } = default!;
    public bool isSupervisor { get; set; }
    public DateTime? lastLogin { get; set; }
    public DateTime lastUpdated { get; set; }
    public string location { get; set; } = default!;
    public string custom1 { get; set; } = default!;
    public string custom2 { get; set; } = default!;
    public string custom3 { get; set; } = default!;
    public string custom4 { get; set; } = default!;
    public string custom5 { get; set; } = default!;
    public string internalId { get; set; } = default!;
    public int profileId { get; set; }
    public string profileName { get; set; } = default!;
    public string timeZone { get; set; } = default!;
    public string country { get; set; } = default!;
    public string countryName { get; set; } = default!;
    public string state { get; set; } = default!;
    public string city { get; set; } = default!;
    public int? chatRefusalTimeout { get; set; }
    public int? phoneRefusalTimeout { get; set; }
    public int? workItemRefusalTimeout { get; set; }
    public int? defaultDialingPattern { get; set; }
    public string defaultDialingPatternName { get; set; } = default!;
    public bool useTeamMaxConcurrentChats { get; set; }
    public int maxConcurrentChats { get; set; }
    public string notes { get; set; } = default!;
    public DateTime createDate { get; set; }
    public DateTime? inactiveDate { get; set; }
    public DateTime? hireDate { get; set; }
    public DateTime? terminationDate { get; set; }
    public decimal? hourlyCost { get; set; }
    public bool rehireStatus { get; set; }
    public int? employmentType { get; set; }
    public string? employmentTypeName { get; set; }
    public string? referral { get; set; }
    public bool? atHome { get; set; }
    public string? hiringSource { get; set; }
    public string? ntLoginName { get; set; }
    public bool? customerCard { get; set; }
    public int? scheduleNotification { get; set; }
    public string federatedId { get; set; } = default!;
    public bool? useTeamEmailAutoParkingLimit { get; set; }
    public int maxEmailAutoParkingLimit { get; set; }
    public string sipUser { get; set; } = default!;
    public string systemUser { get; set; } = default!;
    public string systemDomain { get; set; } = default!;
    public string crmUserName { get; set; } = default!;
    public bool? useAgentTimeZone { get; set; }
    public string? timeDisplayFormat { get; set; }
    public bool? sendEmailNotifications { get; set; }
    public string? apiKey { get; set; }
    public string? telephone1 { get; set; }
    public string? telephone2 { get; set; }
    public string? userType { get; set; }
    public bool? isWhatIfAgent { get; set; }
    public string? timeZoneOffset { get; set; }
    public bool? requestContact { get; set; }
    public int? chatThreshold { get; set; }
    public bool? useTeamChatThreshold { get; set; }
    public int? emailThreshold { get; set; }
    public bool? useTeamEmailThreshold { get; set; }
    public int? workItemThreshold { get; set; }
    public bool? useTeamWorkItemThreshold { get; set; }
    public bool? contactAutoFocus { get; set; }
    public bool? useTeamContactAutoFocus { get; set; }
    public bool? useTeamRequestContact { get; set; }
    public string? subject { get; set; }
    public string? issuer { get; set; }
    public RecordingNumber[] recordingNumbers { get; set; } = default!;
    public bool? isOpenIdProfileComplete { get; set; }
    public string? teamUuId { get; set; }
    public bool? maxPreview { get; set; }
    public string? deliveryMode { get; set; }
    public int? totalContactCount { get; set; }
    public bool? useTeamDeliveryModeSettings { get; set; }
    public int? emailRefusalTimeout { get; set; }
    public int? voicemailRefusalTimeout { get; set; }
    public int? smsRefusalTimeout { get; set; }
    public int? agentvoiceThreshold { get; set; }
    public int? agentchatThreshold { get; set; }
    public int? agentemailThreshold { get; set; }
    public int? agentworkItemThreshold { get; set; }
    public string? agentDeliveryMode { get; set; }
    public int? agentTotalContactCount { get; set; }
    public bool? agentRequestContact { get; set; }
    public bool? agentContactAutoFocus { get; set; }
    public bool? useTeamVoiceThreshold { get; set; }
    public int? voiceThreshold { get; set; }
    public IntegratedSoftPhoneWebRtcUrls[] integratedSoftphoneWebRtcUrls { get; set; } = default!;
}
