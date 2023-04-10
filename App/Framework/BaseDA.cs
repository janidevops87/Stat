using System;
using System.Data;
using System.Data.Common;
using Statline.Stattrac.Constant;
using System.Collections.ObjectModel;
using System.Collections.Generic;

namespace Statline.Stattrac.Framework
{
    /// <summary>
    /// Base class for the dataacess classes
    /// </summary>
    public class BaseDA
    {
        #region Private Fields
        /// <summary>
        /// the database object to control the connection and transaction
        /// </summary>
        private readonly BaseDatabase database;

        /// <summary>
        /// The name of the select stored procedure
        /// </summary>
        private string spSelect;
        public string SpSelect
        {
            get { return spSelect; }
            set { spSelect = value; }
        }


        /// <summary>
        /// The tables to populate with the select sproc
        /// </summary>
        private string[] tablesSelect;

        /// <summary>
        /// The tables to save and their associates sprocs
        /// </summary>
        private Collection<TableSave> listTableSave = new Collection<TableSave>();

        /// <summary>
        /// reference to the const class
        /// </summary>
        private FrameworkConstant frameworkCnst;
        #endregion

        #region Protected Fields
        protected void SetTablesSelect(params string[] tablesToSelect)
        {
            tablesSelect = tablesToSelect;
        }

        /// <summary>
        /// The tables to save and their associates sprocs
        /// </summary>
        protected Collection<TableSave> ListTableSave
        {
            get { return listTableSave; }
        }
        #endregion

        #region Constructors
        /// <summary>
        /// Sets the select sproc name
        /// </summary>
        /// <param name="selectSprocName"></param>
        protected BaseDA(string selectSprocName)
        {
            database = new BaseDatabase();
            SpSelect = selectSprocName;
            frameworkCnst = FrameworkConstant.CreateInstance();
        }
        #endregion

        #region Internal Methods
        /// <summary>
        /// Select the data from the database
        /// </summary>
        /// <param name="dataSet"></param>
        internal protected void Select(DataSet dataSet)
        {
            BaseCommand cmdSelect = database.GetStoredProcCommandWrapper(spSelect);
            // Add the parameters for the select command
            AddParameterForSelectDataSet(cmdSelect);

            try
            {
                //#if DEBUG
                //                BaseLogger.LogSqlScript(cmdSelect);
                //#endif
                database.LoadDataSet(cmdSelect, dataSet, tablesSelect);
            }
            catch (Exception ex)
            {
                // We do not want to do anything else beside catch the exception since child classes
                // expects exception when fails
                var parameterStrings = new List<string>();

                if (cmdSelect?.command?.Parameters != null && cmdSelect.command.Parameters.Count > 0)
                {
                    foreach (DbParameter thisParameter in cmdSelect.command.Parameters)
                    {
                        parameterStrings.Add($"{thisParameter?.ParameterName ?? "EMPTY"} = '{thisParameter?.Value ?? "EMPTY"}'");
                    }
                }

                StatTracLogger logger = StatTracLogger.CreateInstance();
                logger.AddExtendedProperties("SQLSelect", $"EXEC {cmdSelect.command.CommandText} {string.Join(", ", parameterStrings)}");
                logger.AddExtendedProperties("SQLConnectionString", BaseConnectionSetting.GetMaskedConnectionString(cmdSelect.database.ConnectionString));
                logger.Write(ex);

                throw new BaseException(frameworkCnst.SelectFailed, true);
            }
            SetDateTimeToLocal(dataSet);
        }
        /// <summary>
        /// Executes a SQL Command that does not return a table. Provides a means to captue output parameter
        /// </summary>
        /// Created By: Bret Knoll
        /// Created On: 11/03/2010
        internal protected void ExecuteNonQuery()
        {
            BaseCommand cmdSelect = database.GetStoredProcCommandWrapper(spSelect);
            // Add the parameters for the select command
            //might need to changed this to 
            AddParameterForSelectDataSet(cmdSelect);

            try
            {
                database.ExecuteNonQuery(cmdSelect);
            }
            catch (Exception ex)
            {
                // We do not want to do anything else beside catch the exception since child classes
                // expects exception when fails
                StatTracLogger.CreateInstance().Write(ex);
                throw new BaseException(frameworkCnst.SelectFailed, true);
            }

            GetParameterValuesPostExecuteNonQuery(cmdSelect.command.Parameters);

        }

