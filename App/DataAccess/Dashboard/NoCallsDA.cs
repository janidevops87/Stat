using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class NoCallsDA : BaseDA
    {
        #region Private Fields
        private string callNumber;
        private string startDateTime;
        private string endDateTime;
        private string timeZone;
        private string organizationName;
        private string noCallTypeName;
        private string noCallDescription;
        private string sourceCodeName;
        private string statEmployeeFirstName;
        private string statEmployeeLastName;
        private int userOrganizationID;
        #endregion

        #region Constructor
        public NoCallsDA()
            : base("DashboardNoCallsSelect")
		{
            SetTablesSelect("NoCalls");
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
        public string NoCallTypeName
        {
            get { return noCallTypeName; }
            set { noCallTypeName = value; }
        }
        public string NoCallDescription
        {
            get { return noCallDescription; }
            set { noCallDescription = value; }
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
        public string SourceCodeName
        {
            get { return sourceCodeName; }
            set { sourceCodeName = value; }
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
            if (!string.IsNullOrEmpty(noCallTypeName))
                commandWrapper.AddInParameterForSelect("noCallTypeName", DbType.String, noCallTypeName);
            if (!string.IsNullOrEmpty(noCallDescription))
                commandWrapper.AddInParameterForSelect("noCallDescription", DbType.String, noCallDescription);
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
