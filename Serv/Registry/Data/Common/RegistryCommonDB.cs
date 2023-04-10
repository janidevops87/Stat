using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.Registry.Data;
using Statline.Registry.Data.Types.Common;
using System.Data.Common;

namespace Statline.Registry.Data.Common
{
    public class RegistryCommonDB
    {
        #region EventCategory
        public static void GetEventCategory(RegistryCommon ds, Int32 EventCategoryID, Int32 RegistryOwnerID, Int32 EventCategoryActive)
        {
            string procedureName = "GetEventCategory";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.EventCategory.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@EventCategoryID", DbType.Int32, EventCategoryID);
            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@EventCategoryActive", DbType.Int32, EventCategoryActive);
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

        public static void UpdateEventCategory(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertEventCategory",                       
										 "UpdateEventCategory",
										 "DeleteEventCategory"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.EventCategory.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventCategoryName", DbType.String, "EventCategoryName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventCategoryActive", DbType.Boolean, "EventCategoryActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventCategorySpecifyText", DbType.Boolean, "EventCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AuditLogTypeID", DbType.Int32, "AuditLogTypeID", DataRowVersion.Current);


            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventCategoryName", DbType.String, "EventCategoryName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventCategoryActive", DbType.Boolean, "EventCategoryActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventCategorySpecifyText", DbType.Boolean, "EventCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
 
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region EventSubCategory
        public static void GetEventSubCategory(RegistryCommon ds, Int32 EventSubCategoryID, Int32 EventCategoryID, Int32 EventSubCategoryActive)
        {
            string procedureName = "GetEventSubCategory";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.EventSubCategory.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@EventSubCategoryID", DbType.Int32, EventSubCategoryID);
            _db.AddInParameter(command, "@EventCategoryID", DbType.Int32, EventCategoryID);
            _db.AddInParameter(command, "@EventSubCategoryActive", DbType.Int32, EventSubCategoryActive);
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

        public static void UpdateEventSubCategory(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertEventSubCategory",                       
										 "UpdateEventSubCategory",
										 "DeleteEventSubCategory"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.EventSubCategory.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@EventSubCategoryID", DbType.Int32, "EventSubCategoryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventSubCategoryName", DbType.String, "EventSubCategoryName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventSubCategorySourceCode", DbType.String, "EventSubCategorySourceCode", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventSubCategoryActive", DbType.Boolean, "EventSubCategoryActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventSubCategorySpecifyText", DbType.Boolean, "EventSubCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@EventSubCategoryID", DbType.Int32, "EventSubCategoryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventSubCategoryName", DbType.String, "EventSubCategoryName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventSubCategorySourceCode", DbType.String, "EventSubCategorySourceCode", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventSubCategoryActive", DbType.Boolean, "EventSubCategoryActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventSubCategorySpecifyText", DbType.Boolean, "EventSubCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@EventSubCategoryID", DbType.Int32, "EventSubCategoryID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region EventRegistry
        public static void GetEventRegistry(RegistryCommon ds, Int32 EventRegistryID)
        {
            string procedureName = "GetEventRegistry";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.EventRegistry.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryID", DbType.Int32, EventRegistryID);
            
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

        public static void UpdateEventRegistry(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertEventRegistry",                       
										 "UpdateEventRegistry",
										 "DeleteEventRegistry"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.EventRegistry.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@EventRegistryID", DbType.Int32, "EventRegistryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventSubCategoryID", DbType.Int32, "EventSubCategoryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventCategorySpecifyText", DbType.String, "EventCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EventSubCategorySpecifyText", DbType.String, "EventSubCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@EventRegistryID", DbType.Int32, "EventRegistryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventCategoryID", DbType.Int32, "EventCategoryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventSubCategoryID", DbType.Int32, "EventSubCategoryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventCategorySpecifyText", DbType.String, "EventCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EventSubCategorySpecifyText", DbType.String, "EventSubCategorySpecifyText", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@EventRegistryID", DbType.Int32, "EventRegistryID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region IDologyLog
        public static void GetIDologyLog(RegistryCommon ds, Int32 IDologyLogID)
        {
            string procedureName = "GetIDologyLog";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.IDologyLog.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@IDologyLogID", DbType.Int32, IDologyLogID);
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

        public static void UpdateIDologyLog(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertIDologyLog",                       
										 "UpdateIDologyLog",
										 "DeleteIDologyLog"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.IDologyLog.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@IDologyLogID", DbType.Int32, "IDologyLogID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@IDologyLogNumberID", DbType.Int32, "IDologyLogNumberID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@IDologyLogRequest", DbType.String, "IDologyLogRequest", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@IDologyLogResponse", DbType.String, "IDologyLogResponse", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.String, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@IDologyLogID", DbType.Int32, "IDologyLogID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@IDologyLogNumberID", DbType.Int32, "IDologyLogNumberID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@IDologyLogRequest", DbType.String, "IDologyLogRequest", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@IDologyLogResponse", DbType.String, "IDologyLogResponse", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.String, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@IDologyLogID", DbType.Int32, "IDologyLogID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region Registry
        public static void GetRegistry(RegistryCommon ds, Int32 RegistryID)
        {
            string procedureName = "GetRegistry";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.Registry.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryID", DbType.Int32, RegistryID);
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

        public static void UpdateRegistry(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertRegistry",                       
										 "UpdateRegistry",
										 "DeleteRegistry"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.Registry.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@SSN", DbType.String, "SSN", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@DOB", DbType.DateTime, "DOB", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@FirstName", DbType.String, "FirstName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@MiddleName", DbType.String, "MiddleName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastName", DbType.String, "LastName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Suffix", DbType.String, "Suffix", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Gender", DbType.String, "Gender", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Race", DbType.Int32, "Race", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@EyeColor", DbType.String, "EyeColor", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Phone", DbType.String, "Phone", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Email", DbType.String, "Email", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Comment", DbType.String, "Comment", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Limitations", DbType.String, "Limitations", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LimitationsOther", DbType.String, "LimitationsOther", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@License", DbType.String, "License", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Donor", DbType.Boolean, "Donor", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@DonorConfirmed", DbType.Boolean, "DonorConfirmed", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@OnlineRegDate", DbType.DateTime, "OnlineRegDate", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@SignatureDate", DbType.DateTime, "SignatureDate", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@MailerDate", DbType.DateTime, "MailerDate", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@DeleteFlag", DbType.Boolean, "DeleteFlag", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@DeceaseDate", DbType.DateTime, "DeceaseDate", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@PreviousDonor", DbType.Boolean, "PreviousDonor", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@PreviousDonorConfirmed", DbType.Boolean, "PreviousDonorConfirmed", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegisteredByID", DbType.Int32, "RegisteredByID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@SSN", DbType.String, "SSN", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@DOB", DbType.DateTime, "DOB", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@FirstName", DbType.String, "FirstName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@MiddleName", DbType.String, "MiddleName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastName", DbType.String, "LastName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Suffix", DbType.String, "Suffix", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Gender", DbType.String, "Gender", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Race", DbType.Int32, "Race", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@EyeColor", DbType.String, "EyeColor", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Phone", DbType.String, "Phone", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Email", DbType.String, "Email", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Comment", DbType.String, "Comment", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Limitations", DbType.String, "Limitations", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LimitationsOther", DbType.String, "LimitationsOther", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@License", DbType.String, "License", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Donor", DbType.Boolean, "Donor", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@DonorConfirmed", DbType.Boolean, "DonorConfirmed", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@OnlineRegDate", DbType.DateTime, "OnlineRegDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@SignatureDate", DbType.DateTime, "SignatureDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@MailerDate", DbType.DateTime, "MailerDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@DeleteFlag", DbType.Boolean, "DeleteFlag", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@DeceaseDate", DbType.DateTime, "DeceaseDate", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@PreviousDonor", DbType.Boolean, "PreviousDonor", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@PreviousDonorConfirmed", DbType.Boolean, "PreviousDonorConfirmed", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegisteredByID", DbType.Int32, "RegisteredByID", DataRowVersion.Current);
            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);

            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region RegistryAddr
        public static void GetRegistryAddr(RegistryCommon ds,
            Int32 RegistryID,
            Int32 AddrTypeID
            )
        {
            string procedureName = "GetRegistryAddr";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryAddr.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryID", DbType.Int32, RegistryID);
            _db.AddInParameter(command, "@AddrTypeID", DbType.Int32, AddrTypeID);
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

        public static void UpdateRegistryAddr(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertRegistryAddr",                       
										 "UpdateRegistryAddr",
										 "DeleteRegistryAddr"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.RegistryAddr.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@RegistryAddrID", DbType.Int32, "RegistryAddrID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@AddrTypeID", DbType.Int32, "AddrTypeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Addr1", DbType.String, "Addr1", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Addr2", DbType.String, "Addr2", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@City", DbType.String, "City", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@State", DbType.String, "State", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Zip", DbType.String, "Zip", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            //_db.AddInParameter(updateCommand, "@RegistryAddrID", DbType.Int32, "RegistryAddrID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@AddrTypeID", DbType.Int32, "AddrTypeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Addr1", DbType.String, "Addr1", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Addr2", DbType.String, "Addr2", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@City", DbType.String, "City", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@State", DbType.String, "State", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Zip", DbType.String, "Zip", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@RegistryID", DbType.Int32, "RegistryAddrID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@AddrTypeID", DbType.Int32, "AddrTypeID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

                #endregion
        #region RegistryDigitalCertificate
        public static void GetRegistryDigitalCertificate(RegistryCommon ds, Int32 RegistryID)
        {
            string procedureName = "GetRegistryDigitalCertificate";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryDigitalCertificate.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryID", DbType.Int32, RegistryID);
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

        public static void UpdateRegistryDigitalCertificate(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertRegistryDigitalCertificate",                       
										 "UpdateRegistryDigitalCertificate",
										 "DeleteRegistryDigitalCertificate"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.RegistryDigitalCertificate.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@RegistryDigitalCertificateID", DbType.Int32, "RegistryDigitalCertificateID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryDigitalCertificateData", DbType.Binary, "RegistryDigitalCertificateData", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@HashAlgorithmAtTimeofSigning", DbType.String, "HashAlgorithmAtTimeofSigning", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@SignaturePublicKey", DbType.String, "SignaturePublicKey", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@Signature", DbType.Binary, "Signature", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@RegistryDigitalCertificateID", DbType.Int32, "RegistryDigitalCertificateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryID", DbType.Int32, "RegistryID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryDigitalCertificateData", DbType.Binary, "RegistryDigitalCertificateData", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@HashAlgorithmAtTimeofSigning", DbType.String, "HashAlgorithmAtTimeofSigning", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@SignaturePublicKey", DbType.String, "SignaturePublicKey", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@Signature", DbType.Binary, "Signature", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@RegistryDigitalCertificateID", DbType.Int32, "RegistryDigitalCertificateID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region RegistryOwner
        public static void GetRegistryOwner(RegistryCommon ds, Int32 RegistryOwnerID, String RegistryOwnerRouteName)
        {
            string procedureName = "GetRegistryOwner";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwner.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@RegistryOwnerRouteName", DbType.String, RegistryOwnerRouteName);
            
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

        public static void UpdateRegistryOwner(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertRegistryOwner",                       
										 "UpdateRegistryOwner",
										 "DeleteRegistryOwner"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.RegistryOwner.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerName", DbType.String, "RegistryOwnerName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@SourceCodeID", DbType.Int32, "SourceCodeID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@DisplaySearchPendingSignature", DbType.Boolean, "DisplaySearchPendingSignature", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@DisplaySearchResultDateField", DbType.Boolean, "DisplaySearchResultDateField", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            _db.AddInParameter(updateCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerName", DbType.String, "RegistryOwnerName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@SourceCodeID", DbType.Int32, "SourceCodeID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@DisplaySearchPendingSignature", DbType.Boolean, "DisplaySearchPendingSignature", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@DisplaySearchResultDateField", DbType.Boolean, "DisplaySearchResultDateField", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region RegistryOwnerGrantedAccess
        public static void GetRegistryOwnerGrantedAccess(RegistryCommon ds, Int32 RegistryOwnerID)
        {
            string procedureName = "GetRegistryOwnerGrantedAccess";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerGrantedAccess.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            //_db.AddInParameter(command, "@RegistryGrantedOwnerID", DbType.Int32, RegistryGrantedOwnerID);
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

        public static void UpdateRegistryOwnerGrantedAccess(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertRegistryOwnerGrantedAccess",                       
										 "UpdateRegistryOwnerGrantedAccess",
										 "DeleteRegistryOwnerGrantedAccess"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.RegistryOwnerGrantedAccess.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            //_db.AddInParameter(insertCommand, "@RegistryOwnerGrantedAccessID", DbType.Int32, "RegistryOwnerGrantedAccessID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryGrantedOwnerID", DbType.Int32, "RegistryGrantedOwnerID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            //_db.AddInParameter(updateCommand, "@RegistryOwnerGrantedAccessID", DbType.Int32, "RegistryOwnerGrantedAccessID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryGrantedOwnerID", DbType.Int32, "RegistryGrantedOwnerID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerGrantedAccessID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region RegistryOwnerStateConfig
        public static void GetRegistryOwnerStateConfig(RegistryCommon ds, Int32 RegistryOwnerID, Int16 DisplayAllStates)
        {
            string procedureName = "GetRegistryOwnerStateConfig";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerStateConfig.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            //_db.AddInParameter(command, "@RegistryOwnerStateConfigID", DbType.Int32, RegistryOwnerStateConfigID);
            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@DisplayAllStates", DbType.Int16, DisplayAllStates);
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

        public static void UpdateRegistryOwnerStateConfig(RegistryCommon ds)
        {
            string[] procedureName = {
										 "InsertRegistryOwnerStateConfig",                       
										 "UpdateRegistryOwnerStateConfig",
										 "DeleteRegistryOwnerStateConfig"
									 };
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string dataTableList = ds.RegistryOwnerStateConfig.TableName;
            DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);

            _db.AddInParameter(insertCommand, "@RegistryOwnerStateConfigID", DbType.Int32, "RegistryOwnerStateConfigID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerStateID", DbType.Boolean, "RegistryOwnerStateID", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerStateAbbrv", DbType.String, "RegistryOwnerStateAbbrv", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerStateName", DbType.String, "RegistryOwnerStateName", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerStateVerificationForm", DbType.String, "RegistryOwnerStateVerificationForm", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerStateDMVDSN", DbType.String, "RegistryOwnerStateDMVDSN", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@RegistryOwnerStateActive", DbType.Boolean, "RegistryOwnerStateActive", DataRowVersion.Current);
            _db.AddInParameter(insertCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);

            //_db.AddInParameter(updateCommand, "@RegistryOwnerStateConfigID", DbType.Int32, "RegistryOwnerStateConfigID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerStateID", DbType.Boolean, "RegistryOwnerStateID", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerStateAbbrv", DbType.String, "RegistryOwnerStateAbbrv", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerStateName", DbType.String, "RegistryOwnerStateName", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerStateVerificationForm", DbType.String, "RegistryOwnerStateVerificationForm", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerStateDMVDSN", DbType.String, "RegistryOwnerStateDMVDSN", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@RegistryOwnerStateActive", DbType.Boolean, "RegistryOwnerStateActive", DataRowVersion.Current);
            _db.AddInParameter(updateCommand, "@LastStatEmployeeID", DbType.Int32, "LastStatEmployeeID", DataRowVersion.Current);

            DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);

            _db.AddInParameter(deleteCommand, "@RegistryOwnerID", DbType.Int32, "RegistryOwnerStateConfigID", DataRowVersion.Current);
            _db.AddInParameter(deleteCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
            try
            {
                DBCommands.UpdateDataSet(
                _db,
                 ds,
                dataTableList,
                insertCommand,
                updateCommand,
                deleteCommand,
                UpdateBehavior.Transactional);
            }
            catch
            {
                throw;
            }
        }

        #endregion
        #region DataListRegistrySearchResults
        public static void GetDataListRegistrySearchResults(RegistryCommon ds,
            String FirstName,
            String MiddleName,
            String LastName,
            String City,
            String State,
            String Zip,
            String License,
            String  WebRegistryID,
            String DOB,
            String DisplayWebDonors,
            String DisplayDMVDonors,
            String DisplayWebPendingSignature,
            String DisplayDMVDonorsYesOnly,
            String StateSelection,
            String RegistryOwnerID,
            String DisplayNoDonors
            )
        {
            string procedureName = "GetDataListRegistrySearchResults";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.DataListRegistrySearchResults.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@FirstName", DbType.String, FirstName);
            _db.AddInParameter(command, "@MiddleName", DbType.String, MiddleName);
            _db.AddInParameter(command, "@LastName", DbType.String, LastName);
            _db.AddInParameter(command, "@City", DbType.String, City);
            _db.AddInParameter(command, "@State", DbType.String, State);
            _db.AddInParameter(command, "@ZIp", DbType.String, Zip);
            _db.AddInParameter(command, "@License", DbType.String, License);
            _db.AddInParameter(command, "@WebRegistryID", DbType.Int32, Convert.ToInt32(WebRegistryID));
            _db.AddInParameter(command, "@DOB", DbType.DateTime, Convert.ToDateTime(DOB));
            _db.AddInParameter(command, "@DisplayWEBDonors", DbType.Boolean, Convert.ToBoolean(DisplayWebDonors));
            _db.AddInParameter(command, "@DisplayWebPendingSignature", DbType.Boolean, Convert.ToBoolean(DisplayWebPendingSignature));
            _db.AddInParameter(command, "@DisplayDMVDonors", DbType.Boolean, Convert.ToBoolean(DisplayDMVDonors));
            _db.AddInParameter(command, "@DisplayDMVDonorsYesOnly", DbType.Boolean, Convert.ToBoolean(DisplayDMVDonorsYesOnly));
            _db.AddInParameter(command, "@DisplayNoDonors", DbType.Boolean, Convert.ToBoolean(DisplayNoDonors));
            _db.AddInParameter(command, "@StateSelection", DbType.String, StateSelection);
            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, Convert.ToInt32(RegistryOwnerID));
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
        #region RegistryStatisticsReport
        public static void GetRegistryStatisticsReport(RegistryCommon ds,
            String StateSelection
            )
        {
            string procedureName = "sps_Common_RegistryStatisticsReport";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryStatisticsReport.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@StateSelection", DbType.String, StateSelection);
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
        #region GetFormElectronicSignature
        public static void GetFormElectronicSignature(RegistryCommon ds, Int32 RegistryID)
        {
            string procedureName = "GetFormElectronicSignature";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.DataFormElectronicSignature.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryID", DbType.Int32, RegistryID);
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
        #region GetExistingDonor
        public static int GetExistingDonor(
            int registryID,
            int registryOwnerID,
            string firstName,
            string lastName,
            string lastFourSSN,
            string license,
            string DOB
            )
        {
            string procedureName = "GetExistingDonor";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            // build command
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@RegistryID", DbType.Int32, registryID);
            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, registryOwnerID);
            _db.AddInParameter(command, "@FirstName", DbType.String, firstName);
            _db.AddInParameter(command, "@LastName", DbType.String, lastName);
            _db.AddInParameter(command, "@LastFourSSN", DbType.String, lastFourSSN);
            _db.AddInParameter(command, "@License", DbType.String, license);
            _db.AddInParameter(command, "@DOB", DbType.DateTime, Convert.ToDateTime(DOB));
            _db.AddOutParameter(command, "ReturnVal", DbType.Int32, 0);

            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                command,
                procedureName);
                returnVal = Convert.ToInt32(_db.GetParameterValue(command, "ReturnVal"));
            }

            catch // 
            {
                throw;
            }
            return returnVal;
        }
                #endregion
        #region GetRegistryOwnerUserOrg
        public static int GetRegistryOwnerUserOrg(
            int UserOrgID
            )
        {
            string procedureName = "GetRegistryOwnerUserOrg";

            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            // build command
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "UserOrgID", DbType.Int32, UserOrgID);
            _db.AddOutParameter(command, "ReturnVal", DbType.Int32, 0);

            int returnVal;
            try
            {
                DBCommands.ExecuteNonQuery(
                _db,
                command,
                procedureName);

                returnVal = Convert.ToInt32(_db.GetParameterValue(command, "ReturnVal"));
            }

            catch // 
            {
                throw;
            }
            return returnVal;
        }
        #endregion
        #region GetFormVerification
        public static void GetFormVerification(RegistryCommon ds, Int32 SourceID, string Source, string State)
        {
            string procedureName = "GetFormVerification";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.DataFormVerification.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@SourceID", DbType.Int32, SourceID);
            _db.AddInParameter(command, "@Source", DbType.String, Source);
            _db.AddInParameter(command, "@State", DbType.String, State);
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
        #region GetRegistryOwnerEnrollmentFormText
        public static void GetRegistryOwnerEnrollmentFormText(RegistryCommon ds, Int32 RegistryOwnerID, string LanguageCode)
        {
            string procedureName = "GetRegistryOwnerEnrollmentFormText";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerEnrollmentText.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@LanguageCode", DbType.String, LanguageCode);
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
        #region GetRegistryOwnerEnrollmentConfirmationText
        public static void GetRegistryOwnerEnrollmentConfirmationText(RegistryCommon ds, Int32 RegistryOwnerID, string RegistryOwnerLanguageCode)
        {
            string procedureName = "GetRegistryOwnerEnrollmentConfirmationText";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerEnrollmentText.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@RegistryOwnerLanguageCode", DbType.String, RegistryOwnerLanguageCode);
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
        #region GetRegistryOwnerElectronicSignatureText
        public static void GetRegistryOwnerElectronicSignatureText(RegistryCommon ds, Int32 RegistryOwnerID, string LanguageCode)
        {
            string procedureName = "GetRegistryOwnerElectronicSignatureText";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerElectronicSignatureText.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@LanguageCode", DbType.String, LanguageCode);
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
        #region GetRegistryOwnerStateVerificationText
        public static void GetRegistryOwnerStateVerificationText(RegistryCommon ds, Int32 RegistryOwnerID, string RegistryOwnerStateAbbrv, string RegistryOwnerDMVSource)
        {
            string procedureName = "GetRegistryOwnerStateVerificationText";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerStateConfig.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
            _db.AddInParameter(command, "@RegistryOwnerStateAbbrv", DbType.String, RegistryOwnerStateAbbrv);
            _db.AddInParameter(command, "@RegistryOwnerDMVSource", DbType.String, RegistryOwnerDMVSource);

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
        #region GetRegistryOwnerStateDMVSearchOptions
        public static void GetRegistryOwnerStateDMVSearchOptions(RegistryCommon ds, Int32 RegistryOwnerID)
        {
            string procedureName = "GetRegistryOwnerStateDMVSearchOptions";
            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { ds.RegistryOwnerStateConfig.TableName };
            DbCommand command = _db.GetStoredProcCommand(procedureName);

            _db.AddInParameter(command, "@RegistryOwnerID", DbType.Int32, RegistryOwnerID);
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
