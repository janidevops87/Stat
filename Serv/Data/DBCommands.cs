using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Configuration;
using Statline.Framework;
using Statline.Framework.Logger;
using Statline.Framework.Transformation.Connection;
using System;
using System.Collections.Concurrent;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Statline.Data
{
    /// <summary>
    /// use this enum to call GetDataBase
    /// </summary>
    public enum DatabaseInstance
    {
        CA,
        CO,
        WY,
        CT,
        MA,
        ME,
        NH,
        RI,
        VT,
        NV,
        HI, //Added HI
        TX, //Added TX
        MI,
        NE,
        WA,
        MI_SOS,
        Reporting,
        Transaction,
        DMV_Common,
        DataWarehouse,
        Test,
        Backup,
        Development,
        Issues
    }

    /// <summary>
    /// Summary description for ExecuteDBCommand.
    /// </summary>
    public class DBCommands
    {
        private static readonly ConcurrentDictionary<string, DatabaseProviderFactory> DatabaseFactoryCache =
           new ConcurrentDictionary<string, DatabaseProviderFactory>();

        public static void LoadDataSet(
            Database db,
            DbCommand dbCommand,
            DataSet ds,
            string[] dbTableList,
            string procedureName)
        {
            SetDBCommandTimeOut(dbCommand);

            try
            {
                db.LoadDataSet(
                    dbCommand,
                    ds,
                    dbTableList);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private static void SetDBCommandTimeOut(DbCommand dbCommand)
        {
            int dbCommandTimeout = 30;
            string configuredDBComanndTimeout = ApplicationSettings.GetSetting(SettingName.DataBaseCommandTimeOut);
            if (configuredDBComanndTimeout == null)
                dbCommand.CommandTimeout = dbCommandTimeout;

            else
                if (dbCommand != null)
                dbCommand.CommandTimeout = Convert.ToInt32(configuredDBComanndTimeout);


        }
        public static void ExecuteNonQuery(
            Database db,
            DbCommand dbCommand,
            string procedureName)
        {
            SetDBCommandTimeOut(dbCommand);
            try
            {
                db.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static int ExecuteNonQuery(
            Database db,
            string procedureName,
            SqlParameter[] commandParameters
            )
        {
            int result = 0;

            try
            {
                result = db.ExecuteNonQuery(procedureName, commandParameters);
            }
            catch (Exception ex)
            {
                throw;
            }
            return result;
        }

        public static int UpdateDataSet(
            Database db,
            DataSet ds,
            string dataTable,
            DbCommand insertCommand,
            DbCommand updateCommand,
            DbCommand deleteCommand,
            UpdateBehavior updateBehavior)
        {
            int rows = 0;
            SetDBCommandTimeOut(insertCommand);
            SetDBCommandTimeOut(updateCommand);
            SetDBCommandTimeOut(deleteCommand);

            try
            {
                db.UpdateDataSet(
                    ds,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    updateBehavior
                    );
            }
            catch (Exception ex)
            {
                throw;
            }

            return rows;
        }
        public static int UpdateDataSet(
            Database db,
            DataSet ds,
            string dataTable,
            DbCommand insertCommand,
            DbCommand updateCommand,
            DbCommand deleteCommand,
            DbTransaction transaction)
        {
            int rows = 0;
            SetDBCommandTimeOut(insertCommand);
            SetDBCommandTimeOut(updateCommand);
            SetDBCommandTimeOut(deleteCommand);

            try
            {
                db.UpdateDataSet(
                    ds,
                    dataTable,
                    insertCommand,
                    updateCommand,
                    deleteCommand,
                    transaction
                    );
            }
            catch (Exception ex)
            {
                throw;
            }

            return rows;
        }
        /// <summary>
        /// Adds the Parameters for Insert or Update.
        /// By defult it is all the parameters in the Datatable
        /// </summary>
        /// <param name="dataSet"></param>
        /// <param name="commandWrapper"></param>
        public static void AddParameterForSave(
            Database db,
            DataSet dataSet,
            DbCommand commandWrapper,
            string tableName)
        {
            DataTable table = dataSet.Tables[tableName];
            DataColumn column;
            string columnName;
            DbType type;
            SetDBCommandTimeOut(commandWrapper);
            for (int i = 0; i < table.Columns.Count; i++)
            {
                column = table.Columns[i];
                columnName = column.ColumnName;
                type = GetDbType(column.DataType);
                db.AddInParameter(commandWrapper, columnName, type, columnName, DataRowVersion.Current);
            }
        }

        /// <summary>
        /// Adds the Parameters for Delete.
        /// This process will loop through the datatabale specified adding the 
        /// number of columns specied in numberPrimaryKeys
        /// </summary>
        /// <param name="commandWrapper"></param>
        public static void AddParameterForDelete(
            Database db,
            DataSet dataSet,
            DbCommand commandWrapper,
            string tableName,
            int numberPrimaryKeys)
        {

            DataTable table = dataSet.Tables[tableName];
            DataColumn column;
            string columnName;
            DbType type;
            SetDBCommandTimeOut(commandWrapper);
            for (int i = 0; i < numberPrimaryKeys; i++)
            {
                column = table.Columns[i];
                columnName = column.ColumnName;
                type = GetDbType(column.DataType);
                db.AddInParameter(commandWrapper, columnName, type, columnName, DataRowVersion.Current);
            }
        }
        /// <summary>
        /// Returns the DbType from the System type
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        protected static DbType GetDbType(Type type)
        {
            DbType dbType;
            switch (type.Name)
            {
                case "Boolean":
                    dbType = DbType.Boolean;
                    break;
                case "Byte":
                    dbType = DbType.Byte;
                    break;
                case "DateTime":
                    dbType = DbType.DateTime;
                    break;
                case "Int16":
                    dbType = DbType.Int16;
                    break;
                case "Int32":
                    dbType = DbType.Int32;
                    break;
                case "Int64":
                    dbType = DbType.Int64;
                    break;
                case "String":
                    dbType = DbType.String;
                    break;
                case "Guid":
                    dbType = DbType.Guid;
                    break;
                default:
                    throw new NotImplementedException(type.Name);
            }
            return dbType;
        }

        public static Database GetDataBase(DatabaseInstance instance)
        {
            return GetDataBase(instance.ToString());
        }

        public static Database GetDataBase(string instance)
        {
            DatabaseProviderFactory factory = GetDatabaseFactory(instance);
            return factory.Create(instance);
        }

        private static DatabaseProviderFactory GetDatabaseFactory(string instance)
        {
            // We don't expect more than several different database instances,
            // so use very simple caching without cleanup and abstractions.
            // The motivation for caching is that creation instances of
            // DatabaseProviderFactory is a relatively expensive operation
            // while instances can be shared. 
            return DatabaseFactoryCache.GetOrAdd(instance, instanceLocal =>
            {
                var secretKey = Common.Constants.GetSecretKey(instanceLocal);

                var databasePassword = BaseIdentity.ApplicationSecrets[secretKey];

                var configSource = new TransformSqlConnection()
                    .UpdatePasswordConnectionString(instanceLocal, databasePassword);

                return new DatabaseProviderFactory(configSource);
            });
        }
    }
}
