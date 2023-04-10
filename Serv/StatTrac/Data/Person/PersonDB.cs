using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Person
{
	/// <summary>
	/// Summary description for PersonDB.
	/// </summary>
	public class PersonDB
	{
		public static void UpdatePerson(Database _db, UserData userData, int lastStatEmployeeID, IDbTransaction transaction)
		{
			int rows = 0;
			string[] procedureName = {
										 "InsertPerson",                       
										 "UpdatePerson",  // this procecdures are not build
										 "DeletePerson" // this procecdures are not build
									 };
			string dataTable = userData.Person.TableName;
			
			// build inser, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
            _db.AddInParameter(insertCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonFirst", DbType.String, "PersonFirst", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonMI", DbType.String, "PersonMI", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonLast", DbType.String, "PersonLast", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonTypeID", DbType.Int32, "PersonTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonNotes", DbType.String, "PersonNotes", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonBusy", DbType.Int16, "PersonBusy", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "Verified", DbType.Int16, "Verified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "Inactive", DbType.Int16, "Inactive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonBusyUntil", DbType.DateTime, "PersonBusyUntil", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonTempNoteActive", DbType.Int16, "PersonTempNoteActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonTempNoteExpires", DbType.DateTime, "PersonTempNoteExpires", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "Unused", DbType.String, "Unused", DataRowVersion.Current);

            _db.AddInParameter(insertCommand, "AllowInternetScheduleAccess", DbType.Int16, "AllowInternetScheduleAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonSecurity", DbType.Int16, "PersonSecurity", DataRowVersion.Current);

            _db.AddInParameter(insertCommand, "PersonArchive", DbType.Int16, "PersonArchive", DataRowVersion.Current);

            _db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AuditLogTypeId", DbType.Int32, "AuditLogTypeId", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "PersonFirst", DbType.String, "PersonFirst", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "PersonMI", DbType.String, "PersonMI", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonLast", DbType.String, "PersonLast", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonTypeID", DbType.Int32, "PersonTypeID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonNotes", DbType.String, "PersonNotes", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonBusy", DbType.Int16, "PersonBusy", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "Verified", DbType.Int16, "Verified", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "Inactive", DbType.Int16, "Inactive", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonBusyUntil", DbType.DateTime, "PersonBusyUntil", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonTempNoteActive", DbType.Int16, "PersonTempNoteActive", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonTempNoteExpires", DbType.DateTime, "PersonTempNoteExpires", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "Unused", DbType.String, "Unused", DataRowVersion.Current); 
			
			_db.AddInParameter(updateCommand, "AllowInternetScheduleAccess", DbType.Int16, "AllowInternetScheduleAccess", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonSecurity", DbType.Int16, "PersonSecurity",	DataRowVersion.Current); 

			_db.AddInParameter(updateCommand, "PersonArchive", DbType.Int16, "PersonArchive", DataRowVersion.Current); 

			_db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "AuditLogTypeId", DbType.Int32, "AuditLogTypeId", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

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
