using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Person
{
	/// <summary>
	/// Summary description for WebPersonDB.
	/// </summary>
	public class WebPersonDB
	{
		public static void UpdateWebPerson(Database _db, UserData userData, int lastStatEmployeeID, IDbTransaction transaction)
		{
			int rows = 0;
			string[] procedureName = {
										 "InsertWebPerson",                       
										 "UpdateWebPerson",  // this procecdures are not build
										 "DeleteWebPerson" // this procecdures are not build
									 };
			string dataTable = userData.WebPerson.TableName;
			
			// build inser, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			_db.AddInParameter(insertCommand, "WebPersonID", DbType.Int32, "WebPersonID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "WebPersonUserName", DbType.String, "WebPersonUserName", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current); 

			_db.AddInParameter(insertCommand, "UnusedField1", DbType.Int32, "UnusedField1", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "WebPersonSessionCounter", DbType.Int32, "WebPersonSessionCounter", DataRowVersion.Current);
 
			_db.AddInParameter(insertCommand, "UnusedField2", DbType.Int32, "UnusedField2", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "WebPersonLastSessionAccess", DbType.DateTime, "WebPersonLastSessionAccess", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "WebPersonEmail", DbType.String, "WebPersonEmail", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "WebPersonUserAgent", DbType.String, "WebPersonUserAgent", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "Access", DbType.Int32, "Access", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "SaltValue", DbType.String, "SaltValue", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "HashedPassword", DbType.String, "HashedPassword", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
			_db.AddInParameter(updateCommand, "WebPersonID", DbType.Int32, "WebPersonID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "WebPersonUserName", DbType.String, "WebPersonUserName", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current); 

			_db.AddInParameter(updateCommand, "UnusedField1", DbType.Int32, "UnusedField1", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "WebPersonSessionCounter", DbType.Int32, "WebPersonSessionCounter", DataRowVersion.Current);
 
			_db.AddInParameter(updateCommand, "UnusedField2", DbType.Int32, "UnusedField2", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "WebPersonLastSessionAccess", DbType.DateTime, "WebPersonLastSessionAccess", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "WebPersonEmail", DbType.String, "WebPersonEmail", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "WebPersonUserAgent", DbType.String, "WebPersonUserAgent", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "Access", DbType.Int32, "Access", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "SaltValue", DbType.String, "SaltValue", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "HashedPassword", DbType.String, "HashedPassword", DataRowVersion.Current);        

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "WebPersonID", DbType.Int32, "WebPersonID", DataRowVersion.Original);			

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
