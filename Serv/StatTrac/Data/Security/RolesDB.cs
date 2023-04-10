using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Security
{
	/// <summary>
	/// Summary description for Roles.
	/// </summary>
	public class RolesDB
	{
        #region StatTrac Role Management Methods
        //http://www.projky.com/entlib/1.1/Microsoft/Practices/EnterpriseLibrary/Security/Database/UserRoleManager.cs.html

        #region UserRoleManager StoredProc Constants

        private const string SPCreateUser = "InsertUser";
        private const string SPDeleteUser = "DeleteUserByName";
        private const string SPCreateRole = "InsertRole";
        private const string SPDeleteRole = "DeleteRoleByName";
        private const string SPCreateUserRole = "AddUserToRoleByName";
        private const string SPDeleteUserRole = "RemoveUserFromRoleByName";
        private const string SPGetIdentityId = "GetUserIdByName";
        private const string SPGetRoleId = "GetRoleIdByName";
        private const string SPRenameRole = "UpdateRoleById";
        private const string SPChangePassword = "ChangePasswordByName";
        private const string SPGetPassword = "GetHashPassword";
        private const string SPGetRolesByName = "GetRolesByName";

        private const string SPGetAllRoles = "GetAllRoles";
        private const string SPGetAllUsers = "GetAllUsers";
        private const string SPGetRoleUsers = "GetUserInRoleByName";

        #endregion


        public static int GetUserIdFromUserName(string userName)
        {
            int userID;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            string procedureName = SPGetIdentityId;
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            ValidateParam("userName", userName);

            _db.AddInParameter(command, "name", DbType.String, userName);
            _db.AddOutParameter(command, "UserID", DbType.Int32, 0);

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

            userID = Convert.ToInt32(_db.GetParameterValue(command, "UserID"));

            return userID;
        }

        public static DataSet GetAllRoles()
        {
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            DbCommand command = _db.GetStoredProcCommand(SPGetAllRoles);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable(SPGetAllRoles + "table");
            ds.Tables.Add(dt);

            string[] dataTableList = { dt.TableName };

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
                dataTableList,
                SPGetAllRoles
                );
            }
            catch
            {
                throw;
            }

            return ds;
        }

        public static DataSet GetUserRoles(string userName)
        {
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            DbCommand command = _db.GetStoredProcCommand(SPGetRolesByName);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable(SPGetRolesByName + "table");
            ds.Tables.Add(dt);

            ValidateParam("userName", userName);

            string[] dataTableList = { dt.TableName };

            _db.AddInParameter(command, "name", DbType.String, userName);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
                dataTableList,
                SPGetRolesByName
                );
            }
            catch
            {
                throw;
            }

            return ds;
        }

        public static DataSet GetRoleUsers(string role)
        {
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            DbCommand command = _db.GetStoredProcCommand(SPGetRoleUsers);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable(SPGetRoleUsers + "table");
            ds.Tables.Add(dt);

            ValidateParam("role", role);

            string[] dataTableList = { dt.TableName };

            _db.AddInParameter(command, "roleName", DbType.String, role);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
                dataTableList,
                SPGetRolesByName
                );
            }
            catch
            {
                throw;
            }

            return ds;
        }

        public static DataSet GetPassword(string userName)
        {
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            DbCommand command = _db.GetStoredProcCommand(SPGetPassword);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable(SPGetPassword + "table");
            ds.Tables.Add(dt);

            ValidateParam("userName", userName);

            string[] dataTableList = { dt.TableName };

            _db.AddInParameter(command, "Name", DbType.String, userName);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
                dataTableList,
                SPGetPassword
                );
            }
            catch
            {
                throw;
            }

            return ds;

        }

        private static void ValidateParam(string paramName, object param)
        {
            if (param == null)
            {
                throw new ArgumentNullException(paramName);
            }
            else if (param is string)
            {
                string stringParam = (string)param;
                if (stringParam.Length == 0)
                {
                    throw new ArgumentNullException(paramName);
                }
            }
        }

        #endregion

		#region roles

		public static void FillSelectedReports(
            SecurityData dataSet,
            int webPersonId,
            int roleId)
		{
            string procedureName = "GetSelectedReportsInRole";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            string[] dataTableList = {dataSet.ReportRule.TableName};

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "WebPersonId", DbType.Int32, webPersonId);
            _db.AddInParameter(command, "roleId", DbType.Int32, roleId);
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

		public static void FillAvailableReports(
            SecurityData dataSet,
            int webPersonID,
            int roleId)
		{
            string procedureName = "GetAvailableReportsForRole";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.Reports.TableName};

            DbCommand command = _db.GetStoredProcCommand(procedureName);                      
            _db.AddInParameter(command, "WebPersonId", DbType.Int32, webPersonID);
            _db.AddInParameter(command, "roleId", DbType.Int32, roleId);
			
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

		public static void FillRoleUsers(
            SecurityData dataSet,
            int webPersonID,
            int roleId)
		{
            string procedureName = "GetUsersInRole";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.UserList.TableName};

            DbCommand command = _db.GetStoredProcCommand(procedureName);                      
            _db.AddInParameter(command, "WebPersonId", DbType.Int32, webPersonID);
            _db.AddInParameter(command, "roleId", DbType.Int32, roleId);

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


		public static void FillRolesList(
            UserData dataSet,
            int webPersonID)
		{
            string procedureName = "GetAllRolesByWebPersonId";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.Roles.TableName};

            DbCommand command = _db.GetStoredProcCommand(procedureName);                      
            _db.AddInParameter(command, "WebPersonId", DbType.Int32, webPersonID);
			
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

		public static int UpdateRoles(
            Database _db, 
            IDbTransaction transaction,
			SecurityData dataSet,
            int statEmployeeID
			)
			
		{
			int rows = 0;
			

			string[] procedureName = {
										"InsertRoles",                       
										"UpdateRoles",
										"DeleteRoles"
										};
			
			// Set the table name to be updated here
				string dataTable = dataSet.Roles.TableName;

			// build inser, update and delete commands
                DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
				_db.AddInParameter(insertCommand, "RoleName", DbType.String, "RoleName", DataRowVersion.Current); 
    			_db.AddInParameter(insertCommand, "RoleDescription", DbType.String, "RoleDescription", DataRowVersion.Current);
                _db.AddInParameter(insertCommand, "Inactive", DbType.Int16, "Inactive", DataRowVersion.Current); 
                _db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, statEmployeeID);
                _db.AddInParameter(insertCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.CREATE);


                DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
				_db.AddInParameter(updateCommand, "roleID", DbType.Int32, "RoleID", DataRowVersion.Original);
                _db.AddInParameter(updateCommand, "RoleName", DbType.String, "RoleName", DataRowVersion.Current);
                _db.AddInParameter(updateCommand, "RoleDescription", DbType.String, "RoleDescription", DataRowVersion.Current);
                _db.AddInParameter(updateCommand, "Inactive", DbType.Int16, "Inactive", DataRowVersion.Current);
                _db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, statEmployeeID);
                _db.AddInParameter(updateCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.MODIFY);

                DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
                _db.AddInParameter(deleteCommand, "roleID", DbType.Int32, "RoleID", DataRowVersion.Original);

			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand,
                    (DbTransaction)transaction);
	
			}
			catch
			{
				throw;
			}
			
			return rows;
		}
        public static int UpdateReportRule(
            Database _db,
            IDbTransaction transaction,
            SecurityData dataSet,
            int statEmployeeID
            )
        {
            int rows = 0;

            string[] procedureName = {
										"InsertReportRule",                       
										"UpdateReportRule",
										"DeleteReportRule"
										};

            // Set the table name to be updated here
            string dataTable = dataSet.ReportRule.TableName;

            // build inser, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
            _db.AddInParameter(insertCommand, "ReportID", DbType.Int32, "ReportID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "RoleID", DbType.Int32, "RoleID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, statEmployeeID);
            _db.AddInParameter(insertCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.CREATE);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "ReportRuleID", DbType.Int32, "ReportRuleID", DataRowVersion.Original);
            _db.AddInParameter(updateCommand, "ReportID", DbType.Int32, "ReportID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "RoleID", DbType.Int32, "RoleID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, statEmployeeID);
            _db.AddInParameter(updateCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.MODIFY);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "ReportRuleID", DbType.Int32, "ReportRuleID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "ReportID", DbType.Int32, "ReportID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "RoleID", DbType.Int32, "RoleID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "LastStatEmployeeID", DbType.Int32, statEmployeeID);
            _db.AddInParameter(deleteCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.DELETE);

            try
            {
                rows = DBCommands.UpdateDataSet(
                    _db,
                    dataSet,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    (DbTransaction)transaction);

            }
            catch
            {
                throw;
            }

            return rows;
        }

        public static void GetRole(
            SecurityData dataSet,
            int RoleID
            )
        {
            string procedureName = "GetRoleById";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

			string[] dataTableList = {dataSet.Roles.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "RoleId", DbType.Int32, RoleID);

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
