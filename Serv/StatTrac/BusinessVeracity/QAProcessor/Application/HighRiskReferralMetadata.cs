using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

public class HighRiskReferralMetadata
{
    public HighRiskReferralMetadata(
        HighRiskReferralDetails referral,
        ReferralLogEvent highRiskLogEvent,
        Contact contact,
        string? contactPrimaryDispositionName,
        string? contactSecondaryDispositionName,
        Agent agent,
        string audioData,
        string audioPath)
    {
        Referral = referral;
        HighRiskLogEvent = highRiskLogEvent;
        Contact = contact;
        ContactPrimaryDispositionName = contactPrimaryDispositionName;
        ContactSecondaryDispositionName = contactSecondaryDispositionName;
        Agent = agent;
        AudioData = audioData;
        AudioPath = audioPath;
    }

    public HighRiskReferralDetails Referral { get; }
    public ReferralLogEvent HighRiskLogEvent { get; }
    public Contact Contact { get; }
    public string? ContactPrimaryDispositionName { get; }
    public string? ContactSecondaryDispositionName { get; }
    public Agent Agent { get; }
    public string AudioData { get; }
    public string AudioPath { get; }
}
