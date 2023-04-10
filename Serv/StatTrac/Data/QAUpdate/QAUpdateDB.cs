using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.QAUpdate
{
    public class QAUpdateDB
    {
        //Fill QA tables
        #region FillQAMonitoringForm
        public static void FillQAMonitoringForm(QAUpdateData ds, Int32 QAMonitoringFormID, Int32 OrganizationID, string QATrackingNumber, Int32 EmployeeID)
        {
            string procedureName = "GetQAMonitoringForm";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAMonitoringForm.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QAMonitoringFormID", DbType.Int32, QAMonitoringFormID);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QATrackingNumber", DbType.String, QATrackingNumber);
            _db.AddInParameter(command, "EmployeeID", DbType.Int32, EmployeeID);

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
        public static void FillQAMonitoringForm(QAUpdateData ds, Int32 OrganizationID, Int16 QAActive)
        {
            string procedureName = "GetQAMonitoringForms";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAMonitoringForm.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAMonitoringFormActive", DbType.Int32, QAActive);

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
        public static void FillQAMonitoringForm(QAUpdateData ds, Int32 QAMonitoringFormID)
        {
            string procedureName = "GetQAMonitoringFormSingle";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAMonitoringForm.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QAMonitoringFormID", DbType.Int32, QAMonitoringFormID);
           

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
        #region FillQAProcessStep
        public static void FillQAProcessStep(QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAProcessStepActive)
        {
            string procedureName = "GetQAProcessStep";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAProcessStep.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAProcessStepActive", DbType.Int32, QAProcessStepActive);

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
        #region FillQAErrorLocation
        public static void FillQAErrorLocation(QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAErrorLocationActive,
            Int32 QATrackingTypeID)
        {
            string procedureName = "GetQAErrorLocation";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorLocation.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAErrorLocationActive", DbType.Int16, QAErrorLocationActive);
            _db.AddInParameter(command, "QATrackingTypeID", DbType.Int32, QATrackingTypeID);

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
        #region FillQATracking
        public static void FillQATracking(QAUpdateData ds, String QATrackingNumber, Int32 OrganizationID)
        {
            string procedureName = "GetQATracking";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QATracking.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingNumber", DbType.String, QATrackingNumber);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);

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
        public static void FillQATracking(QAUpdateData ds, String QATrackingNumber)
        {
            string procedureName = "GetQATrackingbyNumber";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QATracking.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingNumber", DbType.String, QATrackingNumber);

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
        public static void FillQATrackingForm(QAUpdateData ds, int QATrackingFormID)
        {
            string procedureName = "GetQATrackingForm";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QATrackingForm.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingFormID", DbType.String, QATrackingFormID);

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
        #region FillQATrackingType
        public static void FillQATrackingType(QAUpdateData ds, Int32 OrganizationID)
        {
            string procedureName = "GetQATrackingType";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QATrackingType.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
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
        #region FillQATrackingStatus
        public static void FillQATrackingStatus(QAUpdateData ds, Int32 QATrackingStatusID)
        {
            string procedureName = "GetQATrackingStatus";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QATrackingStatus.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingStatusID", DbType.Int32, QATrackingStatusID);

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
        #region FillQAErrorStatus
        public static void FillQAErrorStatus(QAUpdateData ds)
        {
            string procedureName = "GetQAErrorStatus";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorStatus.TableName };
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
        #endregion
        #region FillQAMonitoringFormTemplate
        public static void FillQAMonitoringFormTemplate(QAUpdateData ds, Int32 QAMonitoringFormID)
        {
            string procedureName = "GetQAMonitoringFormTemplate";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAMonitoringFormTemplate.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "QAMonitoringFormID", DbType.Int32, QAMonitoringFormID);

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
        #region FillQAForms
        public static void FillQAForm(QAUpdateData ds, Int32 OrganizationID, Int32 ErrorTypeID, Int32 TrackingTypeID)
        {
            string procedureName = "GetQAForm";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.DdlQAForms.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "ErrorTypeID", DbType.Int32, ErrorTypeID);
            _db.AddInParameter(command, "TrackingTypeID", DbType.Int32, TrackingTypeID);
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
        #region FillQAErrorType
        public static void FillQAErrorType(QAUpdateData ds,
            Int32 QAErrorTypeID)
        {
            string procedureName = "GetQAErrorType";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorType.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QAErrorTypeID", DbType.Int32, QAErrorTypeID);
            
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
        public static void FillQAErrorType(QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAProcessStepActive)
        {
            string procedureName = "GetQAErrorType";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorType.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAErrorTypeActive", DbType.Int16, QAProcessStepActive);

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
        #region FillQAErrorLogHowIdentified
        public static void FillQAErrorLogHowIdentified(QAUpdateData ds)
        {
            string procedureName = "GetQAErrorLogHowIdentified";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorLogHowIdentified.TableName };
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
        #endregion
        #region FillddlProcessStep
        public static void FillProcessStep(QAUpdateData ds, Int32 OrganizationID)
        {
            string procedureName = "GetQAProcessSteps";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.DdlProcessStep.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);

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
        #region FillddlErrorTypes
        public static void FillErrorType(QAUpdateData ds, Int32 OrganizationID, Int32 QAErrorLocationID, Int32 QATrackingTypeID)
        {
            string procedureName = "GetQAErrorTypes";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.DdlErrorType.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAErrorLocationID", DbType.Int32, QAErrorLocationID);
            _db.AddInParameter(command, "QATrackingTypeID", DbType.Int32, QATrackingTypeID);

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
        #region FillQAErrorLog
        public static void FillQAErrorLog(QAUpdateData ds,
            Int32 QAErrorTypeID,Int32 StatEmployeeID, Int32 QAErrorLocationID)
        {
            string procedureName = "GetQAErrorLog";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorLog.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "StatEmployeeID", DbType.Int32, StatEmployeeID);
            _db.AddInParameter(command, "QAErrorLocationID", DbType.Int32, QAErrorLocationID);
            _db.AddInParameter(command, "QAErrorTypeID", DbType.Int32, QAErrorTypeID);

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
        public static void FillQAErrorLog(QAUpdateData ds,
            Int32 StatEmployeeID, Int32 QAErrorLocationID)
        {
            string procedureName = "GetQAErrorLogEmpLocation";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorLog.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "StatEmployeeID", DbType.Int32, StatEmployeeID);
            _db.AddInParameter(command, "QAErrorLocationID", DbType.Int32, QAErrorLocationID);

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
        public static void FillQAErrorLog(QAUpdateData ds,
            Int32 QAErrorLogID)
        {
            string procedureName = "GetQAErrorLogSingle";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorLog.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QAErrorLogID", DbType.Int32, QAErrorLogID);
           
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
        public static void FillQAErrorLogTrackingNumber(QAUpdateData ds,
            String TrackingNumber, Int32 qATrackingFormID)
        {
            string procedureName = "GetQAErrorLogTrackingNumber";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QAErrorLog.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingNumber", DbType.String, TrackingNumber);
            _db.AddInParameter(command, "QATrackingFormID", DbType.Int32, qATrackingFormID);

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
        #region FillQAGridManageErrorLists
        public static void FillQAGridManageErrorLists(QAUpdateData ds,
            Int32 OrganizationID,
            Int32 QAMonitoringFormID,
            Int16 QAErrorTypeActive)
        {
            string procedureName = "GetQAGridManageErrorLists1";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridManageErrorLists.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAMonitoringFormID", DbType.Int32, QAMonitoringFormID);
            _db.AddInParameter(command, "QAErrorTypeActive", DbType.Int16, QAErrorTypeActive);

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
        public static void FillQAGridManageErrorLists(QAUpdateData ds,
            Int32 OrganizationID,
            Int32 QAErrorTypeActive,
            Int32 QATrackingTypeID)
        {
            string procedureName = "GetQAGridManageErrorLists";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridManageErrorLists.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAErrorTypeActive", DbType.Int16, QAErrorTypeActive);
            _db.AddInParameter(command, "QATrackingTypeID", DbType.Int32, QATrackingTypeID);
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
        #region FillQAGridErrorTypeLog
        public static void FillQAGridErrorTypeLog(QAUpdateData ds,
            Int32 QATrackingID,
            Int32 QAErrorLocationID,
            Int32 PersonID)
        {
            string procedureName = "GetQAGridErrorTypeLog";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridErrorTypeLog.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingID", DbType.Int32, QATrackingID);
            _db.AddInParameter(command, "QAErrorLocationID", DbType.Int32, QAErrorLocationID);
            _db.AddInParameter(command, "PersonID", DbType.Int32, PersonID);

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
        #region FillQAGridErrorTypesByEmployee
        public static void FillQAGridErrorTypesByEmployee(QAUpdateData ds,
            String QATrackingNumber,
            Int32 OrganizationID,Int32 TrackingTypeID)
        {
            string procedureName = "GetQAGridErrorTypesByEmployee";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridErrorTypesByEmployee.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QATrackingNumber", DbType.String, QATrackingNumber);
            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "TrackingTypeID", DbType.Int32, TrackingTypeID);
           
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
        
        #region FillQAGridManageQualityMonitoringForms
        public static void FillQAGridManageQualityMonitoringForms(QAUpdateData ds,
            Int32 OrganizationID,
            Int32 QAMonitoringFormActive)
        {
            string procedureName = "GetQAGridManageQualityMonitoringForms";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridManageQualityMonitoringForms.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "QAMonitoringFormActive", DbType.Int32, QAMonitoringFormActive);

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
        #region FillQAGridAddEditQualityMonitoringForm
        public static void FillQAGridAddEditQualityMonitoringForm(QAUpdateData ds,
            Int32 FormID, Int32 TrackingFormID
            )
        {
            string procedureName = "GetQAGridAddEditQualityMonitoringForm";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridAddEditQualityMonitoringForm.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "QAMonitoringFormID", DbType.Int32, FormID);
            _db.AddInParameter(command, "QATrackingFormID", DbType.Int32, TrackingFormID);

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
        #region FillRefInfo
        public static void FillQARefInfo(QAUpdateData ds, string CallID, int webReportGroupID)
        {
            string procedureName = "GetReferralInfo";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.QARefInfo.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.String, CallID );
            _db.AddInParameter(command, "WebReportGroupID", DbType.Int32, webReportGroupID);
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
        //Update QA tables: Insert, Update and Delete
        #region UpdateQAMonitoringForm
        public static void UpdateQAMonitoringForm(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAMonitoringForm";
            string updateProcedureName = "UpdateQAMonitoringForm";
            string deleteProcedureName = "DeleteQAMonitoringForm";

            string dataTable = qaUpdate.QAMonitoringForm.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormName", DbType.String, "QAMonitoringFormName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormCalculateScore", DbType.Int16, "QAMonitoringFormCalculateScore", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormRequireReview", DbType.Int16, "QAMonitoringFormRequireReview", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormActive", DbType.Int16, "QAMonitoringFormActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormInactiveComments", DbType.String, "QAMonitoringFormInactiveComments", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormScore", DbType.Decimal, "QAMonitoringFormScore", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormID", DbType.Int32, "QAMonitoringFormID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormName", DbType.String, "QAMonitoringFormName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormCalculateScore", DbType.Int16, "QAMonitoringFormCalculateScore", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormRequireReview", DbType.Int16, "QAMonitoringFormRequireReview", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormActive", DbType.Int16, "QAMonitoringFormActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormInactiveComments", DbType.String, "QAMonitoringFormInactiveComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormScore", DbType.Decimal, "QAMonitoringFormScore", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAMonitoringFormID", DbType.Int32, "QAMonitoringFormID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);


            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQAProcessStep
        public static void UpdateQAProcessStep(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAProcessStep";
            string updateProcedureName = "UpdateQAProcessStep";
            string deleteProcedureName = "DeleteQAProcessStep";

            string dataTable = qaUpdate.QAProcessStep.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAProcessStepDescription", DbType.String, "QAProcessStepDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAProcessStepActive", DbType.Int16, "QAProcessStepActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);


            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAProcessStepDescription", DbType.String, "QAProcessStepDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAProcessStepActive", DbType.Int16, "QAProcessStepActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);


            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQAErrorLocation
        public static void UpdateQAErrorLocation(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAErrorLocation";
            string updateProcedureName = "UpdateQAErrorLocation";
            string deleteProcedureName = "DeleteQAErrorLocation";

            string dataTable = qaUpdate.QAErrorLocation.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLocationDescription", DbType.String, "QAErrorLocationDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLocationActive", DbType.Int16, "QAErrorLocationActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLocationDescription", DbType.String, "QAErrorLocationDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLocationActive", DbType.Int16, "QAErrorLocationActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);


            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQATracking
        public static void UpdateQATracking(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQATracking";
            string updateProcedureName = "UpdateQATracking";
            string deleteProcedureName = "DeleteQATracking";

            string dataTable = qaUpdate.QATracking.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingNumber", DbType.String, "QATrackingNumber", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingNotes", DbType.String, "QATrackingNotes", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingSourceCode", DbType.String, "QATrackingSourceCode", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingReferralDateTime", DbType.DateTime, "QATrackingReferralDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingReferralTypeID", DbType.Int32, "QATrackingReferralTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingStatusID", DbType.Int32, "QATrackingStatusID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QATrackingID", DbType.Int32, "QATrackingID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingNumber", DbType.String, "QATrackingNumber", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingNotes", DbType.String, "QATrackingNotes", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingSourceCode", DbType.String, "QATrackingSourceCode", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingReferralDateTime", DbType.DateTime, "QATrackingReferralDateTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingReferralTypeID", DbType.Int32, "QATrackingReferralTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingStatusID", DbType.Int32, "QATrackingStatusID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QATrackingID", DbType.Int32, "QATrackingID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);


            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQATrackingType
        public static void UpdateQATrackingType(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQATrackingType";
            string updateProcedureName = "UpdateQATrackingType";
            string deleteProcedureName = "DeleteQATrackingType";

            string dataTable = qaUpdate.QATrackingType.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingTypeDescription", DbType.String, "QATrackingTypeDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingTypeDescription", DbType.String, "QATrackingTypeDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);


            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQATrackingStatus
        public static void UpdateQATrackingStatus(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQATrackingStatus";
            string updateProcedureName = "UpdateQATrackingStatus";
            string deleteProcedureName = "DeleteQATrackingStatus";

            string dataTable = qaUpdate.QATrackingStatus.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
	        _db.AddInParameter(insertCommand, "@QATrackingStatusDescription", DbType.String, "QATrackingStatusDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QATrackingStatusID", DbType.Int32, "QATrackingStatusID", DataRowVersion.Current);
	        _db.AddInParameter(updateCommand, "@QATrackingStatusDescription", DbType.String, "QATrackingStatusDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QATrackingStatusID", DbType.Int32, "QATrackingStatusID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQAErrorStatus
        public static void UpdateQAErrorStatus(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAErrorStatus";
            string updateProcedureName = "UpdateQAErrorStatus";
            string deleteProcedureName = "DeleteQAErrorStatus";

            string dataTable = qaUpdate.QAErrorStatus.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
	        _db.AddInParameter(insertCommand, "@QAErrorStatusDescription", DbType.String, "QAErrorStatusDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAErrorStatusID", DbType.Int32, "QAErrorStatusID", DataRowVersion.Current);
	        _db.AddInParameter(updateCommand, "@QAErrorStatusDescription", DbType.String, "QAErrorStatusDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAErrorStatusID", DbType.Int32, "QAErrorStatusID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQAMonitoringFormTemplate
        public static void UpdateQAMonitoringFormTemplate(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAMonitoringFormTemplate";
            string updateProcedureName = "UpdateQAMonitoringFormTemplate";
            string deleteProcedureName = "DeleteQAMonitoringFormTemplate";

            string dataTable = qaUpdate.QAMonitoringFormTemplate.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormID", DbType.Int32, "QAMonitoringFormID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormTemplateOrder", DbType.Int32, "QAMonitoringFormTemplateOrder", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormTemplateActive", DbType.Int16, "QAMonitoringFormTemplateActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormTemplateID", DbType.Int32, "QAMonitoringFormTemplateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormID", DbType.Int32, "QAMonitoringFormID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormTemplateOrder", DbType.Int32, "QAMonitoringFormTemplateOrder", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormTemplateActive", DbType.Int16, "QAMonitoringFormTemplateActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAMonitoringFormTemplateID", DbType.Int32, "QAMonitoringFormTemplateID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQAErrorType
        public static void UpdateQAErrorType(QAUpdateData qaUpdate,int errorTypeID)
        {
            string updateProcedureName = "UpdateQAErrorType";
            string deleteProcedureName = "DeleteQAErrorType";

            string dataTable = qaUpdate.QAErrorType.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);


            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAErrorTypeID", DbType.Int32, errorTypeID);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeDescription", DbType.String, "QAErrorTypeDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorRequireReview", DbType.Int16, "QAErrorRequireReview", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeActive", DbType.Int16, "QAErrorTypeActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeInactiveComments", DbType.String, "QAErrorTypeInactiveComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeAssignedPoints", DbType.Int32, "QAErrorTypeAssignedPoints", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeAutomaticZeroScore", DbType.Int16, "QAErrorTypeAutomaticZeroScore", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeDisplayNA", DbType.Int16, "QAErrorTypeDisplayNA", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeDisplayComments", DbType.Int16, "QAErrorTypeDisplayComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeGenerateLogIfNo", DbType.Int16, "QAErrorTypeGenerateLogIfNo", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeGenerateLogIfYes", DbType.Int16, "QAErrorTypeGenerateLogIfYes", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            
            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    null,
                    //insertCommand,
                    updateCommand,
                    deleteCommand,
                    //transaction);
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        public static void UpdateQAErrorType(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAErrorType";
            string updateProcedureName = "UpdateQAErrorType";
            string deleteProcedureName = "DeleteQAErrorType";

            string dataTable = qaUpdate.QAErrorType.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

             //build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeDescription", DbType.String, "QAErrorTypeDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorRequireReview", DbType.Int16, "QAErrorRequireReview", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeActive", DbType.Int16, "QAErrorTypeActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeInactiveComments", DbType.String, "QAErrorTypeInactiveComments", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeAssignedPoints", DbType.Int32, "QAErrorTypeAssignedPoints", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeAutomaticZeroScore", DbType.Int16, "QAErrorTypeAutomaticZeroScore", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeDisplayNA", DbType.Int16, "QAErrorTypeDisplayNA", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeDisplayComments", DbType.Int16, "QAErrorTypeDisplayComments", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeGenerateLogIfNo", DbType.Int16, "QAErrorTypeGenerateLogIfNo", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeGenerateLogIfYes", DbType.Int16, "QAErrorTypeGenerateLogIfYes", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingTypeID", DbType.Int32, "QATrackingTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeDescription", DbType.String, "QAErrorTypeDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorRequireReview", DbType.Int16, "QAErrorRequireReview", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeActive", DbType.Int16, "QAErrorTypeActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeInactiveComments", DbType.String, "QAErrorTypeInactiveComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeAssignedPoints", DbType.Int32, "QAErrorTypeAssignedPoints", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeAutomaticZeroScore", DbType.Int16, "QAErrorTypeAutomaticZeroScore", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeDisplayNA", DbType.Int16, "QAErrorTypeDisplayNA", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeDisplayComments", DbType.Int16, "QAErrorTypeDisplayComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeGenerateLogIfNo", DbType.Int16, "QAErrorTypeGenerateLogIfNo", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeGenerateLogIfYes", DbType.Int16, "QAErrorTypeGenerateLogIfYes", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable, 
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        public static void UpdateQAErrorTypeDelete(QAUpdateData qaUpdate, int errorTypeID)
        {
            string procedureName = "DeleteQAErrorType";
            string dataTable = qaUpdate.QAErrorType.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

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
        #endregion
        #region UpdateQAErrorLogHowIdentified
        public static void UpdateQAErrorLogHowIdentified(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAErrorLogHowIdentified";
            string updateProcedureName = "UpdateQAErrorLogHowIdentified";
            string deleteProcedureName = "DeleteQAErrorLogHowIdentified";

            string dataTable = qaUpdate.QAErrorLogHowIdentified.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@QAErrorLogHowIdentifiedDescription", DbType.Int32, "QAErrorLogHowIdentifiedDescription", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAErrorLogHowIdentifiedID", DbType.Int32, "QAErrorLogHowIdentifiedID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogHowIdentifiedDescription", DbType.Int32, "QAErrorLogHowIdentifiedDescription", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAErrorLogHowIdentifiedID", DbType.Int32, "QAErrorLogHowIdentifiedID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion
        #region UpdateQAErrorLog
        public static void UpdateQAErrorLog(QAUpdateData qaUpdate)
        {
            //string insertProcedureName = "InsertQAErrorLog";
            string insertProcedureName = "UpdateQAErrorLog";
            string updateProcedureName = "UpdateQAErrorLog";
            string deleteProcedureName = "DeleteQAErrorLog";

            string dataTable = qaUpdate.QAErrorLog.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@QAErrorLogID", DbType.Int32, "QAErrorLogID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingID", DbType.Int32, "QATrackingID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormTemplateID", DbType.Int32, "QAMonitoringFormTemplateID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogNumberOfErrors", DbType.Int32, "QAErrorLogNumberOfErrors", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogDateTime", DbType.DateTime, "QAErrorLogDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogHowIdentifiedID", DbType.Int32, "QAErrorLogHowIdentifiedID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogTicketNumber", DbType.String, "QAErrorLogTicketNumber", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogComments", DbType.String, "QAErrorLogComments", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogCorrection", DbType.String, "QAErrorLogCorrection", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogCorrectionPersonID", DbType.Int32, "QAErrorLogCorrectionPersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogCorrectionLastModified", DbType.DateTime, "QAErrorLogCorrectionLastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPointsYes", DbType.Int16, "QAErrorLogPointsYes", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPointsNo", DbType.Int16, "QAErrorLogPointsNo", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPointsNA", DbType.Int16, "QAErrorLogPointsNA", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorStatusID", DbType.Int32, "QAErrorStatusID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPersonID", DbType.Int32, "QAErrorLogPersonID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QAErrorLogID", DbType.Int32, "QAErrorLogID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingID", DbType.Int32, "QATrackingID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAMonitoringFormTemplateID", DbType.Int32, "QAMonitoringFormTemplateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogNumberOfErrors", DbType.Int32, "QAErrorLogNumberOfErrors", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogDateTime", DbType.DateTime, "QAErrorLogDateTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogHowIdentifiedID", DbType.Int32, "QAErrorLogHowIdentifiedID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogTicketNumber", DbType.String, "QAErrorLogTicketNumber", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogComments", DbType.String, "QAErrorLogComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogCorrection", DbType.String, "QAErrorLogCorrection", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogCorrectionPersonID", DbType.String, "QAErrorLogCorrectionPersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogCorrectionLastModified", DbType.DateTime, "QAErrorLogCorrectionLastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogPointsYes", DbType.Int16, "QAErrorLogPointsYes", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogPointsNo", DbType.Int16, "QAErrorLogPointsNo", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogPointsNA", DbType.Int16, "QAErrorLogPointsNA", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorStatusID", DbType.Int32, "QAErrorStatusID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogPersonID", DbType.Int32, "QAErrorLogPersonID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QAErrorLogID", DbType.Int32, "QAErrorLogID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Original);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        //temp fix 
        public static void UpdateQAErrorLogInsert(QAUpdateData qaUpdate)
        {
            string insertProcedureName = "InsertQAErrorLog";
           
            string dataTable = qaUpdate.QAErrorLog.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            //_db.AddInParameter(insertCommand, "@QAErrorLogID", DbType.Int32, "QAErrorLogID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingID", DbType.Int32, "QATrackingID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLocationID", DbType.Int32, "QAErrorLocationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorTypeID", DbType.Int32, "QAErrorTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAMonitoringFormTemplateID", DbType.Int32, "QAMonitoringFormTemplateID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogNumberOfErrors", DbType.Int32, "QAErrorLogNumberOfErrors", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogDateTime", DbType.DateTime, "QAErrorLogDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogHowIdentifiedID", DbType.Int32, "QAErrorLogHowIdentifiedID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogTicketNumber", DbType.String, "QAErrorLogTicketNumber", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogComments", DbType.String, "QAErrorLogComments", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogCorrection", DbType.String, "QAErrorLogCorrection", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogCorrectionPersonID", DbType.Int32, "QAErrorLogCorrectionPersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogCorrectionLastModified", DbType.DateTime, "QAErrorLogCorrectionLastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPointsYes", DbType.Int16, "QAErrorLogPointsYes", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPointsNo", DbType.Int16, "QAErrorLogPointsNo", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPointsNA", DbType.Int16, "QAErrorLogPointsNA", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorStatusID", DbType.Int32, "QAErrorStatusID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogPersonID", DbType.Int32, "QAErrorLogPersonID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    null,
                    null,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        public static void UpdateQAErrorLogDelete(int QAErrorLogID, int LastStatEmployeeID)
        {
           
            string procedureName = "DeleteQAErrorLog";

            //string dataTable = qaUpdate.QAErrorLog.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);


            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@QAErrorLogID", DbType.Int32, QAErrorLogID);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, LastStatEmployeeID);

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
        public static void UpdateQAErrorLogDeleteMulti(int QAErrorLocationID, int QAErrorLogPersonID, int LastStatEmployeeID)
        {
           
            string procedureName = "DeleteQAErrorLogMulti";

            //string dataTable = qaUpdate.QAErrorLog.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@QAErrorLogPersonID", DbType.Int32, QAErrorLogPersonID);
            _db.AddInParameter(updateCommand, "@QAErrorLocationID", DbType.Int32, QAErrorLocationID);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, LastStatEmployeeID);

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
        #endregion
        #region Update Tracking Form
        public static void UpdateQATrackingForm(QAUpdateData qaUpdate)
        {
            //string insertProcedureName = "InsertQAErrorLog";
            string insertProcedureName = "InsertQATrackingForm";
            string updateProcedureName = "UpdateQATrackingForm";
            string deleteProcedureName = "DeleteQATrackingForm";

            string dataTable = qaUpdate.QATrackingForm.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@QATrackingFormID", DbType.Int32, "QATrackingFormID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingEventDateTime", DbType.DateTime, "QATrackingEventDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingCAPANumber", DbType.String, "QATrackingCAPANumber", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingApproved", DbType.Int16, "QATrackingApproved", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingStatusID", DbType.Int32, "QATrackingStatusID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingFormPoints", DbType.Decimal, "QATrackingFormPoints", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingFormComments", DbType.String, "QATrackingFormComments", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QATrackingFormID", DbType.Int32, "QATrackingFormID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAProcessStepID", DbType.Int32, "QAProcessStepID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingEventDateTime", DbType.DateTime, "QATrackingEventDateTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingCAPANumber", DbType.String, "QATrackingCAPANumber", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingApproved", DbType.Int16, "QATrackingApproved", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingStatusID", DbType.Int32, "QATrackingStatusID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingFormPoints", DbType.Decimal, "QATrackingFormPoints", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingFormComments", DbType.String, "QATrackingFormComments", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QATrackingFormID", DbType.Int32, "@QATrackingFormID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Original);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        
        public static void UpdateQATrackingFormDelete(int QATrackingFormID, int LastStatEmployeeID)
        {

            string procedureName = "DeleteQATrackingForm";

            //string dataTable = qaUpdate.QAErrorLog.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);


            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@QATrackingFormID", DbType.Int32, QATrackingFormID);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, LastStatEmployeeID);

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
       
        #endregion
        #region Update Tracking Form Errors
        public static void UpdateQATrackingFormErrors(QAUpdateData qaUpdate)
        {
            //string insertProcedureName = "InsertQAErrorLog";
            string insertProcedureName = "InsertQATrackingFormErrors";
            string updateProcedureName = "UpdateQATrackingFormErrors";
            string deleteProcedureName = "DeleteQATrackingFormErrors";

            string dataTable = qaUpdate.QATrackingFormErrors.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(insertProcedureName);
            _db.AddInParameter(insertCommand, "@QATrackingFormErrorsID", DbType.Int32, "QATrackingFormID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QATrackingFormID", DbType.Int32, "QATrackingFormID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@QAErrorLogID", DbType.Int32, "QAErrorLogID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(updateProcedureName);
            _db.AddInParameter(updateCommand, "@QATrackingFormErrorsID", DbType.Int32, "QATrackingFormID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QATrackingFormID", DbType.Int32, "QATrackingFormID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@QAErrorLogID", DbType.Int32, "QAErrorLogID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastModified", DbType.DateTime, "LastModified", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(deleteProcedureName);
            _db.AddInParameter(deleteCommand, "@QATrackingFormErrorsID", DbType.Int32, "@QATrackingFormID", DataRowVersion.Original);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Original);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    qaUpdate,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        
        public static void UpdateQATrackingFormErrorsDelete(int QATrackingFormID, int LastStatEmployeeID)
        {

            string procedureName = "DeleteQATrackingFormErrors";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);


            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@QATrackingFormErrorsID", DbType.Int32, QATrackingFormID);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, LastStatEmployeeID);

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
        
        #endregion
        #region Validate Tracking Number
        public static int GetValidTrackingNumber(Int32 callID, Int32 reportGroupID)
        {
            string procedureName = "GetValidTrackingNumber";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, callID);
            _db.AddInParameter(updateCommand, "@ReportGroupID", DbType.Int32, reportGroupID);
            _db.AddOutParameter(updateCommand, "ReturnVal", DbType.Int32, 0);
            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToInt32(_db.GetParameterValue(updateCommand, "ReturnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        #endregion
        #region Insert Tracking Item
        //parm FromQAForm tells the sproc whether to get the tracking type id or use passed in variable
        public static int InsertTrackingNumber(string trackingNumber, int OrgID, int EmpID, string SourceCode, DateTime RefDateTime, int RefTypeID, int QAFormID, int FromQAForm)
        {
            string procedureName = "InsertTrackingNumber";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "QAOrgID", DbType.String, OrgID);
            _db.AddInParameter(updateCommand, "EmpID", DbType.String, EmpID);
            _db.AddInParameter(updateCommand, "QATrackingNumber", DbType.String, trackingNumber);
            _db.AddInParameter(updateCommand, "SourceCode", DbType.String, SourceCode);
            _db.AddInParameter(updateCommand, "RefDateTime", DbType.DateTime, RefDateTime);
            _db.AddInParameter(updateCommand, "RefTypeID", DbType.Int32, RefTypeID);
            _db.AddInParameter(updateCommand, "QAFormID", DbType.Int32, QAFormID);
            _db.AddInParameter(updateCommand, "FromQAForm", DbType.Int32, FromQAForm);
            _db.AddOutParameter(updateCommand, "ReturnVal", DbType.Int32, 0);
            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToInt32(_db.GetParameterValue(updateCommand, "ReturnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        public static int InsertTrackingNumber(string trackingNumber, int OrgID, int EmpID)
        {
            string procedureName = "InsertTrackingNumber";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "QAOrgID", DbType.String, OrgID);
            _db.AddInParameter(updateCommand, "EmpID", DbType.String, EmpID);
            _db.AddInParameter(updateCommand, "QATrackingNumber", DbType.String, trackingNumber);
            _db.AddInParameter(updateCommand, "SourceCode", DbType.String, "SourceCode", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "RefDateTime", DbType.DateTime, "RefDateTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "RefTypeID", DbType.Int32, "RefTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "QAFormID", DbType.Int32, "QAFormID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "FromQAForm", DbType.Int32, "FromQAForm", DataRowVersion.Current);
            _db.AddOutParameter(updateCommand, "ReturnVal", DbType.Int32, 0);
            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToInt32(_db.GetParameterValue(updateCommand, "ReturnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
         #endregion
        #region Insert Tracking Form 
        public static int InsertTrackingForm(int EmpID,int PersonID)
        {
            string procedureName = "InsertTrackingForm";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "PersonID", DbType.Int32, PersonID);
            _db.AddInParameter(updateCommand, "EmpID", DbType.Int32, EmpID);
            _db.AddOutParameter(updateCommand, "ReturnVal", DbType.Int32, 0);
            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToInt32(_db.GetParameterValue(updateCommand, "ReturnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        #endregion
        #region Get Points
        public static double GetPoints(int QAFormID, int QATrackingFormID)
        {
            string procedureName = "GetPoints";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "QAMonitoringFormID", DbType.Int32, QAFormID);
            _db.AddInParameter(updateCommand, "QATrackingFormID", DbType.Int32, QATrackingFormID);
            _db.AddOutParameter(updateCommand, "returnVal", DbType.Double, 0);
            double returnVal;
            
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToDouble(_db.GetParameterValue(updateCommand, "returnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        #endregion
        #region Get Pending Review
        public static double GetPendingReview(int OrgID, int TrackingID, int QATrackingFormID)
        {
            string procedureName = "GetPendingReview";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "QATrackingID", DbType.Int32, TrackingID);
            _db.AddInParameter(updateCommand, "QATrackingFormID", DbType.Int32, QATrackingFormID);
            _db.AddInParameter(updateCommand, "OrganizationID", DbType.Int32, OrgID);
            _db.AddOutParameter(updateCommand, "returnVal", DbType.Double, 0);
            double returnVal;

            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToDouble(_db.GetParameterValue(updateCommand, "returnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        #endregion
        #region Get PersonID
        public static int GetPersonID(Int32 webPersonID)
        {
            string procedureName = "GetPersonIDByWebPersonId";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@WebPersonID", DbType.Int32, webPersonID);
            _db.AddOutParameter(updateCommand, "ReturnVal", DbType.Int32, 0);
            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToInt32(_db.GetParameterValue(updateCommand, "ReturnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        #endregion
        #region Get QA Person Title
        public static void FillPersonTitleListQA(
            UserData dataSet,
            int organizationID)
        {
            string procedureName = "sps_GetPersonTypesQA";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { dataSet.PersonType.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@OrganizationID", DbType.Int32, organizationID);
            

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                dataSet,
                dataTableList,
                procedureName);
            }
            catch
            {
                throw;
            }

        }

        #endregion
        #region PersonList
        public static void FillPersonList(ReferralData ds, Int32 OrganizationId, Int32 OrganizationID1)
        {
            string procedureName = "GetPersonListByOrganizationIdWeb1";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.PersonbyOrg.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationId", DbType.Int32, OrganizationId);
            _db.AddInParameter(command, "OrganizationID1", DbType.Int32, OrganizationID1);
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
        public static void FillPersonListQA(ReferralData ds, Int32 OrganizationId, Int32 OrganizationID1)
        {
            string procedureName = "GetPersonListByOrganizationIdWeb1";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.PersonbyOrg.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationId", DbType.Int32, OrganizationId);
            _db.AddInParameter(command, "OrganizationID1", DbType.Int32, OrganizationID1);
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
        #region FillQAGridPendingReview
        public static void FillQAGridPendingReview(QAUpdateData ds, int OrganizationID, string PersonIDs, DateTime startDateTime,
            DateTime endDateTime)
        {
            string procedureName = "GetQAGridPendingReview";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.GridPendingReview.TableName };
            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "OrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "Personids", DbType.String, PersonIDs);
            _db.AddInParameter(command, "startDateTime", DbType.DateTime, startDateTime);
            _db.AddInParameter(command, "endDateTime", DbType.DateTime, endDateTime);

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
    }
}
