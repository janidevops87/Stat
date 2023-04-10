using System;
using Statline.Data;
using Statline.StatTrac.Data.Report;
using Statline.StatTrac.Data.Schedule;
using Statline.StatTrac.Data.Types;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Statline.StatTrac.Schedule
{
    public class ScheduleManager
    {
        #region Schedule List
       // public static ScheduleData.ReferralListDataTable FillReferralList(string CallNumber, string PatientFirstName, string PatientLastName, DateTime startDateTime, DateTime endDateTime, Int32 OrganizationID, Int32 ReportGroupID, Int32 SpecialSearchCriteria)
       // {
        //    ReferralData ds = new ReferralData();
        //    try
        //    {
       //         Statline.StatTrac.Data.Referral.ScheduleDB.FillReferralList(ds, CallNumber, PatientFirstName, PatientLastName, startDateTime, endDateTime, OrganizationID, ReportGroupID, SpecialSearchCriteria);
       //     }
       //     catch
       //     {
        //        throw;
        //    }

       //     return ds.ReferralList;
     //   }
        #endregion

        #region Group
        public static ScheduleData.ScheduleGroupsDataTable FillScheduleGroupList(int OrgID)
        {
            ScheduleData ds = new ScheduleData();
            try
            {
                ScheduleDB.FillScheduleGroupList(ds,OrgID);
            }
            catch
            {
                throw;
            }

            return ds.ScheduleGroups;
        }

        #endregion

        #region Organization
        public static ScheduleData.ScheduleOrgsDataTable FillOrganzationList(int userOrgID)
        {
            ScheduleData ds = new ScheduleData();

            try
            {
                ScheduleDB.FillScheduleOrgsList(ds, userOrgID);
            }
            catch
            {
                throw;
            }

            return ds.ScheduleOrgs;
        }
        #endregion

        #region Schedule
        public static ScheduleData.ScheduleListDataTable FillScheduleList(DateTime startTime, DateTime endTime, int scheduleGroupID, string TZ, int userOrgID)
        {
            ScheduleData ds = new ScheduleData();

            try
            {
                ScheduleDB.FillScheduleList(ds, startTime, endTime, scheduleGroupID, TZ, userOrgID);
            }
            catch
            {
                throw;
            }

            return ds.ScheduleList;
        }
        #endregion

        #region ScheduleSingle
        public static void FillSchedule(ScheduleData ds, int scheduleGroupID, int scheduleItemID, string TZ, int userOrgID)
        {
            //ScheduleData ds = new ScheduleData();

            try
            {
                ScheduleDB.FillSchedule(ds, scheduleGroupID, scheduleItemID, TZ, userOrgID);
            }
            catch(Exception ex)
            {
                throw;
            }

            //return ds.ScheduleList;
        }
        #endregion

        #region Scheduled Person List
        public static ScheduleData.SchedPersonDataTable FillSchedPersonList(int OrganizationId, int ScheduleGroupID)
        {
            ScheduleData ds = new ScheduleData();
            try
            {
                ScheduleDB.FillSchedPersonList(ds, OrganizationId, ScheduleGroupID);
            }
            catch
            {
                throw;
            }

            return ds.SchedPerson;
        }
        #endregion

        #region Update Schedule
        public static void UpdateSchedule(ScheduleData scheduleData)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to update Schedule pass scheduleData and transaction
                    ScheduleDB.UpdateSchedule(scheduleData);

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

        #region Update Schedule Item
        public static void UpdateItemSchedule(int scheduleItemID, string scheduleItemName, string scheduleItemStartDate, string scheduleItemEndDate, string tz)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to update Person pass userData and transaction
                    ScheduleDB.UpdateItemSchedule(
                         scheduleItemID,
                         scheduleItemName, 
                         scheduleItemStartDate, 
                         scheduleItemEndDate,
                         tz);

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

        #region Delete Schedule
        public static void DeleteSchedule(int scheduleItemID)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to delete Schedule pass scheduleData and transaction
                    ScheduleDB.DeleteSchedule(scheduleItemID);

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

        #region Delete Schedule Person
        public static void DeleteSchedulePerson(int scheduleItemID,int priority)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to update Schedule pass scheduleData and transaction
                    ScheduleDB.DeleteSchedulePerson(scheduleItemID,priority);

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

        #region Insert Schedule Item
        public static int InsertSchedule(int scheduleGroupID, string scheduleItemName, string scheduleItemStartDate,string scheduleItemEndDate,int ReturnVal,string tz)
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
                    ReturnVal = ScheduleDB.InsertSchedule(scheduleGroupID,scheduleItemName, scheduleItemStartDate,
                            scheduleItemEndDate,tz);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
                return ReturnVal;
            }
        }
        #endregion

        #region Overlap Schedule
        public static int OverlapSchedule(int scheduleGroupID, int scheduleItemID, string scheduleItemStartDate, string scheduleItemEndDate, int ReturnVal, string tz)
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
                    ReturnVal = ScheduleDB.OverlapSchedule(scheduleGroupID, scheduleItemID,scheduleItemStartDate, scheduleItemEndDate, tz);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
                return ReturnVal;
            }
        }
        #endregion

        #region Lock Schedule
        public static void LockSchedule(ScheduleData ds, int scheduleGroupID, int statEmployeeID, bool removeLock)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            int returnVal;
            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {
                try
                {
                    tHelper.StartTransaction();
                    //try to update Person pass userData and transaction
                    ScheduleDB.LockSchedule(ds,
                        scheduleGroupID,
                        statEmployeeID,
                        removeLock);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch (Exception ex)
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
            }
        }
        #endregion
    }
}
