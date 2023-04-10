using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;

namespace Statline.StatTrac.Data.StatFile
{
    public static class DB
    {
        #region Message
        public static void GetMessage(
            StatFileData ds,
            DateTime startDateTime,
            DateTime endDateTime,
            int webReportGroupID,
            int organizationID,
            int dateTypeID,
            int exportFileID,
            Boolean seperateFiles,
            int closeCaseTriggerID,
            int closeCaseOverride

            )
        {

            String procedureName = "GetStatFileMessage";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            String[] dataTableList = { 
                                        ds.CreatedDateMessage.TableName
                                        , ds.LastModifiedDateMessage.TableName
                                     };
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "StartDateTime", DbType.DateTime, startDateTime);
            _db.AddInParameter(command, "EndDateTime", DbType.DateTime, endDateTime);
            _db.AddInParameter(command, "WebReportGroupID", DbType.Int32, webReportGroupID);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
            _db.AddInParameter(command, "DateTypeID", DbType.Int32, dateTypeID);
            _db.AddInParameter(command, "SeperateFiles", DbType.Boolean, seperateFiles);

            if (exportFileID > 0)
                _db.AddInParameter(command, "ExportFileID", DbType.Int32, exportFileID);
            if (closeCaseTriggerID > 0)
                _db.AddInParameter(command, "CloseCaseTriggerID", DbType.Int32, closeCaseTriggerID);
            if (closeCaseOverride > 0)
                _db.AddInParameter(command, "CloseCaseOverride", DbType.Int32, closeCaseOverride);

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
        #region MessageEvent
        public static void GetMessageEvent(
            StatFileData ds,
            DateTime startDateTime,
            DateTime endDateTime,
            int webReportGroupID,
            int organizationID,
            int dateTypeID,
            int exportFileID,
            Boolean seperateFiles,
            int closeCaseTriggerID,
            int closeCaseOverride

            )
        {

            String procedureName = "GetStatFileMessageEvent";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            String[] dataTableList = { 
                                        ds.CreatedDateEvent.TableName
                                        , ds.LastModifiedDateEvent.TableName
                                     };
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "StartDateTime", DbType.DateTime, startDateTime);
            _db.AddInParameter(command, "EndDateTime", DbType.DateTime, endDateTime);
            _db.AddInParameter(command, "WebReportGroupID", DbType.Int32, webReportGroupID);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
            _db.AddInParameter(command, "DateTypeID", DbType.Int32, dateTypeID);
            _db.AddInParameter(command, "SeperateFiles", DbType.Boolean, seperateFiles);

            if (exportFileID > 0)
            _db.AddInParameter(command, "ExportFileID", DbType.Int32, exportFileID);
            if (closeCaseTriggerID > 0)
            _db.AddInParameter(command, "CloseCaseTriggerID", DbType.Int32, closeCaseTriggerID);
            if (closeCaseOverride > 0)
            _db.AddInParameter(command, "CloseCaseOverride", DbType.Int32, closeCaseOverride);

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

        #region Referral
        public static void GetReferral(
            StatFileData ds,  
            DateTime startDateTime,
            DateTime endDateTime,
            int webReportGroupID,
            int organizationID,
            int dateTypeID,
            int exportFileID,
            Boolean seperateFiles,
            int closeCaseTriggerID,
            int closeCaseOverride

            )
        {

            String procedureName = "GetStatFileReferral";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            String[] dataTableList = { 
                                        ds.CreatedDateReferral.TableName
                                        , ds.LastModifiedDateReferral.TableName
                                     };
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "StartDateTime", DbType.DateTime, startDateTime);
            _db.AddInParameter(command, "EndDateTime", DbType.DateTime, endDateTime);
            _db.AddInParameter(command, "WebReportGroupID", DbType.Int32, webReportGroupID);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
            _db.AddInParameter(command, "DateTypeID", DbType.Int32, dateTypeID);
            _db.AddInParameter(command, "SeperateFiles", DbType.Boolean, seperateFiles);

