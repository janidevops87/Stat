using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Admin
{
	/// <summary>
	/// Summary description for AdminReferenceDB.
	/// </summary>
	/// <remarks>
	/// <P>Name: AdminReferenceDB </P>
	/// <P>Date Created: 11/27/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Calls DB sprocs for admin functionality</P>
	/// </remarks>	
	public class AdminReferenceDB
	{
		#region Get All Referrals Report Group ID
		public static void GetUserAllReferralsReportGroup(
			int userOrganizationID ,
			out int webReportGroupID 
								   )
		{
			string procedureName = "GetUserAllReferralsReportGroup";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, userOrganizationID);
            _db.AddOutParameter(command, "WebReportGroupID", DbType.Int32, 11);
			
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

            webReportGroupID = Convert.ToInt32(_db.GetParameterValue(command, "webReportGroupID"));
			
		}

		#endregion

		#region Users
		
		public static void FillUserList(
			UserData dataSet, 
			int organizationID,
			int inactive)
		{
			string procedureName = "GetUserListByOrganizationID";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.UserList.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
			_db.AddInParameter(command, "Inactive", DbType.Int32, inactive );
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
        #region StatEmployee
        public static void FillStatEmployeeDetail(
            UserData dataSet,
            int webPersonID)
        {
            string procedureName = "GetStatEmployeeByWebPersonId";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            string[] dataTableList = { dataSet.StatEmployee.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "WebPersonID", DbType.Int32, webPersonID);
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
		#region Person
		public static void FillPersonDetail(
			UserData dataSet, 
			int webPersonID)
		{
			string procedureName = "GetPersonByWebPersonId";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.Person.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "WebPersonID", DbType.Int32, webPersonID);
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
		#region WebPerson
		public static void FillWebPersonDetail(
			UserData dataSet, 
			int webPersonID)
		{
			string procedureName = "GetWebPersonByWebPersonId";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.WebPerson.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "WebPersonID", DbType.Int32, webPersonID);
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

		public static void GetWebPersonUserNameCount(
			string webPersonUserName,
            int inactive,
            int webPersonID,
			out int count
			)
		{
			string procedureName = "GetUserNameCount";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			_db.AddInParameter(command, "WebPersonUserName", DbType.String, webPersonUserName);
            _db.AddInParameter(command, "Inactive", DbType.Int32, inactive);
            _db.AddInParameter(command, "WebPersonID", DbType.Int32, webPersonID);
			_db.AddOutParameter(command, "Count", DbType.Int32, 11);
			

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

            count = Convert.ToInt32(_db.GetParameterValue(command, "Count"));
			
		}


		#endregion

		#region User Roles
		public static void FillUserRolesList(
			UserData dataSet, 
			int webPersonID)
		{
			string procedureName = "GetSelectRolesByWebPersonID";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.UserRoles.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "WebPersonID", DbType.Int32, webPersonID);
		
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

		public static void FillAvailableRolesList(
			UserData dataSet, 
			int webPersonID,
			int userID)
		{
			string procedureName = "GetAvailableRolesByWebPersonID";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.Roles.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "WebPersonID", DbType.Int32, webPersonID);
            _db.AddInParameter(command, "UserID", DbType.Int32, userID);
			
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
		#region PersonType

		public static void FillPersonTypeList( UserData dataSet )
		{
			string procedureName = "sps_GetPersonTypes";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.PersonType.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
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

	}
}