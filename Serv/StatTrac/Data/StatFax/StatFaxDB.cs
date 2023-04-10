using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.StatFax
{
    public class StatFaxDB
    {
        #region InsertLogEvent
        public static int InsertStatFaxLogEvent(StatFaxData dataSet)
        {
            int rows = 0;

            string procedureName = "InsertLogEvent";

            //get the DB reference. This will be past the the DBCommands Class
            //this does not open a connection and it allows EnterpriseLibrary to control all connections
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();

            // Set the table name to be updated here
            string dataTable = dataSet.LogEventInsert.TableName;

            // build inser, update and delete commands
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

            try
            {
                rows = DBCommands.UpdateDataSet(
                    _db,
                    dataSet,
                    dataTable,
                    insertCommand,
                    null,
                    null,
                    UpdateBehavior.Transactional);
            }

            catch (Exception ex)
            {
                throw;
            }

            return rows;
        }
        #endregion

        #region Get Fax Queue
        public static void GetDocumentRequestQueue(StatFaxData ds)
        {
            string procedureName = "GetDocumentRequestRead";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.DocumentRequestQueue.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

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
        public static void GetDocumentRequestSingle(StatFaxData ds, string jobID)
        {
            string procedureName = "GetDocumentRequestSingle";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.DocumentRequestQueue.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "jobID", DbType.String, jobID);
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

        #region Get Registry Data
        public static void GetRegistryData(StatFaxData ds, int dmvID, int regID, int stateID)
        {
            string procedureName = "sps_GetRegistryData";
            Database _db;
            //get db reference
            switch (stateID)
            {
                case 15:
                    _db = DBCommands.GetDataBase(DatabaseInstance.CA);
                    break;
                case 20:
                    _db = DBCommands.GetDataBase(DatabaseInstance.NH);
                    break;
                case 13:
                    _db = DBCommands.GetDataBase(DatabaseInstance.RI);
                    break;
                case 22:
                    _db = DBCommands.GetDataBase(DatabaseInstance.VT);
                    break;
                case 1:
                    _db = DBCommands.GetDataBase(DatabaseInstance.CO);
                    break;
                case 12:
                    _db = DBCommands.GetDataBase(DatabaseInstance.CT);
                    break;
                case 18:
                    _db = DBCommands.GetDataBase(DatabaseInstance.MA);
                    break;
                case 8:
                    _db = DBCommands.GetDataBase(DatabaseInstance.MI);
                    break;
                case 17:
                    _db = DBCommands.GetDataBase(DatabaseInstance.MI_SOS);
                    break;
                case 6:
                    _db = DBCommands.GetDataBase(DatabaseInstance.NE);
                    break;
                case 11:
                    _db = DBCommands.GetDataBase(DatabaseInstance.NV);
                    break;
                case 7:
                    _db = DBCommands.GetDataBase(DatabaseInstance.WA);
                    break;
                case 2:
                    _db = DBCommands.GetDataBase(DatabaseInstance.WY);
                    break;
                case 19:
                    _db = DBCommands.GetDataBase(DatabaseInstance.ME);
                    break;
                case 27:
                    _db = DBCommands.GetDataBase(DatabaseInstance.HI); //Added HI
                    break;
                case 28:
                    _db = DBCommands.GetDataBase(DatabaseInstance.TX); //Added TX
                    break;
                default:
                    _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);
                    break;
            }

            //set table to fill
            string[] dataTableList = { ds.RegistryData.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "DMVID", DbType.Int32, dmvID);
            _db.AddInParameter(command, "RegID", DbType.Int32, regID);

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

        public static void UpdateDocumentRequest(int faxQID, string jobID)
        {
            string procedureName = "UpdateDocumentRequestQueue";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "documentRequestQueueID", DbType.Int32, faxQID);
            _db.AddInParameter(updateCommand, "jobID", DbType.String, jobID);

            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }

        }

        public static void UpdateDocumentRequestDelete(string jobID)
        {
            string procedureName = "UpdateFaxDelete";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "jobID", DbType.String, jobID);

            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
    }
}
