using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Report
{
	/// <summary>
	/// Summary description for ReportReferenceDB.
	/// </summary>
	public class ReportReferenceDB
    {
        #region Alert
        public static void FillAlertList(ReportReferenceData dataSet)
        {
            string procedureName = "GetAlertList";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { dataSet.AlertList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }
        public static void FillAlertList(ReportReferenceData dataSet, Int32 alertTypeId, string sourceCodeName)
        {
            string procedureName = "GetAlertList";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { dataSet.AlertList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
    
            if(alertTypeId.ToString() == "0")
                _db.AddInParameter(command, "alertTypeId", DbType.Int32, DBNull.Value);
            else
                _db.AddInParameter(command, "alertTypeId", DbType.Int32, alertTypeId);

            if (sourceCodeName.ToString() == "...")
                _db.AddInParameter(command, "sourceCodeName", DbType.String, DBNull.Value);
            else
                _db.AddInParameter(command, "sourceCodeName", DbType.String, sourceCodeName);            
            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }

        #endregion

        #region Cause Of Death
        public static void FillReportCauseOfDeathList(
			ReportReferenceData dataSet
			)
		{
			string procedureName = "GetCauseOfDeath";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.CauseOfDeath.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }
		}
		#endregion

		#region ReportGroup

		public static void FillReportGroupList(
			ReportReferenceData dataSet,
			int userOrgID
			)
		{
			string procedureName = "sps_ReportGroups";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.WebReportGroupList.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@vUserOrgID", DbType.Int32, userOrgID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName
				);
            }
            catch
            {
                throw;
            }

        }
		#endregion

		#region WebPerson or User Information

		public static void GetWebPersonInformation(
			string userName,
			string userPassword,
            string sessionId,
			ref int userID,
			ref int userOrganizationID,
            ref string userDisplayName,
            ref string userOrganizationName,
            ref int statEmployeeID,
            ref string timeZone
		)
		{
            
			string procedureName = "GetUserInformationByCredentials";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "userName", DbType.String, userName);
            if(!string.IsNullOrEmpty(sessionId))
            _db.AddInParameter(command, "SessionID", DbType.String, sessionId);
            if (userPassword.Length > 0)
			    _db.AddInParameter(command, "userPassword", DbType.String, userPassword);
			//if(userOrganizationID > 0)
            //    _db.AddInParameter(command, "userOrganizationID", DbType.Int32, userOrganizationID);
            //else
                //_db.AddOutParameter(command, "userOrganizationID", DbType.Int32, 11);
                if (userOrganizationID > 0)
            {
                //command.SetParameterValue("userOrganizationID", userOrganizationID);
                _db.AddOutParameter(command, "userOrganizationID", DbType.Int32, userOrganizationID);
            }
            else
            {
                _db.AddOutParameter(command, "userOrganizationID", DbType.Int32, 11);
            }
			_db.AddOutParameter(command, "userID", DbType.Int32, 11);
			_db.AddOutParameter(command, "userDisplayName", DbType.String, 100);
			_db.AddOutParameter(command, "userOrganizationName", DbType.String, 80);
			_db.AddOutParameter(command, "statEmployeeID", DbType.Int32, 11);
            _db.AddOutParameter(command, "timeZone", DbType.String, 2);
			
            try
            {
			    DBCommands.ExecuteNonQuery(
				_db,
				command,
				procedureName
				);
            }
            catch
            {
                throw;
            }

            userID = Convert.ToInt32(_db.GetParameterValue(command, "userID"));
            userOrganizationID = Convert.ToInt32(_db.GetParameterValue(command, "userOrganizationID"));
			
            userDisplayName = Convert.ToString(_db.GetParameterValue(command, "userDisplayName"));
            userOrganizationName = Convert.ToString(_db.GetParameterValue(command, "userOrganizationName"));
            statEmployeeID = Convert.ToInt32(_db.GetParameterValue(command, "statEmployeeID"));
            timeZone = Convert.ToString(_db.GetParameterValue(command, "timeZone"));



		}
		
		public static void GetUserName(
			int userId,
			int userOrgId,
			out string userName,
			out string userDisplayName,
			out string userOrganizationName
			)
		{
			string procedureName = "GetUserNameById";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "userId", DbType.Int32, userId);
            _db.AddInParameter(command, "userOrgId", DbType.Int32, userOrgId);
			_db.AddOutParameter(command, "userName", DbType.String, 15);
			_db.AddOutParameter(command, "userDisplayName", DbType.String, 100);
			_db.AddOutParameter(command, "userOrganizationName", DbType.String, 80);

    		try
            {
                DBCommands.ExecuteNonQuery(
				_db,
				command,
				procedureName);
            }
            catch
            {
                throw;
            }

            userName = Convert.ToString(_db.GetParameterValue(command, "userName"));
            userDisplayName = Convert.ToString(_db.GetParameterValue(command, "userDisplayName"));
            userOrganizationName = Convert.ToString(_db.GetParameterValue(command, "userOrganizationName"));
        }
		
		#endregion
        
        #region Person
        public static void FillPersonList(
            ReportReferenceData dataSet,
            int organizationID )
        {
			string procedureName = "GetPersonListByOrganizationID";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.PersonList.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@OrganizationID", DbType.Int32, organizationID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }

        }
            
        #endregion

        #region Organization
		public static void FillOrganizationList(
			ReportReferenceData dataSet,
			int reportGroupID
			)
		{
			string procedureName = "sps_ReportGroupOrgs";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.OrganizationList.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@vReportGroupID", DbType.Int32, reportGroupID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }

        }
        public static void FillOrganizationList(
            ReportReferenceData dataSet,
            string sourceCode,
            int sourceCodeType,
            int organizationID
            )
        {
            string procedureName = "sps_MessageImportOrganizations";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { dataSet.OrganizationList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            if (sourceCode == "" || sourceCode == "...")
                _db.AddInParameter(command, "sourceCode", DbType.String, DBNull.Value);
            else    
                _db.AddInParameter(command, "sourceCode", DbType.String, sourceCode);

            if (sourceCodeType == 0)
                _db.AddInParameter(command, "sourceCodeType", DbType.Int32, DBNull.Value);
            else                
                _db.AddInParameter(command, "sourceCodeType", DbType.Int32, sourceCodeType);

            _db.AddInParameter(command, "organizationID", DbType.Int32, organizationID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }


		#endregion 

		#region SourceCode
        public static void FillReportSourceCodeList(
            ReportReferenceData dataSet,
            int reportGroupID
            )
        {
            //create sourceCodeTypeID with default value
            int sourceCodeTypeID = 0;
            FillReportSourceCodeList(dataSet, reportGroupID, sourceCodeTypeID);

        }
		public static void FillReportSourceCodeList(
			ReportReferenceData dataSet,
			int reportGroupID,
            int sourceCodeTypeID
			)
		{
			string procedureName = "sps_SourceCodeNameList";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.SourceCodeNameList.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "WebReportGroupID", DbType.Int32, reportGroupID);
            if(sourceCodeTypeID == 0)
                _db.AddInParameter(command, "SourceCodeTypeID", DbType.Int32, DBNull.Value);
            else
                _db.AddInParameter(command, "SourceCodeTypeID", DbType.Int32, sourceCodeTypeID);

			try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }

		}
		#endregion

		#region ReportFSConversionRate
		public static void FillReportFSConversionRateApproachPerson(
			ReportReferenceData dataSet
			)
		{
			string procedureName = "sps_FSConversionRateApproachPerson";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.ApproachPersonList.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }

		}
        public static void FillReportFSConversionRateApproachPerson(
            ReportReferenceData dataSet,
            int organizationID
            )
        {
            string procedureName = "sps_FSConversionRateApproachPerson";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { dataSet.ApproachPersonList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "organizationID", DbType.Int32, organizationID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }

		#endregion

		#region StatTrac User
		public static void FillReportStatTracUserList(
			ReportReferenceData dataSet,
			int userOrgID
			)
		{
			string procedureName = "sps_OrganizationCoordinatorList";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.OrganizationCoordinatorList.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "UserOrgID", DbType.Int32, userOrgID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }
		}


		#endregion
		
		#region ReferralType
		public static void FillReportReferralTypeList(
			ReportReferenceData dataSet,
            int reportGroupID,
            int sourceCodeID
			)
		{
			string procedureName = "GetReferralType";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.ReferralType.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);
            if(reportGroupID > 0)
                _db.AddInParameter(command, "ReportGroupID", DbType.Int32, reportGroupID);
            if(sourceCodeID > 0)
                _db.AddInParameter(command, "SourceCodeID", DbType.Int32, sourceCodeID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }
		}
		#endregion

		#region ReportApproachPerson
		public static void FillReportApproachPerson(
			ReportFSConversionRateData dataSet
			)
		{
			string procedureName = "sps_ReportApproachPerson";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.ApproachPerson.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }
		}
		#endregion

		#region ReportCoordinator
        public static void FillReportCoordinatorList(
            ReportReferenceData dataSet,
            int userOrgID,
            int reportGroupID,
            int organizationID
            )
        {
            string procedureName = "sps_OrganizationCoordinatorList";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { dataSet.OrganizationCoordinatorList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            if (userOrgID != 0)
                _db.AddInParameter(command, "UserOrgID", DbType.Int32, userOrgID);
            if (reportGroupID != 0)
                _db.AddInParameter(command, "webReportGroupID", DbType.Int32, reportGroupID);
            if (organizationID != 0)
                _db.AddInParameter(command, "coordinatorOrganizationID", DbType.Int32, organizationID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }
		public static void FillReportCoordinatorList(
			ReportReferenceData dataSet
			)
		{
            int userOrgID = 0;
            int reportGroupID = 0;
            int organizationID = 0;
            try
            {
                FillReportCoordinatorList(dataSet, userOrgID, reportGroupID, organizationID);
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
            out Boolean isDateOnly
			)
		{
			string procedureName = "sps_ReportDateTimeConfiguration";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "reportID", DbType.Int32, reportID);
			_db.AddOutParameter(command, "startDateTime", DbType.DateTime, 50);
			_db.AddOutParameter(command, "endDateTime", DbType.DateTime, 50);
            _db.AddOutParameter(command, "archiveDateTime", DbType.DateTime, 50);
            _db.AddOutParameter(command, "isDateOnly", DbType.Boolean, 10);
			

			try
            {
                DBCommands.ExecuteNonQuery(
				_db,
				command,
				procedureName
				);
            }
            catch
            {
                throw;
            }
            //make sure the out parameters have a value before setting them to the 
            if (_db.GetParameterValue(command, "startDateTime").ToString() != "")
                startDateTime = DateTime.Parse(_db.GetParameterValue(command, "startDateTime").ToString());
            else
                startDateTime = new DateTime();
            if (_db.GetParameterValue(command, "endDateTime").ToString() != "")
                endDateTime = DateTime.Parse(
                    _db.GetParameterValue(command, "endDateTime").ToString());
                    //new System.Globalization.CultureInfo("en-US")).ToString("MM/dd/yyyy HH:mm"));
            else
                endDateTime = new DateTime();
            if (_db.GetParameterValue(command, "archiveDateTime").ToString() != "")
                archiveDateTime = Convert.ToDateTime(_db.GetParameterValue(command, "archiveDateTime"));
            else
                archiveDateTime = new DateTime(1900, 1, 1);
            if (_db.GetParameterValue(command, "isDateOnly").ToString() != "")
                isDateOnly = Convert.ToBoolean(_db.GetParameterValue(command, "isDateOnly"));
            else
                isDateOnly = false;
			
		}

		#endregion
		
		#region ReportDateType
		public static void FillReportDateTypeList(
			ReportReferenceData dataSet,
			int reportID
			)
		{
			string procedureName = "sps_ReportDateType";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.ReportDateType.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

			_db.AddInParameter(command, "@ReportID", DbType.Int32, reportID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }
        }
		#endregion

		#region ReportSortOptions
		public static void FillSortOptionList(
			ReportReferenceData dataSet,
			int reportID
			)
		{
			string procedureName = "sps_ReportSortType";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.ReportSortType.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

			_db.AddInParameter(command, "@ReportID", DbType.Int32, reportID);

            try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }
		}

	
	#endregion

		#region ParameterConfiguration
		public static void FillReportParameterConfigurationList(
			ReportReferenceData dataSet,
			int reportID
			)
		{
			string procedureName = "sps_ReportParameterConfiguration";
			//get db reference
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			//set table to fill
			string[] dataTableList = {dataSet.ReportParameterConfiguration.TableName};

			//build command object
			DbCommand command = _db.GetStoredProcCommand(procedureName);

			_db.AddInParameter(command, "@ReportID", DbType.Int32, reportID);

    		try
            {
                DBCommands.LoadDataSet(
				_db,
				command,
				dataSet,
				dataTableList,
				procedureName);
            }
            catch
            {
                throw;
            }

        }
		#endregion


		#region User ReportList
		public static void FillUserReportList(
			ReportReferenceData dataSet,
			int userID
			)
		{

            int reportID = 0;
            try
            {
                FillUserReportList(
                dataSet,
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
			ReportReferenceData dataSet,
			int userID,
			int reportID
			)
		{
            string reportDisplayname = "";
            try
            {
                FillUserReportList(
                dataSet,
                userID,
                reportID,
                reportDisplayname);
            }
            catch
            {
                throw;
            }

        }
        public static void FillUserReportList(
                    ReportReferenceData dataSet,
                    int userID,
                    int reportID,
                    string reportDisplayname
                    )
        {
            string procedureName = "GetUserReportList";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            string[] dataTableList = { dataSet.UserReportList.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "userID", DbType.Int32, userID);
            if (reportID > 0)
                _db.AddInParameter(command, "reportID", DbType.Int32, reportID);
            if (reportDisplayname != "")
                _db.AddInParameter(command, "reportDisplayname", DbType.String, reportDisplayname);
            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName
                );
            }
            catch
            {
                throw;
            }

        }
		#endregion

        #region Person and Title
        public static void FillPersonTitleList(
            ReportReferenceData dataSet,
            int organizationID,
            int personTypeID)
        {
            string procedureName = "GetPersonTitleListByOrganizationID";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { dataSet.PersonTitleList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@OrganizationID", DbType.Int32, organizationID);
            _db.AddInParameter(command, "@PersonTypeID", DbType.Int32, personTypeID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }

        #endregion

        #region Pending Referral Type
        public static void FillReportPendingReferralType(
            ReportReferenceData ds,
            int reportGroupID
            )
        {
            string procedureName = "sps_PendingReferralTypeViewAccess";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ReferralType.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@ReportGroupID", DbType.Int32, reportGroupID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }

        //public static void FillReportPendingReferralType(
        //    ReportReferenceData dataSet,
        //    int reportGroupID
            
        //    )
        //{
        //    string procedureName = "sps_PendingReferralTypeViewAccess";
        //    //get db reference
        //    Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

        //    //set table to fill
        //    string[] dataTableList = { dataSet.ReferralType.TableName };

        //    //build command object
        //    DbCommand command = _db.GetStoredProcCommand(procedureName);
        //    _db.AddInParameter(command, "ReportGroupID", DbType.Int32, reportGroupID);

        //    try
        //    {
        //        DBCommands.LoadDataSet(
        //        _db,
        //        command,
        //        dataSet,
        //        dataTableList,
        //        procedureName);
        //    }
        //    catch
        //    {
        //        throw;
        //    }
        //}
        #endregion

        #region Age Range
        public static void FillReportAgeRange(
            ReportReferenceData ds
            )
        {
            string procedureName = "sps_AgeDemoAgeGroup";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.AgeRange.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            //_db.AddInParameter(command, "@vUserOrgID", DbType.Int32, orgID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }
        }


        #endregion
	}
}