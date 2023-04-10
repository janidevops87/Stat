using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.StatTrac.Data.Types;
using Statline.Data;
using System.Data.Common;

namespace Statline.StatTrac.Data.Person
{
    public class StatEmployeeDB
    {
        public static void UpdateStatEmployee(Database _db, UserData userData, IDbTransaction transaction)
        {
            int rows = 0;
            string[] procedureName = {
										 "InsertStatEmployee",                       
										 "UpdateStatEmployee",  // this procecdures are not build
										 "DeleteStatEmployee" // this procecdures are not build
									 };
            string dataTable = userData.StatEmployee.TableName;

            // build inser, update and delete commands
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
            _db.AddInParameter(insertCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "StatEmployeeFirstName", DbType.String, "StatEmployeeFirstName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "StatEmployeeLastName", DbType.String, "StatEmployeeLastName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "StatEmployeeUserID", DbType.String, "StatEmployeeUserID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "StatEmployeePassword", DbType.String, "StatEmployeePassword", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowCallDelete", DbType.Int16, "AllowCallDelete", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowMaintainAccess", DbType.Int16, "AllowMaintainAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowSecurityAccess", DbType.Int16, "AllowSecurityAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowLicenseAccess", DbType.Int16, "AllowLicenseAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "StatEmployeeEmail", DbType.String, "StatEmployeeEmail", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowStopTimerAccess", DbType.Int16, "AllowStopTimerAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowIncompleteAccess", DbType.Int16, "AllowIncompleteAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowScheduleAccess", DbType.Int16, "AllowScheduleAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowRecoveryAccess", DbType.Int16, "AllowRecoveryAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowInternetAccess", DbType.Int16, "AllowInternetAccess", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "IntranetSecurityLevel", DbType.Int16, "IntranetSecurityLevel", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowEmployeeMaintTC", DbType.Int16, "AllowEmployeeMaintTC", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowEmployeeMaintFS", DbType.Int16, "AllowEmployeeMaintFS", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowEmployeeMaintAdmin", DbType.Int16, "AllowEmployeeMaintAdmin", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowEmployeeScheduleTC", DbType.Int16, "AllowEmployeeScheduleTC", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowEmployeeScheduleFS", DbType.Int16, "AllowEmployeeScheduleFS", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowQAReview", DbType.Int16, "AllowQAReview", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowRecycleCase", DbType.Int16, "AllowRecycleCase", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowCloseReferral", DbType.Int16, "AllowCloseReferral", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowASPSave", DbType.Int32, "AllowASPSave", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "AllowViewDeletedLogEvents", DbType.Int16, "AllowViewDeletedLogEvents", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "StatEmployeeFirstName", DbType.String, "StatEmployeeFirstName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "StatEmployeeLastName", DbType.String, "StatEmployeeLastName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "StatEmployeeUserID", DbType.String, "StatEmployeeUserID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "StatEmployeePassword", DbType.String, "StatEmployeePassword", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowCallDelete", DbType.Int16, "AllowCallDelete", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowMaintainAccess", DbType.Int16, "AllowMaintainAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowSecurityAccess", DbType.Int16, "AllowSecurityAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowLicenseAccess", DbType.Int16, "AllowLicenseAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "PersonID", DbType.Int32, "PersonID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "StatEmployeeEmail", DbType.String, "StatEmployeeEmail", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowStopTimerAccess", DbType.Int16, "AllowStopTimerAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowIncompleteAccess", DbType.Int16, "AllowIncompleteAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowScheduleAccess", DbType.Int16, "AllowScheduleAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowRecoveryAccess", DbType.Int16, "AllowRecoveryAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowInternetAccess", DbType.Int16, "AllowInternetAccess", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "IntranetSecurityLevel", DbType.Int16, "IntranetSecurityLevel", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowEmployeeMaintTC", DbType.Int16, "AllowEmployeeMaintTC", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowEmployeeMaintFS", DbType.Int16, "AllowEmployeeMaintFS", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowEmployeeMaintAdmin", DbType.Int16, "AllowEmployeeMaintAdmin", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowEmployeeScheduleTC", DbType.Int16, "AllowEmployeeScheduleTC", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowEmployeeScheduleFS", DbType.Int16, "AllowEmployeeScheduleFS", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowQAReview", DbType.Int16, "AllowQAReview", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowRecycleCase", DbType.Int16, "AllowRecycleCase", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowCloseReferral", DbType.Int16, "AllowCloseReferral", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowASPSave", DbType.Int32, "AllowASPSave", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "AllowViewDeletedLogEvents", DbType.Int16, "AllowViewDeletedLogEvents", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);

            try
            {
                rows = DBCommands.UpdateDataSet(
                    _db,
                    userData,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    (DbTransaction)transaction);
            }
            catch // error was logged by DBCommand.UpdateDataSet
            {
                throw;
            }

        }


    }
}
