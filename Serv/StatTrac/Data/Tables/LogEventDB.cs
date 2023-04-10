using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.SqlClient;
using System.Data.Common;

namespace Statline.StatTrac.Data.Tables
{
	/// <summary>
	/// This is the DBLayer for the LogEvent Table
	/// </summary>
	/// <remarks>
	/// <P>Name: LogEventDB </P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Thien Ta</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: LogEvent DBLayer</P>
	/// </remarks>
	public class LogEventDB
    {
        #region StatRespond
        /// <summary>
        /// CCRST89 Replacement of AutoResponse Application 
        /// </summary>
        /// <remarks> 
        /// <P>Date Created: 4/24/09</P>
        /// <P>Created By: Bret Knoll</P>
        /// <P>Version: 1.0</P>
        /// </remarks>
        /// <param name="instance"></param>
        /// <param name="callId"></param>
        /// <param name="logeEventTypeId"></param>
        /// <param name="logEventNumber"></param>
        /// <returns></returns>
        public static int ClosePageResponse(DatabaseInstance instance, int callId, int logeEventTypeId, int logEventNumber)
        {
            int result = 0;
            string procedureName = "spu_Close_PagerResponse_LogEvent";

            Database _db = DBCommands.GetDataBase(instance);
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "CallId", DbType.Int32, callId);
            _db.AddInParameter(updateCommand, "LogeventTypeId", DbType.Int32, logeEventTypeId);
            _db.AddInParameter(updateCommand, "LogEventNumber", DbType.Int32, logEventNumber);
            _db.AddOutParameter(updateCommand, "UpdatedRows", DbType.Int32, result);
                     

            try{
                DBCommands.ExecuteNonQuery(_db, updateCommand, procedureName);
            }
            catch
            {
                throw;
            }
            result = Convert.ToInt32(_db.GetParameterValue(updateCommand, "UpdatedRows"));
            return result;
        }
        #endregion
        public static void GetLogEventByAutoResponseCode(DatabaseInstance instance,  LogEventData ds, int callId, int logEventNumber)
        {
            Database db = DBCommands.GetDataBase(instance);
            string procedureName = "GetLogEventByAutoResponseCode";
            
            string[] dataTable = {ds.LogEvent.TableName};


            DbCommand command = db.GetStoredProcCommand(procedureName);
            db.AddInParameter(command, "callId", DbType.Int32, callId);
            db.AddInParameter(command, "autoResponseCode", DbType.Int32, logEventNumber);

            try
            {
                DBCommands.LoadDataSet(db, command, ds, dataTable, procedureName);
            }
            catch
            {
                throw;
            }

        }
        public static int UpdateLogEvent(DatabaseInstance instance, LogEventData ds)
        {
            int rows = 0;
            Database db = DBCommands.GetDataBase(instance);
            string[] procedureName = GetProcedureName();
            string dataTable = ds.LogEvent.TableName;

            // build inser, update and delete commands
            DbCommand insertCommand = GetInsertCommand(db, procedureName[0]);
            DbCommand updateCommand = GetUpdateCommand(db, procedureName[1]);
            DbCommand deleteCommand = GetDeleteCommand(db, procedureName[2]);

            try
            {
                rows = DBCommands.UpdateDataSet(db, ds, dataTable, insertCommand, updateCommand, deleteCommand, UpdateBehavior.Transactional);
            }
            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }

            return rows;
        }
        private static string[] GetProcedureName()
        {
            string[] procedureName = {
										 "InsertLogEvent",                       
										 "UpdateLogEvent",  // this procecdures are not build
										 "DeleteLogEvent" // this procecdures are not build
									 };
            return procedureName;

        }
        private static DbCommand GetInsertCommand(Database _db, string procedureName)
        {
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(insertCommand, "LogEventID", DbType.Int32, "LogEventID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "CallID", DbType.Int32, "CallID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventTypeID", DbType.Int32, "LogEventTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventName", DbType.String, "LogEventName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventPhone", DbType.String, "LogEventPhone", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventOrg", DbType.String, "LogEventOrg", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventDesc", DbType.String, "LogEventDesc", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventDateTime", DbType.DateTime, "LogEventDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventCallbackPending", DbType.Int32, "LogEventCallbackPending", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "ScheduleGroupID", DbType.Int32, "ScheduleGroupID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PhoneID", DbType.Int32, "PhoneID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventContactConfirmed", DbType.Int32, "LogEventContactConfirmed", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventCalloutDateTime", DbType.DateTime, "LogEventCalloutDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LogEventNumber", DbType.Int32, "LogEventNumber", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            

            return insertCommand;

        }
        private static DbCommand GetUpdateCommand(Database _db, string procedureName)
        {
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "LogEventID", DbType.Int32, "LogEventID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "CallID", DbType.Int32, "CallID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventTypeID", DbType.Int32, "LogEventTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventName", DbType.String, "LogEventName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventPhone", DbType.String, "LogEventPhone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventOrg", DbType.String, "LogEventOrg", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventDesc", DbType.String, "LogEventDesc", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventDateTime", DbType.DateTime, "LogEventDateTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventCallbackPending", DbType.Int32, "LogEventCallbackPending", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ScheduleGroupID", DbType.Int32, "ScheduleGroupID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "PhoneID", DbType.Int32, "PhoneID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventContactConfirmed", DbType.Int32, "LogEventContactConfirmed", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventCalloutDateTime", DbType.DateTime, "LogEventCalloutDateTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LogEventNumber", DbType.Int32, "LogEventNumber", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            return updateCommand;

        }
        private static DbCommand GetDeleteCommand(Database _db, string procedureName)
        {
            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(deleteCommand, "LogEventID", DbType.Int64, "LogEventID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "CallID", DbType.Int32, "CallID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            return deleteCommand;

        }

        public static int UpdateLogEvent(Database _db, MessageData messageData, IDbTransaction transaction)
		{
			int rows = 0;
            string[] procedureName = GetProcedureName();
			string dataTable = messageData.LogEvent.TableName;
			
			// build insert, update and delete commands
            DbCommand insertCommand = GetInsertCommand(_db, procedureName[0]);
            DbCommand updateCommand = GetUpdateCommand(_db, procedureName[1]);
            DbCommand deleteCommand = GetDeleteCommand(_db, procedureName[2]);

			try
			{
				rows = DBCommands.UpdateDataSet(_db, messageData, dataTable, insertCommand, null, null, (DbTransaction)transaction);				
			}
			catch // error was logged by DBCommand.UpdateDataSet
			{
				throw;
			}

                return rows;
		}

		
	}
}
