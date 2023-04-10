using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class UpdateDA : BaseDA
    {
    
    #region Private Fields
        private string callNumber;
        private string startDate;
        private string startTime;
        private string endDate;
        private string endTime;
        private string timeZone;
        private string organizationName;
        private string statAbbreviation;
        private string referralDonorFirstName;
        private string referralDonorLastName;
        private string currentReferralTypeName;
        private string previousReferralTypeName;
        private string sourceCodeName;
        private string statEmployeeFirstName;
        private string statEmployeeLastName;
        private int userOrganizationID;
        //vars
        private string callDateTime;
        private string toDateTime;
        #endregion

        #region Constructor
        public UpdateDA()
            : base("DashboardUpdateSelect")
		{
            SetTablesSelect("UpdatedReferralEvents");
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
        public string StatAbbreviation
        {
            get { return statAbbreviation; }
            set { statAbbreviation = value; }
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
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            callDateTime = startDate + " " + startTime;
            toDateTime = endDate + " " + endTime;
            //get diff between statline tz and user timezone and then adjust parms
            TimeZone userTZ = TimeZone.CurrentTimeZone;
            TimeSpan userTS = userTZ.GetUtcOffset(System.DateTime.Now);
            TimeSpan statlineTS = TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time").GetUtcOffset(Convert.ToDateTime(System.DateTime.Now));
            TimeSpan adjustedTS = statlineTS - userTS;
            commandWrapper.AddInParameterForSelect("timeZone", DbType.String, "MT");
            commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
            if (!string.IsNullOrEmpty(callNumber))
                commandWrapper.AddInParameterForSelect("callNumber", DbType.String, callNumber);
            if (!string.IsNullOrEmpty(startDate))
            {
                commandWrapper.AddInParameterForSelect("startDateTime", DbType.DateTime, Convert.ToDateTime(callDateTime).Add(adjustedTS));
                commandWrapper.AddInParameterForSelect("endDatetime", DbType.DateTime, Convert.ToDateTime(toDateTime).Add(adjustedTS));
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
            if (!string.IsNullOrEmpty(statAbbreviation))
                commandWrapper.AddInParameterForSelect("statAbbreviation", DbType.String, statAbbreviation);
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
            //if (!string.IsNullOrEmpty(userOrganizationID))
            //    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, userOrganizationID);
        }
        #endregion
    }
}
