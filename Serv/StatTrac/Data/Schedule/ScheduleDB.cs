using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Data.Common;

namespace Statline.StatTrac.Data.Schedule
{
    public class ScheduleDB
    {
        #region ScheduleGroup
        public static void FillScheduleGroupList(ScheduleData ds, int OrgID)
        {
            string procedureName = "sps_ScheduleGroups";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            string[] dataTableList = { ds.ScheduleGroups.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrgID", DbType.Int32, OrgID);

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

        #region ScheduleOrgs
        public static void FillScheduleOrgsList(ScheduleData ds, int userOrgID)
        {
            string procedureName = "sps_ScheduleOrganizations";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            string[] dataTableList = { ds.ScheduleOrgs.TableName };

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

        #region Schedules
        public static void FillScheduleList(ScheduleData ds, DateTime startTime, DateTime endTime, int scheduleGroupID, string TZ, int userOrgID)
        {
            string procedureName = "sps_getSchedule";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            string[] dataTableList = { ds.ScheduleList.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "StartTime", DbType.DateTime, startTime);
            _db.AddInParameter(command, "EndTime", DbType.DateTime, endTime);
            _db.AddInParameter(command, "ScheduleGroupID", DbType.Int32, scheduleGroupID);
            _db.AddInParameter(command, "vTZ", DbType.String, TZ);
            _db.AddInParameter(command, "UserOrgID", DbType.Int32, userOrgID);

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

        #region ScheduledPersonList
        public static void FillSchedPersonList(ScheduleData ds, Int32 OrganizationId, Int32 ScheduleGroupID)
        {
            string procedureName = "GetScheduledPersonList";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //set table to fill
            string[] dataTableList = { ds.SchedPerson.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "OrganizationId", DbType.Int32, OrganizationId);
            _db.AddInParameter(command, "ScheduleGroupID", DbType.Int32, ScheduleGroupID);
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

        #region Schedule Single
        public static void FillSchedule(ScheduleData ds, int scheduleGroupID, int scheduleItemID, string TZ, int userOrgID)
        {
            string procedureName = "GetScheduleSingle";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            string[] dataTableList = { ds.ScheduleList.TableName };

            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "ScheduleGroupID", DbType.Int32, scheduleGroupID);
            _db.AddInParameter(command, "ScheduleItemID", DbType.Int32, scheduleItemID);
            _db.AddInParameter(command, "TZ", DbType.String, TZ);
            _db.AddInParameter(command, "UserOrgID", DbType.Int32, userOrgID);

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
            catch(Exception ex)
            {
                throw;
            }

        }
        #endregion

        #region Update Person Schedule
        public static void UpdateSchedule(ScheduleData scheduleData)
        {
            string procedureName = "UpdateSchedule";
            string dataTable = scheduleData.ScheduleUpdatePerson.TableName;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(insertCommand, "ScheduleItemID", DbType.Int32, "ScheduleItemID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "NewScheduleItemID", DbType.Int32, "NewScheduleItemID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "Priority", DbType.Int32, "Priority", DataRowVersion.Current);
            

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(deleteCommand, "ScheduleItemID", DbType.Int32, "ScheduleItemID", DataRowVersion.Original);

            try
            {
                DBCommands.UpdateDataSet(
                    _db,
                    scheduleData,
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

        #region Update Schedule Item
        public static void UpdateItemSchedule(int scheduleItemID, string scheduleItemName, string scheduleItemStartDate, string scheduleItemEndDate, string tz)
        {
            string procedureName = "UpdateItemSchedule";
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            // build update commands

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ScheduleItemID", DbType.Int32, scheduleItemID);
            _db.AddInParameter(updateCommand, "ScheduleItemName", DbType.String, scheduleItemName);
            _db.AddInParameter(updateCommand, "ScheduleItemStartDate", DbType.Date, scheduleItemStartDate);
            _db.AddInParameter(updateCommand, "ScheduleItemEndDate", DbType.Date, scheduleItemEndDate);
            _db.AddInParameter(updateCommand, "TimeZone", DbType.String, tz);

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

        #region Delete Schedule
        public static void DeleteSchedule(int scheduleItemID)
        {
            string procedureName = "DeleteSchedule";
            
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ScheduleItemID", DbType.Int32, scheduleItemID);

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

        #region Delete Schedule Person
        public static void DeleteSchedulePerson(int scheduleItemID, int priority)
        {
            string procedureName = "DeleteSchedulePerson";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ScheduleItemID", DbType.Int32, scheduleItemID);
            _db.AddInParameter(updateCommand, "Priority", DbType.Int32, priority);
            
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

        #region Insert Schedule Item
        public static int InsertSchedule(int scheduleGroupID,string scheduleItemName, string scheduleItemStartDate,
            string scheduleItemEndDate, string tz)
        {
            string procedureName = "InsertScheduleItem";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ScheduleGroupID", DbType.Int32, scheduleGroupID);
            _db.AddInParameter(updateCommand, "ScheduleItemName", DbType.String, scheduleItemName);
            _db.AddInParameter(updateCommand, "ScheduleItemStartDate", DbType.Date, scheduleItemStartDate);
            _db.AddInParameter(updateCommand, "ScheduleItemEndDate", DbType.Date, scheduleItemEndDate);
            _db.AddInParameter(updateCommand, "TimeZone", DbType.String, tz);
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

        #region Overlap Schedule Test
        public static int OverlapSchedule(int scheduleGroupID, int scheduleItemID, string scheduleItemStartDate, string scheduleItemEndDate, string tz)
        {
            string procedureName = "sps_ScheduleOverlap";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            // build insert, update and delete commands
            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ScheduleGroupID", DbType.Int32, scheduleGroupID);
            _db.AddInParameter(updateCommand, "ScheduleItemID", DbType.Int32, scheduleItemID);
            _db.AddInParameter(updateCommand, "ScheduleItemStartDate", DbType.Date, scheduleItemStartDate);
            _db.AddInParameter(updateCommand, "ScheduleItemEndDate", DbType.Date, scheduleItemEndDate);
            _db.AddInParameter(updateCommand, "TimeZone", DbType.String, tz);
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

        #region LockSchedule
        public static void LockSchedule(ScheduleData ds, int scheduleGroupID, int statEmployeeID, bool removeLock)
        {
            string procedureName = "UpdateScheduleLock";
            int returnVal;
            Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
            string[] dataTableList = { ds.ScheduleLock.TableName };
            // build update commands

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(updateCommand, "ScheduleGroupID", DbType.Int32, scheduleGroupID);
            _db.AddInParameter(updateCommand, "StatEmployeeID", DbType.Int32, statEmployeeID);
            _db.AddInParameter(updateCommand, "RemoveLock", DbType.Boolean, removeLock); //callOpenByWebPersonID);
            try
            {
                DBCommands.LoadDataSet(
                _db,
                updateCommand,
                ds,
                dataTableList,
                procedureName);
            }
            catch (Exception ex) // error was logged by DBCommand.UpdateDataSet
            {

                throw;
            }
        }
        #endregion
    }
}
