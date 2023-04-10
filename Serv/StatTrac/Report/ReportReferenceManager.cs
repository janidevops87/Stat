using System;
using Statline.StatTrac.Data.Report;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Report
{
	/// <summary>
	/// Summary description for ReportReferenceManager.
	/// </summary>
	public class ReportReferenceManager
    {
        #region Alert
        public static ReportReferenceData.AlertListDataTable FillAlertList()
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                Statline.StatTrac.Data.Report.ReportReferenceDB.FillAlertList(ds);
            }
            catch
            {
                throw;
            }

            return ds.AlertList;
        }
        public static ReportReferenceData.AlertListDataTable FillAlertList(Int32 alertTypeId, string sourceCodeName)
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                Statline.StatTrac.Data.Report.ReportReferenceDB.FillAlertList(ds, alertTypeId, sourceCodeName);
            }
            catch
            {
                throw;
            }

            return ds.AlertList;
        }


        #endregion

        #region Cause Of Death

        public static void FillReportCauseOfDeathList(
			ReportReferenceData ds
			)
		{
            try
            {
                ReportReferenceDB.FillReportCauseOfDeathList(
                ds
                );
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region Report DateTime
		public static void GetReportDateTime(
			int reportID,
			out DateTime startDateTime,
			out DateTime endDateTime,
            out DateTime archiveDateTime,
            out Boolean isDateOnly)
		{
			try
            {
                ReportReferenceDB.GetReportDateTime(
				reportID,
				out startDateTime,
				out endDateTime,
                out archiveDateTime,
                out isDateOnly);

            }
            catch
            {
                throw;
            }

		}

		#endregion
		
		#region UserInformaiton and Authenticatin

		public static void SetUserReportInformation(string userName,
		                                            string passWord,
                                                    string sessionId,
                                                    ref int userID,
                                                    ref int organizationID,
                                                    ref string userDisplayName,
                                                    ref string userOrganizationName,
                                                    ref int statEmployeeID,
                                                    ref string timeZone
			)
		{
            try
            {
                ReportReferenceDB.GetWebPersonInformation(
				    userName,
				    passWord,
                    sessionId,
                    ref userID,
                    ref organizationID,
                    ref userDisplayName,
                    ref userOrganizationName,
                    ref statEmployeeID,
                    ref timeZone);
            }
            catch
            {
                throw;
            }

        }

		public static bool Authenticate(
			int userID,
			int userOrgID,
			out string userName,
			out string userDisplayName,
			out string userOrganizationName)
		{
			bool authenticated = false;
			userName = "";
            
            try{
                ReportReferenceDB.GetUserName(
				    userID,
				    userOrgID,
				    out userName,
				    out userDisplayName,
				    out userOrganizationName);

			    if (userName.Length == 0)
				    return authenticated;
			    {
				    authenticated = true;
			    }
            }
            catch
            {
                throw;
            }

			return authenticated;
		}

		#endregion

		#region Organization

		public static void FillOrganizationList(
			ReportReferenceData ds,
			int reportGroupID
			)
		{
            try
            {
			    ReportReferenceDB.FillOrganizationList(
				    ds,
				    reportGroupID
				    );
            }
            catch
            {
                throw;
            }

        }
        public static ReportReferenceData.OrganizationListDataTable FillOrganzationList(int reportGroupID)
        {
            ReportReferenceData dataSet = new ReportReferenceData();

            try
            {
                FillOrganizationList(dataSet, reportGroupID);
            }
            catch
            {
                throw;
            }

            return dataSet.OrganizationList;
        }
        public static ReportReferenceData.OrganizationListDataTable FillOrganizationList(
            string sourceCode,
            int sourceCodeType,
            int organizationID)
        {
            ReportReferenceData ds = new ReportReferenceData();

            try
            {
                ReportReferenceDB.FillOrganizationList(
                    ds, 
                    sourceCode,
                    sourceCodeType,
                    organizationID
                    );
            }
            catch
            {
                throw;
            }

            return ds.OrganizationList;

        }


		#endregion

        #region Person
        public static ReportReferenceData.PersonListDataTable FillPersonList(int organizationId)
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                Statline.StatTrac.Data.Report.ReportReferenceDB.FillPersonList(ds, organizationId);
            }
            catch
            {
                throw;
            }

            return ds.PersonList;
        }
        #endregion

        #region PersonTitle
        public static ReportReferenceData.PersonTitleListDataTable FillPersonTitleList(int organizationID,int personTypeID)
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                Statline.StatTrac.Data.Report.ReportReferenceDB.FillPersonTitleList(ds, organizationID, personTypeID);
            }
            catch
            {
                throw;
            }

            return ds.PersonTitleList;
        }
        #endregion
        #region ReportGroup

        public static void FillReportGroupList(
			ReportReferenceData ds,
			int userOrgID
			)
		{
            try
            {
                ReportReferenceDB.FillReportGroupList(
				ds,
				userOrgID
				);
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region SourceCode
        public static ReportReferenceData.SourceCodeNameListDataTable FillReportSourceCodeList(
                    int reportGroupID, int sourceCodeTypeID
                    )
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                ReportReferenceDB.FillReportSourceCodeList(
                ds,
                reportGroupID, sourceCodeTypeID);
            }
            catch
            {
                throw;
            }
            return ds.SourceCodeNameList;

        }
		public static void FillReportSourceCodeList(
			ReportReferenceData ds,
			int reportGroupID,
            int sourceCodeTypeID
			)
		{
            try
            {
			    ReportReferenceDB.FillReportSourceCodeList(
				ds,
				reportGroupID,
                sourceCodeTypeID);
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region ReportFSConversionRate
        public static void FillFSConversionRateApproachPerson(
            ReportReferenceData ds,
            int organizationId
            )
        {
  
            try
            {
                ReportReferenceDB.FillReportFSConversionRateApproachPerson(
                ds,
                organizationId
                );
            }
            catch
            {
                throw;
            }
        }
		public static void FillFSConversionRateApproachPerson(
			ReportReferenceData ds            
			)
		{
            try
            {
			    ReportReferenceDB.FillReportFSConversionRateApproachPerson(
				ds
				);
            }
            catch
            {
                throw;
            }

		}
        public static ReportReferenceData.ApproachPersonListDataTable FillFSConversionRateApproachPerson(
            int organizationID
        )   
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                ReportReferenceDB.FillReportFSConversionRateApproachPerson(
                ds,
                organizationID
                );
            }
            catch
            {
                throw;
            }

            return ds.ApproachPersonList;
        }
        #endregion

		#region ReportApproachPerson
		public static void FillApproachPerson(
			ReportFSConversionRateData ds
			)
		{
            try
            {
			    ReportReferenceDB.FillReportApproachPerson(
				ds
				);
            }
            catch
            {
                throw;
            }

		}
		#endregion
		
		#region AuditTrail
		public static void FillReportStatTracUserList(
			ReportReferenceData ds,
			int userOrgID
			)
		{
            try
            {
			    ReportReferenceDB.FillReportStatTracUserList(
				ds,
				userOrgID
				);
            }
            catch
            {
                throw;
            }

		}


		#endregion

		#region ReportCoordinator

        public static void FillReportCoordinatorList(
            ReportReferenceData ds,
            int userOrgID,
            int reportGroupID,
            int organizationID
            )
        {
            try
            {
                ReportReferenceDB.FillReportCoordinatorList(
                ds,
                userOrgID,
                reportGroupID,
                organizationID
                );
            }
            catch
            {
                throw;
            }

        }

        public static void FillReportCoordinatorList(
			ReportReferenceData ds
			)
		{
            int userOrgID = 0;
            int reportGroupID = 0;
            int organizationID = 0;
            
            try{
			    FillReportCoordinatorList(
				ds,
                userOrgID,
                reportGroupID,
                organizationID
				);
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region ReportDateType

		public static void FillReportDateTypeList(
			ReportReferenceData ds,
			int reportID
			)
		{
            try
            {
			    ReportReferenceDB.FillReportDateTypeList(
				ds,
				reportID
				);
            }
            catch
            {
                throw;
            }

		}

		#endregion
		
		#region ReferralType

		public static void FillReportReferralTypeList(
			ReportReferenceData ds,
            int reportGroupID,
            int sourceCodeID

			)
		{
            try
            {
			    ReportReferenceDB.FillReportReferralTypeList(
				ds,
                reportGroupID,
                sourceCodeID
				);
            }
            catch
            {
                throw;
            }

		}

		#endregion
		
		#region ReportSortType

		public static void FillReportSortTypeList(
			ReportReferenceData ds,
			int reportID
			)
		{
            try
            {
			    ReportReferenceDB.FillSortOptionList(
				ds,
				reportID
				);
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region ParameterConfiguration

		public static void FillReportParameterConfigurationList(
			ReportReferenceData ds,
			int reportID
			)
		{
			try
            {
                ReportReferenceDB.FillReportParameterConfigurationList(
				ds,
				reportID
				);
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region ReportList

		public static void FillUserReportList(
			ReportReferenceData ds,
			int userID
			)
		{
            try
            {
			    ReportReferenceDB.FillUserReportList(
				ds,
				userID
				);
            }
            catch
            {
                throw;
            }

		}
        public static ReportReferenceData.UserReportListDataTable FillUserReportList(int userID)
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                FillUserReportList(
                    ds, 
                    userID);
            }
            catch
            {
                throw;
            }
            return ds.UserReportList;

        }
        public static void FillUserReportList(
			ReportReferenceData ds,
			int userID,
			int reportID
			)
		{
            try
            {
			    ReportReferenceDB.FillUserReportList(
				ds,
				userID,
				reportID
				);
            }
            catch
            {
                throw;
            }

		}

        public static void FillUserReportList(
            ReportReferenceData ds,
            int userID,
            int reportID,
            string reportDisplayname
            )
        {
            try
            {
                ReportReferenceDB.FillUserReportList(
                ds,
                userID,
                reportID,
                reportDisplayname 
                );
            }
            catch
            {
                throw;
            }

        }


#endregion

        #region Pending Referral Type
        
        public static ReportReferenceData.ReferralTypeDataTable FillReportPendingReferralType(int reportGroupID)
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                Statline.StatTrac.Data.Report.ReportReferenceDB.FillReportPendingReferralType(ds, reportGroupID);
            }
            catch
            {
                throw;
            }
            return ds.ReferralType;
        }
        public static void FillReportPendingReferralType(
            ReportReferenceData ds,
            int reportGroupID
            )
        {
            try
            {
                ReportReferenceDB.FillReportPendingReferralType(
                ds,
                reportGroupID
                );
            }
            catch
            {
                throw;
            }

        }
        #endregion

        #region Age Range

        public static ReportReferenceData.AgeRangeDataTable FillReportAgeRange()
        {
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                Statline.StatTrac.Data.Report.ReportReferenceDB.FillReportAgeRange(ds);
            }
            catch
            {
                throw;
            }
            return ds.AgeRange;
        }

        #endregion
	}
}