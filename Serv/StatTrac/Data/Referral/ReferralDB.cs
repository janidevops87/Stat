using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Referral
{
    public class ReferralDB
    {
        #region Referral List
        public static void FillReferralList(ReferralData ds,string CallNumber,string PatientFirstName,string PatientLastName,DateTime startDateTime, DateTime endDateTime,
            Int32 OrganizationID, Int32 ReportGroupID, Int32 SpecialSearchCriteria, string BasedOnDT, string timeZone)
        {
            string procedureName = "GetReferralListReports";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ReferralList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            if (CallNumber == "0")
            {
                CallNumber = null;
            }
            _db.AddInParameter(command, "callNumber", DbType.String, CallNumber);
            _db.AddInParameter(command, "PatientFirstName", DbType.String, PatientFirstName);
            _db.AddInParameter(command, "PatientLastName", DbType.String, PatientLastName);
            _db.AddInParameter(command, "startDateTime", DbType.String, startDateTime);
            _db.AddInParameter(command, "endDateTime", DbType.String, endDateTime);
            _db.AddInParameter(command, "OrganizationID", DbType.String, OrganizationID);
            _db.AddInParameter(command, "ReportGroupID", DbType.String, ReportGroupID);
            _db.AddInParameter(command, "SpecialSearchCriteria", DbType.String, SpecialSearchCriteria);
            _db.AddInParameter(command, "BasedOnDT", DbType.String, BasedOnDT);
            _db.AddInParameter(command, "TimeZone", DbType.String, timeZone);
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

        #region ReportGroup
        public static void FillReportGroupList(ReferralData ds,int userOrgID)
        {
            string procedureName = "sps_ReportGroups";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            string[] dataTableList = { ds.WebReportGroupList.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "vUserOrgID", DbType.Int32, userOrgID);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
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

        #region Donor Category
        public static void FillDonorCategoryList(ReferralData ds, int OrganizationID, string sourceCodeName)
        {
            string procedureName = "sps_DynamicDonorCategoryByOrg2";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            string[] dataTableList = { ds.DonorCategory.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "vOrganizationID", DbType.Int32, OrganizationID);
            _db.AddInParameter(command, "vSourceCodeName", DbType.String, sourceCodeName);

            try
            {
                DBCommands.LoadDataSet(
                _db,
                command,
                ds,
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

        #region Single Referral
        public static void FillReferralSingle(ReferralData ds, Int32 CallID, Int32 UserOrgID, Int32 reportGroupID, string timeZone)
        {
            string procedureName = "GetReferralDetail_Single";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ReferralSingle.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
           
            _db.AddInParameter(command, "CallID", DbType.String, CallID);
            _db.AddInParameter(command, "UserOrgID", DbType.String, UserOrgID);
            _db.AddInParameter(command, "ReportGroupID", DbType.String, reportGroupID);
            _db.AddInParameter(command, "TimeZone", DbType.String, timeZone);
           
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

        #region Approachers
        public static void FillApproacherList(ReferralData ds, Int32 CallID)
        {
            string procedureName = "GetInitialApproacherList";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ApproacherList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.String, CallID);

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

        #region ApproachType
        public static void FillApproacherTypeList(ReferralData ds)
        {
            string procedureName = "GetInitialApproacherType";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ApproacherTypeList.TableName };

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

        #region AppropriateList
        public static void FillAppropriateList(ReferralData ds)
        {
            string procedureName = "sps_RefQueryAppropriate";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.AppropriateList.TableName };

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

        #region ApproachList
        public static void FillApproachList(ReferralData ds)
        {
            string procedureName = "sps_RefQueryApproach";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ApproachList.TableName };

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

        #region ConsentList
        public static void FillConsentList(ReferralData ds)
        {
            string procedureName = "sps_RefQueryConsent";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ConsentList.TableName };

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

        #region RecoveryList
        public static void FillRecoveryList(ReferralData ds)
        {
            string procedureName = "sps_RefQueryConversion";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.RecoveryList.TableName };

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

        #region GetReferral
        public static void FillReferralReport(ReferralData ds, Int32 CallID)
        {
            string procedureName = "GetReferral_Reports";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.Referral.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.Int32, CallID);

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

        #region UpdateReferral
        public static void UpdateReferral(Database _db, ReferralData referralData, int callID, IDbTransaction transaction)
        {
            string procedureName = "UpdateReferral";
									
            string dataTable = referralData.Referral.TableName;

            // build update commands
           
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ReferralID", DbType.Int32, "ReferralID", DataRowVersion.Current);
            //_db.AddInParameter(updateCommand, "CallID", DbType.Int32, "CallID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "CallID", DbType.Int32, callID);
            _db.AddInParameter(updateCommand, "ReferralCallerPhoneID", DbType.Int32, "ReferralCallerPhoneID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCallerExtension", DbType.String, "ReferralCallerExtension", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCallerOrganizationID", DbType.Int32, "ReferralCallerOrganizationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCallerSubLocationID", DbType.Int32, "ReferralCallerSubLocationID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCallerSubLocationLevel", DbType.String, "ReferralCallerSubLocationLevel", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCallerPersonID", DbType.Int32, "ReferralCallerPersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorName", DbType.String, "ReferralDonorName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorRecNumber", DbType.String, "ReferralDonorRecNumber", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorAge", DbType.String, "ReferralDonorAge", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorAgeUnit", DbType.String, "ReferralDonorAgeUnit", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorRaceID", DbType.Int32, "ReferralDonorRaceID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorGender", DbType.String, "ReferralDonorGender", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorWeight", DbType.String, "ReferralDonorWeight", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorAdmitDate", DbType.DateTime, "ReferralDonorAdmitDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorAdmitTime", DbType.String, "ReferralDonorAdmitTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorDeathDate", DbType.DateTime, "ReferralDonorDeathDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorDeathTime", DbType.String, "ReferralDonorDeathTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorCauseOfDeathID", DbType.Int32, "ReferralDonorCauseOfDeathID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorOnVentilator", DbType.String, "ReferralDonorOnVentilator", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorDead", DbType.String, "ReferralDonorDead", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralTypeID", DbType.Int32, "ReferralTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralApproachTypeID", DbType.Int32, "ReferralApproachTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralApproachedByPersonID", DbType.Int32, "ReferralApproachedByPersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralApproachNOK", DbType.String, "ReferralApproachNOK", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralApproachRelation", DbType.String, "ReferralApproachRelation", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralOrganAppropriateID", DbType.Int32, "ReferralOrganAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralOrganApproachID", DbType.Int32, "ReferralOrganApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralOrganConsentID", DbType.Int32, "ReferralOrganConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralOrganConversionID", DbType.Int32, "ReferralOrganConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralBoneAppropriateID", DbType.Int32, "ReferralBoneAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralBoneApproachID", DbType.Int32, "ReferralBoneApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralBoneConsentID", DbType.Int32, "ReferralBoneConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralBoneConversionID", DbType.Int32, "ReferralBoneConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralTissueAppropriateID", DbType.Int32, "ReferralTissueAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralTissueApproachID", DbType.Int32, "ReferralTissueApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralTissueConsentID", DbType.Int32, "ReferralTissueConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralTissueConversionID", DbType.Int32, "ReferralTissueConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralSkinAppropriateID", DbType.Int32, "ReferralSkinAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralSkinApproachID", DbType.Int32, "ReferralSkinApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralSkinConsentID", DbType.Int32, "ReferralSkinConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralSkinConversionID", DbType.Int32, "ReferralSkinConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesTransAppropriateID", DbType.Int32, "ReferralEyesTransAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesTransApproachID", DbType.Int32, "ReferralEyesTransApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesTransConsentID", DbType.Int32, "ReferralEyesTransConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesTransConversionID", DbType.Int32, "ReferralEyesTransConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesRschAppropriateID", DbType.Int32, "ReferralEyesRschAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesRschApproachID", DbType.Int32, "ReferralEyesRschApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesRschConsentID", DbType.Int32, "ReferralEyesRschConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesRschConversionID", DbType.Int32, "ReferralEyesRschConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralValvesAppropriateID", DbType.Int32, "ReferralValvesAppropriateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralValvesApproachID", DbType.Int32, "ReferralValvesApproachID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralValvesConsentID", DbType.Int32, "ReferralValvesConsentID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralValvesConversionID", DbType.Int32, "ReferralValvesConversionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralNotesCase", DbType.String, "ReferralNotesCase", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralNotesPrevious", DbType.String, "ReferralNotesPrevious", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralVerifiedOptions", DbType.Int16, "ReferralVerifiedOptions", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCoronersCase", DbType.Int16, "ReferralCoronersCase", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "Inactive", DbType.Int16, "Inactive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCallerLevelID", DbType.Int32, "ReferralCallerLevelID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "UnusedField1", DbType.Int16, "UnusedField1", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorFirstName", DbType.String, "ReferralDonorFirstName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorLastName", DbType.String, "ReferralDonorLastName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralOrganDispositionID", DbType.Int32, "ReferralOrganDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralBoneDispositionID", DbType.Int32, "ReferralBoneDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralTissueDispositionID", DbType.Int32, "ReferralTissueDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralSkinDispositionID", DbType.Int32, "ReferralSkinDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralValvesDispositionID", DbType.Int32, "ReferralValvesDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralEyesDispositionID", DbType.Int32, "ReferralEyesDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralRschDispositionID", DbType.Int32, "ReferralRschDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralAllTissueDispositionID", DbType.Int32, "ReferralAllTissueDispositionID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralPronouncingMD", DbType.Int32, "ReferralPronouncingMD", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "UnusedField3", DbType.Int32, "UnusedField3", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralNOKPhone", DbType.String, "ReferralNOKPhone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralAttendingMD", DbType.Int32, "ReferralAttendingMD", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralGeneralConsent", DbType.Int16, "ReferralGeneralConsent", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralNOKAddress", DbType.String, "ReferralNOKAddress", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCoronerName", DbType.String, "ReferralCoronerName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCoronerPhone", DbType.String, "ReferralCoronerPhone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCoronerOrganization", DbType.String, "ReferralCoronerOrganization", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCoronerNote", DbType.String, "ReferralCoronerNote", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralApproachTime", DbType.Decimal, "ReferralApproachTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralConsentTime", DbType.Decimal, "ReferralConsentTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "Unused", DbType.DateTime, "Unused", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDOA", DbType.Int16, "ReferralDOA", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDOB", DbType.DateTime, "ReferralDOB", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorSSN", DbType.String, "ReferralDonorSSN", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralExtubated", DbType.String, "ReferralExtubated", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorRegistryType", DbType.Int16, "DonorRegistryType", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorRegId", DbType.Int32, "DonorRegId", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorDMVId", DbType.Int32, "DonorDMVId", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorDMVTable", DbType.String, "DonorDMVTable", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorIntentDone", DbType.Int16, "DonorIntentDone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorFaxSent", DbType.Int16, "DonorFaxSent", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "DonorDSNID", DbType.Int16, "DonorDSNID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorHeartBeat", DbType.Int32, "ReferralDonorHeartBeat", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralCoronerOrgID", DbType.Int32, "ReferralCoronerOrgID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "CurrentReferralTypeId", DbType.Int32, "CurrentReferralTypeId", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorBrainDeathDate", DbType.DateTime, "ReferralDonorBrainDeathDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorBrainDeathTime", DbType.String, "ReferralDonorBrainDeathTime", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralPronouncingMDPhone", DbType.String, "ReferralPronouncingMDPhone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralAttendingMDPhone", DbType.String, "ReferralAttendingMDPhone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDOB_ILB", DbType.Int16, "ReferralDOB_ILB", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorSpecificCOD", DbType.String, "ReferralDonorSpecificCOD", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralDonorNameMI", DbType.String, "ReferralDonorNameMI", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralNOKID", DbType.Int32, "ReferralNOKID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "ReferralQAReviewComplete", DbType.Int16, "ReferralQAReviewComplete", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);            
           
            try
            {
                    DBCommands.UpdateDataSet(
                    _db,
                    referralData,
                    dataTable,
                    null,
                    updateCommand,
                    null,
                    (DbTransaction)transaction);
            }
            catch(Exception ex) // error was logged by DBCommand.UpdateDataSet
            {   
                
                throw;
            }

        }
        #endregion

        #region InsertLogEvent
        public static int InsertReferralReportLogEvent(ReferralData dataSet)
        {
            int rows = 0;

            string procedureName = "InsertLogEventWeb";

            //get the DB reference. This will be past the the DBCommands Class
            //this does not open a connection and it allows EnterpriseLibrary to control all connections
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();

            // Set the table name to be updated here
            string dataTable = dataSet.LogEventInsert.TableName;

            // build inser, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(insertCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventTypeID", DbType.Int32, "LogEventTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventDateTime", DbType.DateTime, "LogEventDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventNumber", DbType.Int32, "LogEventNumber", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventName", DbType.String, "LogEventName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventPhone", DbType.String, "LogEventPhone", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventOrg", DbType.String, "LogEventOrg", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventDesc", DbType.String, "LogEventDesc", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventCallbackPending", DbType.Int32, "LogEventCallbackPending", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@ScheduleGroupID", DbType.Int32, "ScheduleGroupID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@PhoneID", DbType.Int32, "PhoneID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventContactConfirmed", DbType.Int32, "LogEventContactConfirmed", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventCalloutDateTime", DbType.DateTime, "LogEventCalloutDateTime", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LogEventDeleted", DbType.Boolean, "LogEventDeleted", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@TimeZone", DbType.String, "TimeZone", DataRowVersion.Current);

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

        #region LockCall
        public static void LockCall(int callID, int callOpenByID, int callOpenByWebPersonID, int callSaveLastByID, int auditLogTypeID, int checkCallOpenByID)
        {
            string procedureName = "UpdateCall";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build update commands

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "CallID", DbType.Int32, callID);
            _db.AddInParameter(updateCommand, "CallOpenByID", DbType.Int32, callOpenByID);
            _db.AddInParameter(updateCommand, "CallOpenByWebPersonId", DbType.Int32, callOpenByWebPersonID); 
            _db.AddInParameter(updateCommand, "CallSaveLastByID", DbType.Int32, callSaveLastByID);
            _db.AddInParameter(updateCommand, "AuditLogTypeID", DbType.Int32, auditLogTypeID);
            if (checkCallOpenByID == 0)
                _db.AddInParameter(updateCommand, "CheckCallOpenByID", DbType.Int32, DBNull.Value);
            else
                _db.AddInParameter(updateCommand, "CheckCallOpenByID", DbType.Int32, checkCallOpenByID);
                
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
            }
            catch (Exception ex) // error was logged by DBCommand.UpdateDataSet
            {

                throw;
            }

        }
        #endregion

        #region PersonList
        public static void FillPersonList(ReferralData ds, Int32 OrganizationId)
        {
            string procedureName = "GetPersonListByOrganizationIdWeb";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.PersonbyOrg.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationId", DbType.Int32, OrganizationId);
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

        #region LogEventList
        public static void FillLogEventList(ReferralData ds, Int32 CallID, string timeZone)
        {
            string procedureName = "GetLogEventListWeb";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.LogEventList.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "CallID", DbType.Int32, CallID);
            _db.AddInParameter(command, "TimeZone", DbType.String, timeZone);
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

        #region Get Call Lock
        public static int GetCallLocked(int callID, int callOpenByID)
        {
            string procedureName = "GetCallLocked";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            
            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, callID);
            _db.AddInParameter(updateCommand, "@CallOpenByID", DbType.Int32, callOpenByID);
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
        #region Get SourceCodeName
        public static string GetSourceCodeName(int callID)
        {
            string procedureName = "GetSourceCodeName";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, callID);
            _db.AddOutParameter(updateCommand, "ReturnVal", DbType.String, 10);
            string returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                updateCommand,
                procedureName);
                returnVal = Convert.ToString(_db.GetParameterValue(updateCommand, "ReturnVal"));
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
            return returnVal;
        }
        #endregion

        #region Referral Facility Compliance
        public static void FillReferralFacilityCompliance(ReferralData ds, DateTime referralStartDateTime, DateTime referralEndDateTime, Int32 reportGroupID, Int32 organizationID, string sourceCodeName, int displayMT)
        {
            string procedureName = "sps_rpt_ReferralFacilityCompliance";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ReferralFacilityCompliance.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
          
            _db.AddInParameter(command, "ReferralStartDateTime", DbType.DateTime, referralStartDateTime);
            _db.AddInParameter(command, "ReferralEndDateTime", DbType.DateTime, referralEndDateTime);
            _db.AddInParameter(command, "ReportGroupID", DbType.Int32, reportGroupID);
            if (organizationID == 0)
                _db.AddInParameter(command, "OrganizationID", DbType.Int32, DBNull.Value);
            else
                _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);
            if (sourceCodeName == "")
                _db.AddInParameter(command, "SourceCodeName", DbType.String, DBNull.Value);
            else
                _db.AddInParameter(command, "SourceCodeName", DbType.String, sourceCodeName);
            if(displayMT == 0)
                _db.AddInParameter(command, "DisplayMT", DbType.Int32, DBNull.Value);
            else
                _db.AddInParameter(command, "DisplayMT", DbType.Int32, displayMT);
           
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

        #region Update Referral Facility Compliance
        public static void UpdateOrganizationDeaths(ReferralData referralData)
        {
            string procedureName = "UpdateOrganizationDeaths";
            //string dataTable = referralData.ReferralFacilityCompliance.TableName;
            string dataTable = referralData.UpdateOrganizationDeaths.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DataWarehouse);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(insertCommand, "yearID", DbType.Int32, "YearID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "monthID", DbType.Int32, "MonthID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "orgID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "sourceCodeList", DbType.String, "SourceCodeList", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "totalDeaths", DbType.Int32, "TotalDeaths", DataRowVersion.Current);


            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(deleteCommand, "yearID", DbType.Int32, "YearID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "monthID", DbType.Int32, "MonthID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "orgID", DbType.Int32, "OrganizationID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "sourceCodeList", DbType.String, "SourceCodeList", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    referralData,
                    dataTable,
                    insertCommand,
                    null,
                    deleteCommand,
                    UpdateBehavior.Transactional);
            }

            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }
        }
        #endregion

        #region Schedule Group Contact Required
        public static void FillScheduleGroupContactRequired(ReferralData ds, Int32 callID, Int32 organizationID)
        {
            string procedureName = "sps_ScheduleGroupContactRequired";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.ScheduleGroupContactRequired.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.Int32, callID);
            if (organizationID == 0)
                _db.AddInParameter(command, "OrganizationID", DbType.Int32, DBNull.Value);
            else
                _db.AddInParameter(command, "OrganizationID", DbType.Int32, organizationID);

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

        #region Call
        public static void FillCall(ReferralData ds, Int32 callID)
        {
            string procedureName = "GetCallData";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.Call.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.Int32, callID);

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
        public static void FillReferral(ReferralData ds, Int32 callID)
        {
            string procedureName = "GetReferralData";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.Referral.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.Int32, callID);

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

        #region LogEvent
        public static void FillLogEvent(ReferralData ds, Int32 callID)
        {
            string procedureName = "GetLogEventData";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //set table to fill
            string[] dataTableList = { ds.LogEvent.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "CallID", DbType.Int32, callID);

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

        #region Referral List Count
        public static int FillReferralListCount(string CallNumber, string PatientFirstName, string PatientLastName, DateTime startDateTime, DateTime endDateTime,
            Int32 OrganizationID, Int32 ReportGroupID, Int32 SpecialSearchCriteria, string BasedOnDT, string timeZone)
        {
            string procedureName = "GetReferralListReportsCount";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Reporting);

            //build command object
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            if (CallNumber == "0")
            {
                CallNumber = null;
            }
            _db.AddInParameter(updateCommand, "callNumber", DbType.String, CallNumber);
            _db.AddInParameter(updateCommand, "PatientFirstName", DbType.String, PatientFirstName);
            _db.AddInParameter(updateCommand, "PatientLastName", DbType.String, PatientLastName);
            _db.AddInParameter(updateCommand, "startDateTime", DbType.String, startDateTime);
            _db.AddInParameter(updateCommand, "endDateTime", DbType.String, endDateTime);
            _db.AddInParameter(updateCommand, "OrganizationID", DbType.String, OrganizationID);
            _db.AddInParameter(updateCommand, "ReportGroupID", DbType.String, ReportGroupID);
            _db.AddInParameter(updateCommand, "SpecialSearchCriteria", DbType.String, SpecialSearchCriteria);
            _db.AddInParameter(updateCommand, "BasedOnDT", DbType.String, BasedOnDT);
            _db.AddInParameter(updateCommand, "TimeZone", DbType.String, timeZone);
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
            catch
            {
                throw;
            }
            return returnVal;
        }
        #endregion

    }
}
