using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Tables
{
	/// <summary>
	/// This is the DBLayer for the Message Table
	/// </summary>
	/// <remarks>
	/// <P>Name: MessageDB </P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Thien Ta</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Message DBLayer</P>
	/// </remarks>
	public class MessageDB
	{
		public static void UpdateMessage(Database _db, MessageData messageData, IDbTransaction transaction)
		{
			int rows = 0;
			string[] procedureName = {
										 "InsertMessage",                       
										 "UpdateMessage",  // this procecdures are not build
										 "DeleteMessage" // this procecdures are not build
									 };
			string dataTable = messageData.Message.TableName;
			
			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			_db.AddInParameter(insertCommand, "MessageID", DbType.Int32, "MessageID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallID", DbType.Int32, "CallID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageCallerName", DbType.String, "MessageCallerName", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageCallerPhone", DbType.String, "MessageCallerPhone", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageCallerOrganization", DbType.String, "MessageCallerOrganization", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageTypeID", DbType.Int32, "MessageTypeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageUrgent", DbType.Int32, "MessageUrgent", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageDescription", DbType.String, "MessageDescription", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageExtension", DbType.Int32, "MessageUrgent", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "MessageImportPatient", DbType.String, "MessageImportPatient", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageImportUnosid", DbType.String, "MessageImportUnosid", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "MessageImportCenter", DbType.String, "MessageImportCenter", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
			_db.AddInParameter(updateCommand, "MessageID", DbType.Int32, "MessageID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallID", DbType.Int32, "CallID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageCallerName", DbType.String, "MessageCallerName", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageCallerPhone", DbType.String, "MessageCallerPhone", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageCallerOrganization", DbType.String, "MessageCallerOrganization", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageTypeID", DbType.Int32, "MessageTypeID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageUrgent", DbType.Int32, "MessageUrgent", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageDescription", DbType.String, "MessageDescription", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageExtension", DbType.Int32, "MessageUrgent", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "MessageImportPatient", DbType.String, "MessageImportPatient", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageImportUnosid", DbType.String, "MessageImportUnosid", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "MessageImportCenter", DbType.String, "MessageImportCenter", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "MessageID", DbType.Int32, "MessageID", DataRowVersion.Original);			

			try
			{
				rows = DBCommands.UpdateDataSet(_db, messageData, dataTable, insertCommand, null, null, (DbTransaction)transaction);				
			}
			catch // error was logged by DBCommand.UpdateDataSet
			{
				throw;
			}

		}

		
	}
}

