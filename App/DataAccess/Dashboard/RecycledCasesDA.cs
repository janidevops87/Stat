using System;
using System.Data;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public enum RecycleDASprocs
    {
        spi_CallRecycleSuspend,
        spi_CallRecycleRestore,
        DashboardRecycledOasisUpdate,
        DashboardRecycledCasesSelect,
        DashboardRecycledMessagesSelect,
        DashboardRecycledOasisSelect
    }
    public class RecycledCasesDA : BaseDA
    {
        #region Private Fields
        private string callNumber;
        private string startDate;
        private string startTime;
        private string endDate;
        private string endTime;
        private string timeZone;
        private string organizationName;
        private string referralDonorFirstName;
        private string referralDonorLastName;
        private string currentReferralTypeName;
        private string previousReferralTypeName;
        private string sourceCodeName;
        private string statEmployeeFirstName;
        private string statEmployeeLastName;
        private int userOrganizationID;
        private string optn;
        private string messageType;
        private string messageCallerName;
        private string messageCallerOrganization;
        private string client;
        private string importOfferNumber;
        private string referralNumber;
        private string organType;
        private string optnNumber;
        private string matchId;
        private string transplantSurgeonContact;
        private string clinicalCoordinator;
        //vars
        private string callDateTime;
        private string toDateTime;
        public int CallID { get; set; }
        public int LastPersonID { get; set; }
        public int InactiveFlag { get; set; }
        
        #endregion

        #region Constructor
        public RecycledCasesDA()
            : base(RecycleDASprocs.DashboardRecycledCasesSelect.ToString())
            
		{
            SetDefaultTablesSelect();
        }

        public void SetDefaultTablesSelect()
        {

            SpSelect = RecycleDASprocs.DashboardRecycledCasesSelect.ToString();
            SetTablesSelect(
                "RecycledCases");
        }
        #endregion

        #region Public Properties
        public string CallNumber
        {
            get { return callNumber; }
            set { callNumber = value; }
        }
        public string StartDate
        {
            get { return startDate; }
            set { startDate = value; }
        }
        public string StartTime
        {
            get { return startTime; }
            set { startTime = value; }
        }
        public string EndDate
        {
            get { return endDate; }
            set { endDate = value; }
        }
        public string EndTime
        {
            get { return endTime; }
            set { endTime = value; }
        }
        public string ReferralDonorFirstName
        {
            get { return referralDonorFirstName; }
            set { referralDonorFirstName = value; }
        }
        public string ReferralDonorLastName
        {
            get { return referralDonorLastName; }
            set { referralDonorLastName = value; }
        }
        public string OrganizationName
        {
            get { return organizationName; }
            set { organizationName = value; }
        }
        public string SourceCodeName
        {
            get { return sourceCodeName; }
            set { sourceCodeName = value; }
        }
        public string PreviousReferralTypeName
        {
            get { return previousReferralTypeName; }
            set { previousReferralTypeName = value; }
        }
        public string CurrentReferralTypeName
        {
            get { return currentReferralTypeName; }
            set { currentReferralTypeName = value; }
        }
        public string StatEmployeeFirstName
        {
            get { return statEmployeeFirstName; }
            set { statEmployeeFirstName = value; }
        }
        public string StatEmployeeLastName
        {
            get { return statEmployeeLastName; }
            set { statEmployeeLastName = value; }
        }
        public string Optn
        {
            get { return optn; }
            set { optn = value; }
        }
        public string MessageCallerName
        {
            get { return messageCallerName; }
            set { messageCallerName = value; }
        }
        public string MessageCallerOrganization
        {
            get { return messageCallerOrganization; }
            set { messageCallerOrganization = value; }
        }
        public string Client
        {
            get { return client; }
            set { client = value; }
        }
        public string ImportOfferNumber
        {
            get { return importOfferNumber; }
            set { importOfferNumber = value; }
        }
        public string ReferralNumber
        {
            get { return referralNumber; }
            set { referralNumber = value; }
        }
        public string OrganType
        {
            get { return organType; }
            set { organType = value; }
        }
        public string OptnNumber
        {
            get { return optnNumber; }
            set { optnNumber = value; }
        }
        public string MatchId
        {
            get { return matchId; }
            set { matchId = value; }
        }
        public string TransplantSurgeonContact
        {
            get { return transplantSurgeonContact; }
            set { transplantSurgeonContact = value; }
        }
        public string ClinicalCoordinator
        {
            get { return clinicalCoordinator; }
            set { clinicalCoordinator = value; }
        }
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            //get diff between statline tz and user timezone and then adjust parms
            TimeZone userTZ = TimeZone.CurrentTimeZone;
            TimeSpan userTS = userTZ.GetUtcOffset(System.DateTime.Now);
            TimeSpan statlineTS = TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time").GetUtcOffset(Convert.ToDateTime(System.DateTime.Now));
            TimeSpan adjustedTS = statlineTS - userTS;
            switch ((RecycleDASprocs)Enum.Parse(typeof(RecycleDASprocs), SpSelect, true))
            {
                case RecycleDASprocs.spi_CallRecycleSuspend:
                    commandWrapper.AddInParameterForSelect("callId", DbType.Int32, CallID);
                    commandWrapper.AddInParameterForSelect("callSaveLastByID", DbType.Int32, LastPersonID);
                    break;
                case RecycleDASprocs.spi_CallRecycleRestore:
                    commandWrapper.AddInParameterForSelect("callId", DbType.Int32, CallID);
                    commandWrapper.AddInParameterForSelect("lastStatEmployeeID", DbType.Int32, LastPersonID);
                    break;
                case RecycleDASprocs.DashboardRecycledCasesSelect:
                    callDateTime = startDate + " " + startTime;
                    toDateTime = endDate + " " + endTime;
                    commandWrapper.AddInParameterForSelect("timezone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
                    if (!string.IsNullOrEmpty(callNumber))
                        commandWrapper.AddInParameterForSelect("callNumber", DbType.String, callNumber);
                    if (!string.IsNullOrEmpty(startDate))
                    {
                        commandWrapper.AddInParameterForSelect("StartDateTime", DbType.DateTime, Convert.ToDateTime(callDateTime).Add(adjustedTS));
                        commandWrapper.AddInParameterForSelect("EndDateTime", DbType.DateTime, Convert.ToDateTime(toDateTime).Add(adjustedTS));
                    }
                    else
                    {
                        commandWrapper.AddInParameterForSelect("StartDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) - System.TimeSpan.FromHours(12));
                        commandWrapper.AddInParameterForSelect("EndDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) + System.TimeSpan.FromHours(12));
                    }
                    if (!string.IsNullOrEmpty(timeZone))
                        commandWrapper.AddInParameterForSelect("timezone", DbType.String, "MT");
                    if (!string.IsNullOrEmpty(organizationName))
                        commandWrapper.AddInParameterForSelect("organizationName", DbType.String, organizationName);
                    if (!string.IsNullOrEmpty(referralDonorFirstName))
                        commandWrapper.AddInParameterForSelect("referralDonorFirstName", DbType.String, referralDonorFirstName);
                    if (!string.IsNullOrEmpty(referralDonorLastName))
                        commandWrapper.AddInParameterForSelect("referralDonorLastName", DbType.String, referralDonorLastName);
                    if (!string.IsNullOrEmpty(currentReferralTypeName))
                        commandWrapper.AddInParameterForSelect("currentReferralTypeName", DbType.String, currentReferralTypeName);
                    if (!string.IsNullOrEmpty(previousReferralTypeName))
                        commandWrapper.AddInParameterForSelect("previousReferralTypeName", DbType.String, previousReferralTypeName);
                    if (!string.IsNullOrEmpty(sourceCodeName))
                        commandWrapper.AddInParameterForSelect("sourceCodeName", DbType.String, sourceCodeName);
                    if (!string.IsNullOrEmpty(statEmployeeFirstName))
                        commandWrapper.AddInParameterForSelect("statEmployeeFirstName", DbType.String, statEmployeeFirstName);
                    if (!string.IsNullOrEmpty(statEmployeeLastName))
                        commandWrapper.AddInParameterForSelect("statEmployeeLastName", DbType.String, statEmployeeLastName);
                    break;
                case RecycleDASprocs.DashboardRecycledMessagesSelect:
                    callDateTime = startDate + " " + startTime;
                    toDateTime = endDate + " " + endTime;
                    commandWrapper.AddInParameterForSelect("timezone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
                    if (!string.IsNullOrEmpty(callNumber))
                        commandWrapper.AddInParameterForSelect("callNumber", DbType.String, callNumber);
                    if (!string.IsNullOrEmpty(startDate))
                    {
                        commandWrapper.AddInParameterForSelect("StartDateTime", DbType.DateTime, Convert.ToDateTime(callDateTime).Add(adjustedTS));// - System.TimeSpan.FromHours(12));
                        commandWrapper.AddInParameterForSelect("EndDateTime", DbType.DateTime, Convert.ToDateTime(toDateTime).Add(adjustedTS));// + System.TimeSpan.FromHours(12));
                    }
                    else
                    {
                        commandWrapper.AddInParameterForSelect("StartDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) - System.TimeSpan.FromHours(12));
                        commandWrapper.AddInParameterForSelect("EndDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) + System.TimeSpan.FromHours(12));
                    }
                    if (!string.IsNullOrEmpty(organizationName))
                        commandWrapper.AddInParameterForSelect("organizationName", DbType.String, organizationName);
                    if (!string.IsNullOrEmpty(referralDonorFirstName))
                        commandWrapper.AddInParameterForSelect("referralDonorFirstName", DbType.String, referralDonorFirstName);
                    if (!string.IsNullOrEmpty(referralDonorLastName))
                        commandWrapper.AddInParameterForSelect("referralDonorLastName", DbType.String, referralDonorLastName);
                    if (!string.IsNullOrEmpty(currentReferralTypeName))
                        commandWrapper.AddInParameterForSelect("currentReferralTypeName", DbType.String, currentReferralTypeName);
                    if (!string.IsNullOrEmpty(sourceCodeName))
                        commandWrapper.AddInParameterForSelect("sourceCodeName", DbType.String, sourceCodeName);
                    if (!string.IsNullOrEmpty(Optn))
                        commandWrapper.AddInParameterForSelect("optn", DbType.String, optn);
                    if (!string.IsNullOrEmpty(MessageCallerName))
                        commandWrapper.AddInParameterForSelect("messageCallerName", DbType.String, messageCallerName);
                    if (!string.IsNullOrEmpty(MessageCallerOrganization))
                        commandWrapper.AddInParameterForSelect("messageCallerOrganization", DbType.String, messageCallerOrganization);
                    if (!string.IsNullOrEmpty(statEmployeeFirstName))
                        commandWrapper.AddInParameterForSelect("statEmployeeFirstName", DbType.String, statEmployeeFirstName);
                    if (!string.IsNullOrEmpty(statEmployeeLastName))
                        commandWrapper.AddInParameterForSelect("statEmployeeLastName", DbType.String, statEmployeeLastName);
                    break;
                case RecycleDASprocs.DashboardRecycledOasisSelect:
                    callDateTime = startDate + " " + startTime;
                    toDateTime = endDate + " " + endTime;
                    commandWrapper.AddInParameterForSelect("timezone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
                    if (!string.IsNullOrEmpty(callNumber))
                        commandWrapper.AddInParameterForSelect("callNumber", DbType.String, callNumber);
                    if (!string.IsNullOrEmpty(startDate))
                    {
                        commandWrapper.AddInParameterForSelect("StartDateTime", DbType.DateTime, Convert.ToDateTime(callDateTime).Add(adjustedTS));// - System.TimeSpan.FromHours(12));
                        commandWrapper.AddInParameterForSelect("EndDateTime", DbType.DateTime, Convert.ToDateTime(toDateTime).Add(adjustedTS));// + System.TimeSpan.FromHours(12));
                    }
                    else
                    {
                        commandWrapper.AddInParameterForSelect("StartDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) - System.TimeSpan.FromHours(12));
                        commandWrapper.AddInParameterForSelect("EndDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) + System.TimeSpan.FromHours(12));
                    }
                    if (!string.IsNullOrEmpty(organizationName))
                        commandWrapper.AddInParameterForSelect("organizationName", DbType.String, organizationName);
                    if (!string.IsNullOrEmpty(referralDonorFirstName))
                        commandWrapper.AddInParameterForSelect("referralDonorFirstName", DbType.String, referralDonorFirstName);
                    if (!string.IsNullOrEmpty(referralDonorLastName))
                        commandWrapper.AddInParameterForSelect("referralDonorLastName", DbType.String, referralDonorLastName);
                    if (!string.IsNullOrEmpty(client))
                        commandWrapper.AddInParameterForSelect("Client", DbType.String, client);
                    if (!string.IsNullOrEmpty(importOfferNumber))
                        commandWrapper.AddInParameterForSelect("ImportOfferNumber", DbType.String, importOfferNumber);
                    if (!string.IsNullOrEmpty(referralNumber))
                        commandWrapper.AddInParameterForSelect("ReferralNumber", DbType.String, referralNumber);
                    if (!string.IsNullOrEmpty(organType))
                        commandWrapper.AddInParameterForSelect("OrganType", DbType.String, organType);
                    if (!string.IsNullOrEmpty(optnNumber))
                        commandWrapper.AddInParameterForSelect("OptnNumber", DbType.String, optnNumber);
                    if (!string.IsNullOrEmpty(matchId))
                        commandWrapper.AddInParameterForSelect("MatchId", DbType.String, matchId);
                    if (!string.IsNullOrEmpty(transplantSurgeonContact))
                        commandWrapper.AddInParameterForSelect("TransplantSurgeonContact", DbType.String, transplantSurgeonContact);
                    if (!string.IsNullOrEmpty(clinicalCoordinator))
                        commandWrapper.AddInParameterForSelect("ClinicalCoordinator", DbType.String, clinicalCoordinator);
                    if (!string.IsNullOrEmpty(statEmployeeFirstName))
                        commandWrapper.AddInParameterForSelect("statEmployeeFirstName", DbType.String, statEmployeeFirstName);
                    if (!string.IsNullOrEmpty(statEmployeeLastName))
                        commandWrapper.AddInParameterForSelect("statEmployeeLastName", DbType.String, statEmployeeLastName);
                    break;
                case RecycleDASprocs.DashboardRecycledOasisUpdate:
                    commandWrapper.AddInParameterForSelect("CallID", DbType.Int32, CallID);
                    commandWrapper.AddInParameterForSelect("Inactive", DbType.Int32, InactiveFlag);
                    commandWrapper.AddInParameterForSelect("LastStatEmployeeID", DbType.Int32, LastPersonID);
                    break;
            }
                //if (!string.IsNullOrEmpty(userOrganizationID))
                //    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, userOrganizationID);
        }
        protected override void GetParameterValuesPostExecuteNonQuery(System.Data.Common.DbParameterCollection dbParameters)
        {
            switch ((RecycleDASprocs)Enum.Parse(typeof(RecycleDASprocs), SpSelect, true))
            {
                case RecycleDASprocs.spi_CallRecycleRestore:
                    break;
                case RecycleDASprocs.spi_CallRecycleSuspend:
                    break;
            }
        }
        public void CallRecycleType (int RecycleTypeID)
        {
            switch (RecycleTypeID)
            {
                case 1:
                    SpSelect = RecycleDASprocs.DashboardRecycledCasesSelect.ToString();
                    break;
                case 2:
                    SpSelect = RecycleDASprocs.DashboardRecycledMessagesSelect.ToString();
                    break;
                case 4:
                    SpSelect = RecycleDASprocs.DashboardRecycledMessagesSelect.ToString();
                    break;
                case 6:
                    SpSelect = RecycleDASprocs.DashboardRecycledOasisSelect.ToString();
                    break;
            }

        }
        public void CallRecycleRestore()
        {
            SpSelect = RecycleDASprocs.spi_CallRecycleRestore.ToString();
        }
        public void CallRecycleDelete()
        {
            SpSelect = RecycleDASprocs.spi_CallRecycleSuspend.ToString();
        }
        public void CallRecycleUpdateOasis()
        {
            SpSelect = RecycleDASprocs.DashboardRecycledOasisUpdate.ToString();
        }
        #endregion
    }
}
