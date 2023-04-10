namespace Statline.StatTrac.BusinessVeracity.Common.Domain;

public enum ReferralLogEventType
{
    IncomingCall = 2,
    OutgoingCall = 3,
    PagePending = 6,
    ConsentOutcome = 7,
    RecoveryOutcome = 8,
    EmailPending = 21,
    CaseUpdate = 24,
    ConsentObtained = 27,
    EmailSent = 51,
    PageSent = 52
}