        /// <summary>
        /// Save the values form the dataset into the database
        /// </summary>
        /// <param name="dataSet"></param>
        /// <param name="transaction"></param>
        internal protected virtual void Save(DataSet dataSet, DbTransaction transaction)
        {
            for (int index = 0; index < listTableSave.Count; index++)
            {
                TableSave tableSave = listTableSave[index];

                // Cretes the BaseCommand for Insert, Update and Delete
                BaseCommand cmdInsert = database.GetStoredProcCommandWrapper(tableSave.InsertSproc);
                BaseCommand cmdUpdate = database.GetStoredProcCommandWrapper(tableSave.UpdateSproc);
                BaseCommand cmdDelete = database.GetStoredProcCommandWrapper(tableSave.DeleteSproc);

                // Add the parameters for each of the 3 commands
                AddParameterForInsert(dataSet.Tables[tableSave.TableName], cmdInsert);
                AddParameterForUpdate(dataSet.Tables[tableSave.TableName], cmdUpdate);
                AddParameterForDelete(dataSet.Tables[tableSave.TableName], cmdDelete);

                SetDateTimeToUtc(dataSet.Tables[tableSave.TableName]);

                // Update the dataset
                try
                {
                    //#if DEBUG
                    //                    BaseLogger.LogSqlScript(dataSet, tableSave.TableName, cmdInsert, DataRowState.Added);
                    //                    BaseLogger.LogSqlScript(dataSet, tableSave.TableName, cmdInsert, DataRowState.Modified);
                    //                    BaseLogger.LogSqlScript(dataSet, tableSave.TableName, cmdInsert, DataRowState.Deleted);
                    //#endif
                    database.UpdateDataSet(dataSet, tableSave.TableName, cmdInsert, cmdUpdate, cmdDelete, transaction);
                }
                catch (Exception ex)
                {
                    HandleSaveException(tableSave, ex);
                    // We do not want to do anything else beside catch the exception since child classes
                    // expects exception when fails
                    BaseLogger.LogBaseDaSaveException(ex, dataSet, tableSave.TableName, cmdInsert, DataRowState.Added);
                    BaseLogger.LogBaseDaSaveException(ex, dataSet, tableSave.TableName, cmdUpdate, DataRowState.Modified);
                    BaseLogger.LogBaseDaSaveException(ex, dataSet, tableSave.TableName, cmdDelete, DataRowState.Deleted);
                    throw new BaseException(frameworkCnst.SaveFailed, true);
                }
            }
        }