            if (exportFileID > 0) 
                _db.AddInParameter(command, "ExportFileID", DbType.Int32, exportFileID);
            if (closeCaseTriggerID > 0) 
                _db.AddInParameter(command, "CloseCaseTriggerID", DbType.Int32, closeCaseTriggerID);
            if (closeCaseOverride > 0) 
                _db.AddInParameter(command, "CloseCaseOverride", DbType.Int32, closeCaseOverride);

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
        #region ReferralEvent
        public static void GetReferralEvent(
            StatFileData ds,
            DateTime startDateTime,
            DateTime endDateTime,
            int webReportGroupID,
            int organizationID,
            int dateTypeID,
            int exportFileID,
            Boolean seperateFiles,
            int closeCaseTriggerID,
            int closeCaseOverride

            )
        {

            String procedureName = "GetStatFileReferralEvent";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            String[] dataTableList = { 
                                        ds.CreatedDateEvent.TableName
                                        , ds.LastModifiedDateEvent.TableName
                                     };
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "StartDateTime", DbType.DateTime, startDateTime);
            _db.AddInParameter(command, "EndDateTime", DbType.DateTime, endDateTime);
            _db.AddInParameter(command, "WebReportGroupID", DbType.Int32, webReportGroupID);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
            _db.AddInParameter(command, "DateTypeID", DbType.Int32, dateTypeID);
            _db.AddInParameter(command, "SeperateFiles", DbType.Boolean, seperateFiles);

            if (exportFileID > 0)
                _db.AddInParameter(command, "ExportFileID", DbType.Int32, exportFileID);
            if (closeCaseTriggerID > 0)
                _db.AddInParameter(command, "CloseCaseTriggerID", DbType.Int32, closeCaseTriggerID);
            if (closeCaseOverride > 0)
                _db.AddInParameter(command, "CloseCaseOverride", DbType.Int32, closeCaseOverride);

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
        
        #region ExportFile

