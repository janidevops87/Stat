using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Tables
{
	/// <summary>
	/// This is the DBLayer for the Call Table
	/// </summary>
	/// <remarks>
	/// <P>Name: CallDB </P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Thien Ta</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Call DBLayer</P>
	/// </remarks>
	public class CallDB
	{
		public static void UpdateCall(Database _db, MessageData messageData, IDbTransaction transaction)
		{
			int rows = 0;
			string[] procedureName = {
										 "InsertCall",                       
										 "UpdateCallById",  // this procecdures are not build
										 "DeleteCallByName" // this procecdures are not build
									 };
			string dataTable = messageData.Call.TableName;
			
			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			_db.AddInParameter(insertCommand, "CallID", DbType.Int32, 4);
			_db.AddInParameter(insertCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "SourceCodeID", DbType.Int32, "SourceCodeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallExtension", DbType.Int32, "CallExtension", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallTypeID", DbType.Int32, "CallTypeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallDateTime", DbType.Date, "CallDateTime", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "CallTotalTime", DbType.String, "CallTotalTime", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallSeconds", DbType.String, "CallSeconds", DataRowVersion.Current);   
			_db.AddInParameter(insertCommand, "CallTemp", DbType.Int32, "CallTemp", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallOpenByID", DbType.Int32, "CallOpenByID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallTempExclusive", DbType.Int32, "CallTempExclusive", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallTempSavedByID", DbType.Int32, "CallTempSavedByID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "RecycleNCFlag", DbType.Int32, "RecycleNCFlag", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallActive", DbType.Int32, "CallActive", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "CallSaveLastByID", DbType.Int32, "CallSaveLastByID", DataRowVersion.Current); 
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
			_db.AddInParameter(updateCommand, "CallID", DbType.Int32, 4);
			_db.AddInParameter(updateCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "SourceCodeID", DbType.Int32, "SourceCodeID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallExtension", DbType.Int32, "CallExtension", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallTypeID", DbType.Int32, "CallTypeID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallDateTime", DbType.Date, "CallDateTime", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "CallTotalTime", DbType.String, "CallTotalTime", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallSeconds", DbType.String, "CallSeconds", DataRowVersion.Current);   
			_db.AddInParameter(updateCommand, "CallTemp", DbType.Int32, "CallTemp", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallOpenByID", DbType.Int32, "CallOpenByID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallTempExclusive", DbType.Int32, "CallTempExclusive", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallTempSavedByID", DbType.Int32, "CallTempSavedByID", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "RecycleNCFlag", DbType.Int32, "RecycleNCFlag", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallActive", DbType.Int32, "CallActive", DataRowVersion.Current); 
			_db.AddInParameter(updateCommand, "CallSaveLastByID", DbType.Int32, "CallSaveLastByID", DataRowVersion.Current); 

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "CallID", DbType.String, "CallID", DataRowVersion.Original);			

			try
			{
				rows = DBCommands.UpdateDataSet(_db, messageData, dataTable, insertCommand, updateCommand, deleteCommand, (DbTransaction)transaction);				
			}
			catch // error was logged by DBCommand.UpdateDataSet
			{
				throw;
			}

		}

		
	}
}