        /// <summary>
        /// We want to save all dateteim filds as utc and display them in local time
        /// Note: Dates are stored in MT in much of the application so we need to convert from UTC to MT
        /// </summary>
        /// <param name="dataTable"></param>
        private static void SetDateTimeToUtc(DataTable dataTable)
        {
            int columnIndex = 0;
            int rowIndex = 0;

            for (columnIndex = 0; columnIndex < dataTable.Columns.Count; columnIndex++)
            {   //Only set UTC for Oasis LastUpdateDate
                if (dataTable.Columns[columnIndex].DataType.Name == "DateTime" )
                {
                    for (rowIndex = 0; rowIndex < dataTable.Rows.Count; rowIndex++)
                    {
                        //datetime conversions for added and modified rows
                        switch (dataTable.Rows[rowIndex].RowState)
                        {
                            case DataRowState.Added:
                            case DataRowState.Modified:
                                if (dataTable.Rows[rowIndex][columnIndex] != null && dataTable.Rows[rowIndex][columnIndex] != DBNull.Value)
                                {

                                    //this statement changes to datefield  from local time to UTC
                                    dataTable.Rows[rowIndex][columnIndex] = ((DateTime)dataTable.Rows[rowIndex][columnIndex]).ToUniversalTime();

                                    //check for any date stored in Mountain Time and converts from UTC to MT
                                    //the functionality below will convert from UTC to MT
                                    //Questions: Ask Bret Knoll
                                    switch(dataTable.Columns[columnIndex].ColumnName)
                                    {
                                        case "CallDateTime":
                                        case "CreateDate":
                                        case "FSCaseApproachDateTime":
                                        case "FSCaseBillDateTime":
                                        case "FSCaseBillApproachDateTime":
                                        case "FSCaseBillMedSocDateTime":
                                        case "FSCaseBillFamUnavailDateTime":
                                        case "FSCaseBillCryoFormDateTime":
                                        case "FSCaseBillOTEDateTime":
                                        case "FSCaseCreateDateTime":
                                        case "FSCaseFinalDateTime":
                                        case "FSCaseOpenDateTime":
                                        case "FSCaseSysEventsDateTime":
                                        case "FSCaseSecCompDateTime":
                                        case "FSCaseTotalTime":
                                        case "FSCaseUpdate":
                                        case "LastModified":
                                        case "LogEventDateTime":
                                        case "LogEventCalloutDateTime":
                                        case "PersonBusyUntil":
                                        case "PersonTempNoteExpires":
                                        case "RecycleDateTime":
                                        case "ScheduleEndDateTime":
                                        case "ScheduleStartDateTime":
                                        case "ScheduleLogDateTime":


                                            dataTable.Rows[rowIndex][columnIndex] = ((DateTime)dataTable.Rows[rowIndex][columnIndex]).Add(TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time").GetUtcOffset((DateTime)dataTable.Rows[rowIndex][columnIndex]));
                                            break;

                                        default:
                                            break;
                                    }
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }
            }

        }

        /// <summary>
        /// Since we store the date in UTC, we need to display the date to the user in local time
        /// Note: Dates are stored in MT in much of the application so we need to convert from MT to UTC 
        /// and then let the application act as if the time was stored in UTC
        /// </summary>
        /// <param name="dataSet"></param>
        private void SetDateTimeToLocal(DataSet dataSet)
        {
            for (int tableIndex = 0; tableIndex < tablesSelect.Length; tableIndex++)
            {
                DataTable dataTable = dataSet.Tables[tablesSelect[tableIndex]];
                for (int columnIndex = 0; columnIndex < dataTable.Columns.Count; columnIndex++)
                {
                    //only display UTC for Oasis datetime fields
                    if (dataTable.Columns[columnIndex].DataType.Name == "DateTime" )
                    {
                        for (int rowIndex = 0; rowIndex < dataTable.Rows.Count; rowIndex++)
                        {
                            if (dataTable.Rows[rowIndex].RowState == DataRowState.Unchanged)
                            {
                                if (dataTable.Rows[rowIndex][columnIndex] != null &&
                                    dataTable.Rows[rowIndex][columnIndex] != DBNull.Value)
                                {
                                    //check for any date stored in Mountain Time and convert it to UTC
                                    //the functionality below will convert from UTC to Local
                                    //Questions: Ask Bret Knoll
                                    switch(dataTable.Columns[columnIndex].ColumnName)
                                    {
                                        case "CallDateTime":
                                        case "CreateDate":
                                        case "FSCaseApproachDateTime":
                                        case "FSCaseBillDateTime":
                                        case "FSCaseBillApproachDateTime":
                                        case "FSCaseBillMedSocDateTime":
                                        case "FSCaseBillFamUnavailDateTime":
                                        case "FSCaseBillCryoFormDateTime":
                                        case "FSCaseBillOTEDateTime":
                                        case "FSCaseCreateDateTime":
                                        case "FSCaseFinalDateTime":
                                        case "FSCaseOpenDateTime":
                                        case "FSCaseSysEventsDateTime":
                                        case "FSCaseSecCompDateTime":
                                        case "FSCaseTotalTime":
                                        case "FSCaseUpdate":
                                        case "LastModified":
                                        case "LogEventDateTime":
                                        case "LogEventCalloutDateTime":
                                        case "PersonBusyUntil":
                                        case "PersonTempNoteExpires":
                                        case "RecycleDateTime":
                                        case "ScheduleEndDateTime":
                                        case "ScheduleStartDateTime":
                                        case "ScheduleLogDateTime":


                                            dataTable.Rows[rowIndex][columnIndex] = ((DateTime)dataTable.Rows[rowIndex][columnIndex]).Subtract(TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time").GetUtcOffset((DateTime)dataTable.Rows[rowIndex][columnIndex]));
                                            break;

                                        default:
                                            break;
                                    }
                                    //assumes datetime is in UTC and converts to local
                                    //Note: we might need to capture the users TimeZone and convert to their TimeZone instead of local
                                    dataTable.Rows[rowIndex][columnIndex] = ((DateTime)dataTable.Rows[rowIndex][columnIndex]).ToLocalTime();
                                    // we call the Accept changes
                                    dataTable.Rows[rowIndex].AcceptChanges();
                                }
                            }
                        }
                    }
                }
                // We need to accept the changes so that this rows does not get flagged as needing update
                // 1/18/2011 this is now per row. if a row is unchanged update date is updated and the row state is accepted
            }
        }
        #endregion

        #region Protected Methods
        /// <summary>
        /// Set the parameter to output
        /// </summary>
        /// <param name="command"></param>
        /// <param name="parameterName"></param>
        protected static void SetParameterToOutput(BaseCommand command, string parameterName)
        {
            command.SetParameterToOutput(parameterName);
        }
        #endregion

        #region Protected Virtual Methods
        /// <summary>
        /// Adds the parametes to call the select sproc
        /// </summary>
        /// <param name="selectCommandWrapper"></param>
        protected virtual void AddParameterForSelectDataSet(BaseCommand commandWrapper) { }
        /// <summary>
        /// Called by ExecNonQuery to allow the DA to collect output parameters.
        /// </summary>
        /// <param name="dbParameters"></param>
        /// Created By: Bret Knoll
        /// Created On: 11/03/2010
        protected virtual void GetParameterValuesPostExecuteNonQuery(System.Data.Common.DbParameterCollection dbParameters) { }

        /// <summary>
        /// Add parameter for insert sproc
        /// </summary>
        /// <param name="table"></param>
        /// <param name="commandWrapper"></param>
        protected virtual void AddParameterForInsert(DataTable table, BaseCommand commandWrapper)
        {
            AddParameterForSave(table, commandWrapper);
        }

        /// <summary>
        /// Add parameter for insert sproc
        /// </summary>
        /// <param name="table"></param>
        /// <param name="commandWrapper"></param>
        protected virtual void AddParameterForUpdate(DataTable table, BaseCommand commandWrapper)
        {
            AddParameterForSave(table, commandWrapper);
        }

        /// <summary>
        /// Add parameter for delete sproc.
        /// </summary>
        /// <remarks>
        /// We only want to include the primary key of the table in the delete statement
        /// </remarks>
        /// <param name="table"></param>
        /// <param name="commandWrapper"></param>
        protected virtual void AddParameterForDelete(DataTable table, BaseCommand commandWrapper)
        {
            DataColumn column;
            DbType type;

            for (int index = 0; index < table.PrimaryKey.Length; index++)
            {
                column = table.PrimaryKey[index];
                type = ConvertDbType.GetDbType(column.DataType);
                commandWrapper.AddInParameterForSave(column.ColumnName, type, DataRowVersion.Original);
            }
            // Add the User who is deleting the row
            column = table.Columns["LastUpdateStatEmployeeId"];
            if (column != null)
            {
                type = ConvertDbType.GetDbType(column.DataType);
                commandWrapper.AddInParameterForSave(column.ColumnName, type, DataRowVersion.Original);
            }
            column = table.Columns["LastStatEmployeeID"];
            if (column != null)
            {
                type = ConvertDbType.GetDbType(column.DataType);
                commandWrapper.AddInParameterForSave(column.ColumnName, type, DataRowVersion.Original);
            }
            column = table.Columns["AuditLogTypeID"];
            if (column != null)
            {
                type = ConvertDbType.GetDbType(column.DataType);
                commandWrapper.AddInParameterForSelect(column.ColumnName, type, Statline.Stattrac.Constant.GeneralConstant.AuditLogType.Delete);
            }
            column = table.Columns["LastModified"];
            if (column != null)
            {
                type = ConvertDbType.GetDbType(column.DataType);
                commandWrapper.AddInParameterForSelect(column.ColumnName, type, DateTime.Now);
            }
        }

        /// <summary>
        /// Add parameter for insert and update sproc
        /// </summary>
        /// <param name="table"></param>
        /// <param name="commandWrapper"></param>
        protected virtual void AddParameterForSave(DataTable table, BaseCommand commandWrapper)
        {
            DataColumn column;
            DbType type;
            string columnName;

            for (int i = 0; i < table.Columns.Count; i++)
            {
                column = table.Columns[i];
                type = ConvertDbType.GetDbType(column.DataType);
                columnName = column.ColumnName;
                commandWrapper.AddInParameterForSave(columnName, type, DataRowVersion.Current);
            }
        }

        protected virtual void HandleSaveException(TableSave tableSave, Exception ex) { }
        #endregion
    }
}