        public static void GetExportFile(StatFileData ds, int organizationID, int exportFileID)
        {
            String procedureName = "GetExportFileConfiguration";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            String[] dataTableList = { 
                                        ds.ExportFileXslt.TableName
                                        , ds.ExportFileDataType.TableName
                                        , ds.ExportFileType.TableName
                                        , ds.ExportFile.TableName
                                     };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            if(exportFileID > 0)
                _db.AddInParameter(command, "@ExportFileConfigurationID", DbType.Int32, exportFileID);
            if(organizationID > 0)
                _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
            /*
             * THESE ARE NOT CURRENTLY USED
            _db.AddInParameter(command, "WebReportGroupID", DbType.Int32, WebReportGroupID);
            _db.AddInParameter(command, "ExportFileDirectoryPath", DbType.AnsiString, ExportFileDirectoryPath);
            _db.AddInParameter(command, "ExportFileRecurringDateType", DbType.Int32, ExportFileRecurringDateType);
            _db.AddInParameter(command, "ExportFileLastRefresh", DbType.DateTime, ExportFileLastRefresh);
            _db.AddInParameter(command, "ExportFileOn", DbType.Byte, ExportFileOn);
            _db.AddInParameter(command, "ExportFileTypeID", Unknown, ExportFileTypeID);
            _db.AddInParameter(command, "LastModified", DbType.DateTime, LastModified);
            _db.AddInParameter(command, "ExportFileFromDate", DbType.DateTime, ExportFileFromDate);
            _db.AddInParameter(command, "ExportFileToDate", DbType.DateTime, ExportFileToDate);
            _db.AddInParameter(command, "ExportFileName", DbType.AnsiString, ExportFileName);
            _db.AddInParameter(command, "ExportFileFrequency", Unknown, ExportFileFrequency);
            _db.AddInParameter(command, "ExportFileDateType", Unknown, ExportFileDateType);
            _db.AddInParameter(command, "ExportFileOccursAt", DbType.AnsiString, ExportFileOccursAt);
            _db.AddInParameter(command, "ExportFileFileDateType", Unknown, ExportFileFileDateType);
            _db.AddInParameter(command, "ExportFileSeparateFiles", Unknown, ExportFileSeparateFiles);
            _db.AddInParameter(command, "ExportFileTZ", DbType.AnsiString, ExportFileTZ);
            _db.AddInParameter(command, "UpdatedFlag", Unknown, UpdatedFlag);
            _db.AddInParameter(command, "CloseCaseTriggerID", DbType.Int32, CloseCaseTriggerID);
            _db.AddInParameter(command, "CloseCaseOverride", DbType.Int32, CloseCaseOverride);
            _db.AddInParameter(command, "ExportFileFrequencyQuantity", DbType.Int32, ExportFileFrequencyQuantity);
            _db.AddInParameter(command, "LastStatEmployeeID", DbType.Int32, LastStatEmployeeID);
            _db.AddInParameter(command, "AuditLogTypeID", DbType.Int32, AuditLogTypeID);
            */


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

        public static void UpdateExportFile(StatFileData ds, Database _db, IDbTransaction transaction, int statEmployeeID)
        {
            String[] procedureName = {
										 "InsertExportFile",                       
										 "UpdateExportFile",
										 "DeleteExportFile"
									 };

            //set table to fill
            String dataTableList = ds.ExportFile.TableName;
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			
			_db.AddInParameter(insertCommand, "ExportFileID" , DbType.Int32, "ExportFileID", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "OrganizationID" , DbType.Int32, "OrganizationID", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "WebReportGroupID" , DbType.Int32, "WebReportGroupID", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileDirectoryPath" , DbType.String, "ExportFileDirectoryPath", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileRecurringDateType" , DbType.Int32, "ExportFileRecurringDateType", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileLastRefresh" , DbType.DateTime, "ExportFileLastRefresh", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileOn" , DbType.Int16, "ExportFileOn", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileTypeID" , DbType.Int16, "ExportFileTypeID", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "LastModified" , DbType.DateTime, "LastModified", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileFromDate" , DbType.DateTime, "ExportFileFromDate", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileToDate" , DbType.DateTime, "ExportFileToDate", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileName" , DbType.String, "ExportFileName", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileFrequency" , DbType.Int16, "ExportFileFrequency", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileDateType" , DbType.Int16, "ExportFileDateType", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileOccursAt" , DbType.String, "ExportFileOccursAt", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileFileDateType" , DbType.Int16, "ExportFileFileDateType", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileSeparateFiles" , DbType.Int16, "ExportFileSeparateFiles", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileTZ" , DbType.String, "ExportFileTZ", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "UpdatedFlag" , DbType.Int16, "UpdatedFlag", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "CloseCaseTriggerID" , DbType.Int32, "CloseCaseTriggerID", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "CloseCaseOverride" , DbType.Int32, "CloseCaseOverride", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "ExportFileFrequencyQuantity" , DbType.Int32, "ExportFileFrequencyQuantity", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "LastStatEmployeeID" , DbType.Int32, statEmployeeID);
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
			
			_db.AddInParameter(updateCommand, "ExportFileID" , DbType.Int32, "ExportFileID", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "OrganizationID" , DbType.Int32, "OrganizationID", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "WebReportGroupID" , DbType.Int32, "WebReportGroupID", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileDirectoryPath" , DbType.String, "ExportFileDirectoryPath", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileRecurringDateType" , DbType.Int32, "ExportFileRecurringDateType", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileLastRefresh" , DbType.DateTime, "ExportFileLastRefresh", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileOn" , DbType.Int16, "ExportFileOn", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileTypeID" , DbType.Int16, "ExportFileTypeID", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "LastModified" , DbType.DateTime, "LastModified", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileFromDate" , DbType.DateTime, "ExportFileFromDate", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileToDate" , DbType.DateTime, "ExportFileToDate", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileName" , DbType.String, "ExportFileName", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileFrequency" , DbType.Int16, "ExportFileFrequency", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileDateType" , DbType.Int16, "ExportFileDateType", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileOccursAt" , DbType.String, "ExportFileOccursAt", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileFileDateType" , DbType.Int16, "ExportFileFileDateType", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileSeparateFiles" , DbType.Int16, "ExportFileSeparateFiles", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileTZ" , DbType.String, "ExportFileTZ", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "UpdatedFlag" , DbType.Int16, "UpdatedFlag", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "CloseCaseTriggerID" , DbType.Int32, "CloseCaseTriggerID", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "CloseCaseOverride" , DbType.Int32, "CloseCaseOverride", DataRowVersion.Current);
			_db.AddInParameter(updateCommand, "ExportFileFrequencyQuantity" , DbType.Int32, "ExportFileFrequencyQuantity", DataRowVersion.Current);
            //_db.AddInParameter(insertCommand, "LastStatEmployeeID", DbType.Int32, statEmployeeID);
			
			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "ExportFileID", DbType.Int32, "ExportFileID", DataRowVersion.Current);
            //insert_db.AddInParameter(command, "LastStatEmployeeID", DbType.Int32, statEmployeeID);

            
            
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                ds,                
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                (DbTransaction)transaction
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
