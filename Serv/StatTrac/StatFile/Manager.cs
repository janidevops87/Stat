using System;
using System.Collections.Generic;
using System.Text;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Data;
using Statline.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.StatTrac.Data.StatFile;

namespace Statline.StatTrac.StatFile
{
    public static class Manager
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
            try
            {


                DB.GetMessage(ds, startDateTime, endDateTime, webReportGroupID, organizationID, dateTypeID, exportFileID, seperateFiles, closeCaseTriggerID, closeCaseOverride);
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
            try
            {


                DB.GetMessageEvent(ds, startDateTime, endDateTime, webReportGroupID, organizationID, dateTypeID, exportFileID, seperateFiles, closeCaseTriggerID, closeCaseOverride);
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
            try
            {


                DB.GetReferral(ds, startDateTime, endDateTime, webReportGroupID, organizationID, dateTypeID, exportFileID, seperateFiles, closeCaseTriggerID, closeCaseOverride);
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
            try
            {


                DB.GetReferralEvent(ds, startDateTime, endDateTime, webReportGroupID, organizationID, dateTypeID, exportFileID, seperateFiles, closeCaseTriggerID, closeCaseOverride);
            }
            catch
            {
                throw;
            }
        }

#endregion
        #region ExportFile
        public static void GetExportFile(StatFileData ds,int organizationID, int exportFileID)
        {
            try
            {
                
                
                DB.GetExportFile(ds, organizationID, exportFileID );
            }
            catch
            {
                throw;
            }
        }
        public static void UpdateExportFile(StatFileData ds, int statEmployeeID)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to update Referral data
                    DB.UpdateExportFile(
                        ds,
                        db,
                        tHelper.DbTransaction, 
                        statEmployeeID);

                    //committ the application
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
    }
}
