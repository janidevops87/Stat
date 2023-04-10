using System;
using Statline.Data;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Statline.StatTrac.QAUpdate
{
    public class QAUpdateManager
    {
        #region FillQAMonitoringForm - fig 4.1
        public static QAUpdateData.QAMonitoringFormDataTable FillQAMonitoringForm(
            Int32 QAMonitoringFormID,
            Int32 OrganizationID,
            string TrackingNumber,
            Int32 EmployeeID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAMonitoringForm(ds,
                    QAMonitoringFormID,
                    OrganizationID,
                    TrackingNumber,
                    EmployeeID);
            }
            catch
            {
                throw;
            }
            return ds.QAMonitoringForm;
        }
        public static void FillQAMonitoringForm(
            QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAMonitoringFormActive)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAMonitoringForm(ds,
                    OrganizationID,
                    QAMonitoringFormActive);
            }
            catch
            {
                throw;
            }
        }
        public static void  FillQAMonitoringForm(
            QAUpdateData ds,
            Int32 QAMonitoringFormID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAMonitoringForm(ds,
                    QAMonitoringFormID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillQAMonitoringFormTemplate - ??? 
        public static void FillQAMonitoringFormTemplate(
            QAUpdateData ds,
            Int32 QAMonitoringFormID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAMonitoringFormTemplate(ds,
                    QAMonitoringFormID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillQAForm  - DDL 4.14
        public static QAUpdateData.DdlQAFormsDataTable FillQAForm(Int32 OrgID, Int32 ErrorTypeID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAForm(ds, OrgID, ErrorTypeID,Convert.ToInt32(null));
            }
            catch
            {
                throw;
            }
            return ds.DdlQAForms;

        }
        public static void FillQAForm(QAUpdateData ds, Int32 OrgID, Int32 ErrorTypeID, Int32 TrackingTypeID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAForm(ds, OrgID, ErrorTypeID, TrackingTypeID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillQAErrorLocation - fig 4.10
        public static void FillQAErrorLocation(
            QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAErrorLocationActive,
            Int32 QATrackingTypeID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLocation(ds,
                    OrganizationID,
                    QAErrorLocationActive,
                    QATrackingTypeID);
            }
            catch
            { 
                throw;
            }
        }
        public static QAUpdateData.QAErrorLocationDataTable FillQAErrorLocation(
            Int32 OrganizationID,
            Int16 QAErrorLocationActive,
            Int32 QATrackingTypeID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLocation(ds,
                    OrganizationID,
                    QAErrorLocationActive,
                    QATrackingTypeID);
            }
            catch
            {
                throw;
            }
            return ds.QAErrorLocation;
        }
        #endregion
        #region FillQAProcessStep - fig 4.11
        public static void FillQAProcessStep(
            QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAProcessStepActive)
        {
            //QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAProcessStep(ds,
                    OrganizationID,
                    QAProcessStepActive);
            }
            catch
            {
                //throw;
            }
            //return ds.QAProcessStep;
        }
        #endregion
        #region FillQAErrorType - fig 4.12
        public static void FillQAErrorType(
            QAUpdateData ds,
            Int32 QAErrorTypeID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorType(ds,
                    QAErrorTypeID);
            }
            catch
            {
                //throw;
            }
        }
        public static void FillQAErrorType(
            QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAProcessStepActive)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorType(ds,
                    OrganizationID,
                    QAProcessStepActive);
            }
            catch
            {
                //throw;
            }
        }
        #endregion
        #region FillGridManageErrorLists (Form Config) - fig 4.14
        public static void FillQAGridManageErrorLists(
            QAUpdateData ds,
            Int32 OrganizationID,
            Int32 QAMonitoringFormID,
            Int16 QAErrorTypeActive)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridManageErrorLists(ds,
                    OrganizationID,
                    QAMonitoringFormID,
                    QAErrorTypeActive);
            }
            catch
            {
                //throw;
            }
        }
        public static void FillQAGridManageErrorLists(
            QAUpdateData ds,
             Int32 OrganizationID,
            Int16 QAErrorTypeActive,
            Int32 QATrackingTypeID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridManageErrorLists(ds,
                    OrganizationID, QAErrorTypeActive,QATrackingTypeID);
            }
            catch
            {
                //throw;
            }
        }
        #endregion     
        #region FillGridErrorTypeLog - fig 4.6
        public static QAUpdateData.GridErrorTypeLogDataTable FillQAGridErrorTypeLog(
            Int32 QATrackingID,
            Int32 QAErrorLocationID,
            Int32 PersonID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridErrorTypeLog(ds,
                    QATrackingID,
                    QAErrorLocationID,
                    PersonID);
            }
            catch
            {
                //throw;
            }
            return ds.GridErrorTypeLog;
        }
        public static void FillQAGridErrorTypeLog(QAUpdateData ds,
            Int32 QATrackingID,
            Int32 QAErrorLocationID,
            Int32 PersonID)
        {
            //QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridErrorTypeLog(ds,
                    QATrackingID,
                    QAErrorLocationID,
                    PersonID);
            }
            catch
            {
                //throw;
            }
            //return ds.GridErrorTypeLog;
        }
        #endregion        
        #region FillGridErrorTypesByEmployee - fig 4.4 and 4.5
        public static QAUpdateData.GridErrorTypesByEmployeeDataTable FillQAGridErrorTypesByEmployee(
            String QATrackingNumber,
            Int32 OrganizationID,
            Int32 TrackingTypeID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridErrorTypesByEmployee(ds,
                    QATrackingNumber,
                    OrganizationID,
                    TrackingTypeID);
            }
            catch
            {
                //throw;
            }
            return ds.GridErrorTypesByEmployee;
        }
        #endregion        
        
        #region FillGridManageQualityMonitoringForm - fig 4.9
        public static void FillQAGridManageQualityMonitoringForm(
            QAUpdateData ds,
            Int32 OrganizationID,
            Int16 QAMonitoringFormActive)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridManageQualityMonitoringForms(ds,
                    OrganizationID,
                    QAMonitoringFormActive);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillGridAddEditQualityMonitoringForm - fig 4.2
        public static void FillQAGridAddEditQualityMonitoringForm(QAUpdateData ds,
            Int32 FormID, Int32 TrackingFormID
            )
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAGridAddEditQualityMonitoringForm(ds,
                    FormID,TrackingFormID);
            }
            catch
            {
                //throw;
            }
        }
        #endregion
        #region FillQATracking - fig 4.
        public static void FillQATracking(
            QAUpdateData ds,
            String QATrackingNumber,
            Int32 OrganizationID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQATracking(ds,
                    QATrackingNumber,
                    OrganizationID);
            }
            catch
            {
                throw;
            }
        }
        public static void FillQATracking(
            QAUpdateData ds,
            String QATrackingNumber)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQATracking(ds,
                    QATrackingNumber);
            }
            catch
            {
                throw;
            }
        }
        public static void FillQATrackingForm(
            QAUpdateData ds,
            int QATrackingFormID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQATrackingForm(ds,
                    QATrackingFormID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillTrackingType - Tracking Type DDL
        public static QAUpdateData.QATrackingTypeDataTable FillTrackingType(Int32 OrganizationID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQATrackingType(ds,OrganizationID);
            }
            catch
            {
                throw;
            }
            return ds.QATrackingType;
        }
        #endregion       
        #region FillQATrackingStatus - fig 4.
        public static void FillQATrackingStatus(
            QAUpdateData ds,
            Int32 QATrackingStatusID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQATrackingStatus(ds,
                    QATrackingStatusID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillQAErrorStatus - fig 4.8 ddl in grid
        public static QAUpdateData.QAErrorStatusDataTable FillQAErrorStatus()
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorStatus(ds);
            }
            catch
            {
                throw;
            }
            return ds.QAErrorStatus;
        }
        #endregion
        #region FillQAErrorLogHowIdentified - fig 4.7 ddl
        public static QAUpdateData.QAErrorLogHowIdentifiedDataTable FillQAErrorLogHowIdentified()
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLogHowIdentified(ds);
            }
            catch
            {
                throw;
            }
            return ds.QAErrorLogHowIdentified;
        }
        #endregion
        #region FillProcessStep - fig 4.7 ddl
        public static QAUpdateData.DdlProcessStepDataTable FillProcessStep(Int32 OrganizationID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillProcessStep(ds, OrganizationID);
            }
            catch
            {
                throw;
            }
            return ds.DdlProcessStep;
        }
        #endregion
        #region FillErrorType - fig 4.7 ddl
        public static QAUpdateData.DdlErrorTypeDataTable FillErrorType(Int32 OrganizationID, Int32 QAErrorLocationID, Int32 QATrackingTypeID)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillErrorType(ds, OrganizationID, QAErrorLocationID, QATrackingTypeID);
            }
            catch
            {
                throw;
            }
            return ds.DdlErrorType;
        }
        #endregion
        #region FillQAErrorLog - fig 4.
        public static void FillQAErrorLog(
            QAUpdateData ds,
            Int32 QAErrorTypeID,
            Int32 StatEmployeeID,
            Int32 QAErrorLocationID
            )
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLog(ds,
                    QAErrorTypeID,StatEmployeeID,QAErrorLocationID);
            }
            catch
            {
                throw;
            }
        }
        public static void FillQAErrorLog(
            QAUpdateData ds,
            Int32 StatEmployeeID,
            Int32 QAErrorLocationID
            )
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLog(ds,
                    StatEmployeeID, QAErrorLocationID);
            }
            catch
            {
                throw;
            }
        }
        public static void FillQAErrorLog(
            QAUpdateData ds,
            Int32 QAErrorLogID
            )
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLog(ds,
                    QAErrorLogID);
            }
            catch
            {
                throw;
            }
        }
        public static void FillQAErrorLogTrackingNumber(
            QAUpdateData ds,
            string TrackingNumber,
            Int32 qATrackingFormID
            )
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQAErrorLogTrackingNumber(ds,
                    TrackingNumber, qATrackingFormID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region FillRefInfo 
        public static void FillQARefInfo(
            QAUpdateData ds,
            string CallID,
            int webReportGroupID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillQARefInfo(ds,
                    CallID, webReportGroupID);
            }
            catch
            {
                throw;
            }
        }
        #endregion
        #region Validate Tracking Number
        public static int GetValidTrackingNumber(int callID,int reportGroupID, int ReturnVal)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to insert Schedule pass scheduleData and transaction
                    ReturnVal = QAUpdateDB.GetValidTrackingNumber(callID, reportGroupID);
                }
                catch
                {
                    throw;
                }
                return ReturnVal;
            }
        }
        #endregion
        #region Get PersonID
        public static int GetPersonID(int webPersonID, int ReturnVal)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to insert Schedule pass scheduleData and transaction
                    ReturnVal = QAUpdateDB.GetPersonID(webPersonID);
                    
                }
                catch
                {
                    throw;
                }
                return ReturnVal;
            }
        }
        #endregion
        #region update error log
        public static void UpdateErrorLog(QAUpdateData qaData)
		{
			// get db instance
			Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//create transaction within using
			using(TransactionHelper tHelper = new TransactionHelper(db))
			{
				
				try
				{
					tHelper.StartTransaction();
					//update errorlog
                    QAUpdateDB.UpdateQAErrorLogInsert(qaData);
					//update trackingerror
                    QAUpdateDB.UpdateQATrackingFormErrors(qaData); 
					
					tHelper.CommittTransaction();
				}
				catch
				{
					tHelper.RollBackTransaction();
					throw;
				}


			}
		}

		#endregion	
        #region QA Person Title
        public static UserData.PersonTypeDataTable FillPersonTitleListQA(int organizationID)
        {
            UserData ds = new UserData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillPersonTitleListQA(ds, organizationID);
            }
            catch
            {
                throw;
            }

            return ds.PersonType;
        }
        #endregion
        #region Person List
        public static ReferralData.PersonbyOrgDataTable FillPersonList(int OrganizationId, int OrganizationID1)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillPersonList(ds, OrganizationId, OrganizationID1);
            }
            catch
            {
                throw;
            }

            return ds.PersonbyOrg;
        }
        public static void FillPersonListQA(ReferralData ds, int OrganizationID)
        {
            try
            {
                Statline.StatTrac.Data.QAUpdate.QAUpdateDB.FillPersonList(ds, OrganizationID, 0);
            }
            catch
            {
                //throw;
            }
        }
         #endregion
        #region FillGridPendingReview - fig 4.8
        public static QAUpdateData.GridPendingReviewDataTable FillQAGridPendingReview(Int32 OrganizationID, String PersonIDs, DateTime startDateTime, DateTime endDateTime)
        {
            QAUpdateData ds = new QAUpdateData();
            try
            {
                QAUpdateDB.FillQAGridPendingReview(ds, OrganizationID, PersonIDs, startDateTime, endDateTime);
                //QAUpdateDB.FillQAPendingReviewGrid1(ds, OrganizationID, PersonIDs, startDateTime, endDateTime);
            }
            catch
            {
                //throw;
            }
            return ds.GridPendingReview;
        }
        public static void FillQAGridPendingReview(QAUpdateData ds, Int32 OrganizationID, String PersonIDs, DateTime startDateTime, DateTime endDateTime)
        {
            try
            {
                QAUpdateDB.FillQAGridPendingReview(ds, OrganizationID, PersonIDs, startDateTime, endDateTime);
            }
            catch
            {
                //throw;
            }
        }
        #endregion
    }
}
