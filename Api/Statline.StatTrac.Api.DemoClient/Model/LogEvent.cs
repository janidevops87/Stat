namespace Statline.StatTrac.Api.DemoClient.Model
{
    public sealed class LogEvent
    {
        internal LogEvent() { }
        public string CallNumber { get;  set; }
        public string LastModified { get;  set; }
        public string LogEventCreatedBy { get;  set; }
        public string LogEventDateTime { get;  set; }
        public string LogEventDesc { get;  set; }
        public int LogEventId { get;  set; }
        public string LogEventName { get;  set; }
        public string LogEventOrg { get;  set; }
        public string LogEventPhone { get;  set; }
        public int? LogEventTypeId { get;  set; }
        public string LogEventTypeName { get;  set; }
        public int? OrganizationId { get;  set; }
        public int? PersonId { get;  set; }
        public string ReferralEventAttnTo { get;  set; }
        public string ReferralEventCalloutAfter { get;  set; }
        public int? ReferralEventCalloutMin { get;  set; }
        public short? ReferralEventContactConfirm { get;  set; }
        public string ReferralEventDocName { get;  set; }
        public string ReferralEventFaxNbr { get;  set; }
        public int ReferralId { get;  set; }
    }
}
