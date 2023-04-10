using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class MessageandImportDA : BaseDA
    {
        #region Private Fields
        private string callNumber;
        private string startDateTime;
        private string endDateTime;
        private string timeZone;
        private string organizationName;
        private string optn;
        private string messageType;
        private string referralDonorFirstName;
        private string referralDonorLastName;
        private string messageCallerName;
        private string messageCallerOrganization;
        private string sourceCodeName;
        private string statEmployeeFirstName;
        private string statEmployeeLastName;
        private int userOrganizationID;
        #endregion

        #region Constructor
        public MessageandImportDA()
            : base("DashboardMessagesandImportsSelect")
		{
            SetTablesSelect("MessagesandImports");
        }
        #endregion

        #region Public Properties
        public string CallNumber
        {
            get { return callNumber; }
            set { callNumber = value; }
        }
        public string StartDateTime
        {
            get { return startDateTime; }
            set { startDateTime = value; }
        }
        public string EndDateTime
        {
            get { return endDateTime; }
            set { endDateTime = value; }
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
        public string MessageType
        {
            get { return messageType; }
            set { messageType = value; }
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
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            //get diff between statline tz and user timezone and then adjust parms
            TimeZone userTZ = TimeZone.CurrentTimeZone;
            TimeSpan userTS = userTZ.GetUtcOffset(System.DateTime.Now);
            TimeSpan statlineTS = TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time").GetUtcOffset(Convert.ToDateTime(System.DateTime.Now));
            TimeSpan adjustedTS = statlineTS - userTS;
            commandWrapper.AddInParameterForSelect("timeZone", DbType.String, "MT");
            commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
            if (!string.IsNullOrEmpty(callNumber))
                commandWrapper.AddInParameterForSelect("callNumber", DbType.String, callNumber);
            if (!string.IsNullOrEmpty(startDateTime))
            {
                commandWrapper.AddInParameterForSelect("startDateTime", DbType.DateTime, Convert.ToDateTime(StartDateTime).Add(adjustedTS));
                commandWrapper.AddInParameterForSelect("endDatetime", DbType.DateTime, Convert.ToDateTime(EndDateTime).Add(adjustedTS));
            }
            else
            {
                commandWrapper.AddInParameterForSelect("startDateTime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) - System.TimeSpan.FromHours(12));
                commandWrapper.AddInParameterForSelect("endDatetime", DbType.DateTime, System.DateTime.Now.Add(adjustedTS) + System.TimeSpan.FromHours(12));
            }
            if (!string.IsNullOrEmpty(timeZone))
                commandWrapper.AddInParameterForSelect("timeZone", DbType.String, "MT");
            if (!string.IsNullOrEmpty(organizationName))
                commandWrapper.AddInParameterForSelect("organizationName", DbType.String, organizationName);
            if (!string.IsNullOrEmpty(MessageType))
                commandWrapper.AddInParameterForSelect("messageType", DbType.String, messageType);
            if (!string.IsNullOrEmpty(Optn))
                commandWrapper.AddInParameterForSelect("optn", DbType.String, optn);
            if (!string.IsNullOrEmpty(MessageCallerName))
                commandWrapper.AddInParameterForSelect("messageCallerName", DbType.String, messageCallerName);
            if (!string.IsNullOrEmpty(MessageCallerOrganization))
                commandWrapper.AddInParameterForSelect("messageCallerOrganization", DbType.String, messageCallerOrganization);
            if (!string.IsNullOrEmpty(referralDonorFirstName))
                commandWrapper.AddInParameterForSelect("referralDonorFirstName", DbType.String, referralDonorFirstName);
            if (!string.IsNullOrEmpty(referralDonorLastName))
                commandWrapper.AddInParameterForSelect("referralDonorLastName", DbType.String, referralDonorLastName);
            if (!string.IsNullOrEmpty(sourceCodeName))
                commandWrapper.AddInParameterForSelect("sourceCodeName", DbType.String, sourceCodeName);
            if (!string.IsNullOrEmpty(statEmployeeFirstName))
                commandWrapper.AddInParameterForSelect("statEmployeeFirstName", DbType.String, statEmployeeFirstName);
            if (!string.IsNullOrEmpty(statEmployeeLastName))
                commandWrapper.AddInParameterForSelect("statEmployeeLastName", DbType.String, statEmployeeLastName);
            //if (!string.IsNullOrEmpty(userOrganizationID))
            //    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, userOrganizationID);
        }
        #endregion
    }
}
