using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Person
{
	/// <summary>
	/// Summary description for UserRolesDB.
	/// </summary>
	public class UserRolesDB
	{
		public static void UpdateUserRoles(
            Database _db, 
            UserData userData, 
            int lastStatEmployeeID, 
            IDbTransaction transaction)
		{
			int rows = 0;
			string[] procedureName = {
										 "InsertUserRoles",                       
										 "UpdateUserRoles",  // this procecdures are not build
										 "DeleteUserRoles" // this procecdures are not build
									 };
			string dataTable = userData.UserRoles.TableName;
			
			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			_db.AddInParameter(insertCommand, "WebPersonID", DbType.Int32, "WebPersonID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "RoleID", DbType.Int32, "RoleID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, lastStatEmployeeID); 			
			_db.AddInParameter(insertCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.CREATE);  
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
			_db.AddInParameter(updateCommand, "WebPersonID", DbType.Int32, "WebPersonID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "RoleID", DbType.Int32, "RoleID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, lastStatEmployeeID); 
			_db.AddInParameter(updateCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.MODIFY);  

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
			_db.AddInParameter(deleteCommand, "WebPersonID", DbType.Int32, "WebPersonID", DataRowVersion.Original);			
			_db.AddInParameter(deleteCommand, "RoleID", DbType.Int32, "RoleID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "LastStatEmployeeID", DbType.Int32, lastStatEmployeeID);	
			_db.AddInParameter(deleteCommand, "AuditLogTypeID", DbType.Int32, ConstHelper.AuditLogType.DELETE);	 


			try
			{
				rows = DBCommands.UpdateDataSet(
					_db, 
					userData, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					(DbTransaction)transaction);				
			}
			catch // error was logged by DBCommand.UpdateDataSet
			{
				throw;
			}

		}
	}
}
