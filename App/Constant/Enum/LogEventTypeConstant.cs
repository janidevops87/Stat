
namespace Statline.Stattrac.Constant.Enum
{
    public class LogEventTypeConstant
    {
        public enum EventType : int
        {
            Note = 1,
            IncomingCall = 2,
            OutgoingCall = 3,
            ConsentPending = 4,
            RecoveryPending = 5,
            PagePending = 6,
            ConsentOutcome = 7,
            RecoveryOutcome = 8,
            PageResponse = 9,
            NoConsentResponse = 10,
            NoPageResponse = 12,
            CoronerMEContact = 13,
            CalloutPending = 14,
            SecondaryPending = 15,
            SecondaryOutcome = 16,
            FaxPending = 18,
            OutgoingFax = 19,
            FuneralHome = 20,
            EmailPending = 21,
            EmailResponse = 22,
            UnmatchedResponse = 23,
            CaseUpdate = 24,
            QANote = 25,
            ManualRegistryChecked = 26,
            ConsentObtained = 27,
            PaperworkCompleted = 28,
            PaperworkFaxed = 29,
            FamilyApproached = 30,
            ClientConsentOutcome = 31,
            ClientRecoveryOutcome = 32,
            DELETEDEVENT = 33,
            IncomingSecondary = 34,
            IMConversation = 35,
            DonorCard = 36,
            DonorNetAcceptance = 37,
            DonorNetDecline = 38,
            AcknowledgetoEvaluate = 39,
            LabsPending = 40,
            LabsReceived = 41,
            NoLabsReceived = 42,
            OnlineReviewPending = 43,
            OnlineReviewResponse = 44,
            DeclaredCTODPending = 45,
            OrganMedROPending = 48,
            PendingEReferral = 55
        }
    }
}
