using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Administration;
using Statline.Stattrac.DataAccess.Administration;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.BusinessRules.Administration
{
    public class AlertBR : BaseBR, IOrganizationSearch
    {
        private AlertDA _alertDA;
        public SearchParameter OrganizationSearchParameter
        {
            get { return _alertDA.OrganizationSearchParameter; }
            set { _alertDA.OrganizationSearchParameter = value; }
        }
        public AlertBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new AlertDS();
            AssociatedDA = new AlertDA();
            _alertDA = (AlertDA)AssociatedDA;

        }

        #region Overridden Methods
        protected override void BusinessRulesBeforeSelect()
        {

            //organizationDS.EnforceConstraints = false;
        }
        /// <summary>
        /// Business Rules After Select
        /// </summary>
        protected override void BusinessRulesAfterSelect()
        {
           
        }
        protected override void BusinessRulesBeforeSave()
        {
            //check the state of each table if the data has changed update the lastmodified, logtype and LastStatEmployeeID
            AlertDS alertDS = (AlertDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < alertDS.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(alertDS.Tables[forLoop]);
                SetDefaultCreateValues(alertDS.Tables[forLoop]);
            }



        }
        protected override void BusinessRulesAfterSave()
        {
            SetAlertID();
        }

        #endregion
        #region Fields/Properties
        private GeneralConstant grConstant;
        private int alertID;
        public int AlertId
        {
            get { return alertID; }
            set
            {
                alertID = value;
                ((AlertDA)AssociatedDA).AlertId = value;
            }
        }
        #endregion
        #region private methods
        private void SetDefaultModifiedValues(DataTable table)
        {   //
            table.Select().ToList().ForEach(delegate(DataRow row)
            {
                if (row.RowState != DataRowState.Modified)
                    return;

                if (row.Table.Columns.Contains("LastStatEmployeeID"))
                    row[row.Table.Columns["LastStatEmployeeID"].Ordinal] = StattracIdentity.Identity.UserId;
                if (row.Table.Columns.Contains("LastModified"))
                    row[row.Table.Columns["LastModified"].Ordinal] = grConstant.CurrentDateTime;
                if (row.Table.Columns.Contains("AuditLogTypeID"))
                    row[row.Table.Columns["AuditLogTypeID"].Ordinal] = GeneralConstant.AuditLogType.Modify;
            });

        }

        private void SetDefaultCreateValues(DataTable table)
        {   //
            table.Select().ToList().ForEach(delegate(DataRow row)
            {
                if (row.RowState != DataRowState.Added)
                    return;

                AlertDS alertDS = (AlertDS)AssociatedDataSet;
                if (row.Table.Columns.Contains("AlertID") && !row.Table.Columns["AlertID"].AutoIncrement)
                    row[row.Table.Columns["AlertID"].Ordinal] = alertDS.Alert[grConstant.FirstRow].AlertID;
                if (row.Table.Columns.Contains("LastStatEmployeeID"))
                    row[row.Table.Columns["LastStatEmployeeID"].Ordinal] = StattracIdentity.Identity.UserId;
                if (row.Table.Columns.Contains("LastModified"))
                    row[row.Table.Columns["LastModified"].Ordinal] = grConstant.CurrentDateTime;
                if (row.Table.Columns.Contains("AuditLogTypeID"))
                    row[row.Table.Columns["AuditLogTypeID"].Ordinal] = GeneralConstant.AuditLogType.Create;

            });

        }
        /// <summary>
        /// Set the default values on the tables
        /// </summary>
        private void SetDefaultValue()
        {
            AlertDS alertDS = (AlertDS)AssociatedDataSet;
            SetDefaultValue(alertDS.Alert);
            SetDefaultValue(alertDS.AlertOrganization);
            SetDefaultValue(alertDS.AlertSourceCode);
        }
        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        public void AddEmptyRow()
        {
            AlertDS alertDS = (AlertDS)AssociatedDataSet;

            if (alertDS.Alert.Count > 0)
            {
                ClearDataFromTables(alertDS);
            }

            SetDefaultValue(alertDS.Alert);
            if (alertDS.Alert.Count == 0)
                AddEmptyRow(alertDS.Alert);
        }

        private static void ClearDataFromTables(AlertDS alertDS)
        {
            alertDS.AlertOrganization.Clear();
            alertDS.AlertSourceCode.Clear();
            alertDS.Alert.Clear();
        }
        private void SetAlertID()
        {
            AlertDS alertDS = (AlertDS)AssociatedDataSet;
            if (alertDS.Alert.Rows.Count > 0)
            {
                AlertId = alertDS.Alert[grConstant.FirstRow].AlertID;
            }
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            AlertDS alertDS = (AlertDS)AssociatedDataSet;
            if (dataTable.Columns.Contains("AlertID") && !dataTable.Columns["AlertID"].AutoIncrement)
            {
                dataTable.Columns["AlertID"].DefaultValue = alertDS.Alert[grConstant.FirstRow].AlertID;
            }
            if (dataTable.Columns.Contains("LastStatEmployeeID"))
                dataTable.Columns["LastStatEmployeeID"].DefaultValue = StattracIdentity.Identity.UserId;
            if (dataTable.Columns.Contains("LastModified"))
                dataTable.Columns["LastModified"].DefaultValue = grConstant.CurrentDateTime;
            if (dataTable.Columns.Contains("AuditLogTypeID"))
                dataTable.Columns["AuditLogTypeID"].DefaultValue = GeneralConstant.AuditLogType.Create;


        }
        /// <summary>
        /// Add an empty row to the table
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        private DataRow AddEmptyRow(DataTable table)
        {
            DataRow row = table.NewRow();
            table.Rows.Add(row);
            return row;
        }


        private void AddDefaultData(AlertDS.AlertDataTable table)
        {
            AlertDS.AlertRow newRow = table.NewAlertRow();
            AlertDS alertDs = ((AlertDS)AssociatedDataSet);
            //add default data
            alertDs.Alert.AddAlertRow(newRow);
        }

        public void SelectAlert(int alertId)
        {
            ((AlertDA)AssociatedDA).SelectAlert(alertId);
            Select();
        }

        public void SelectAlertOrganization(int alertId)
        {
            ((AlertDA)AssociatedDA).SelectAlertOrganization(alertId);
            Select();
        }

        public void Select()
        {
            base.Select();
            ((AlertDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
        #region AlertOrganization
        public void SearchOrganization()
        {
            //_alertDA.SearchOrganization();

            ////may need add functionality here to clear some all of the organization List
            ////find and remove any records with the current AlertID
            //// create a copy of rows in sourcecodeID what have been modified
            //AlertDS alertDs = ((AlertDS)AssociatedDataSet);
            //DataTable copyAlertOrganizations = null;

            //IEnumerable<DataRow> query =
            //    //from alertDs.AlertOrganization in alertDs.AlertOrganization.AsEnumerable()
            //    from alertOrganization in ((DataTable)alertDs.AlertOrganization).AsEnumerable()
            //    where
            //        (alertOrganization.Field<Int32>(
            //             alertDs.AlertOrganization.AlertIDColumn.ColumnName) == grConstant.AlertId)
            //    where
            //        alertOrganization.RowState == DataRowState.Modified
            //    select alertOrganization;

            //if (query.Count() > 0)
            //    copyAlertOrganizations = query.CopyToDataTable<DataRow>();


            ////run the query
            //Select();

            ////may need to add functionality here after the sprocs is executed.
            ////use the copy of the modified records to and reset the records
            //if (copyAlertOrganizations != null)
            //{
            //    //create a query
            //    query = from copyAlertOrganization in copyAlertOrganizations.AsEnumerable()
            //            select copyAlertOrganization;
            //    //use the query to loop throught the records
            //    //update records if they exist in the table
            //    if (query.Count() > 0)
            //        query.ToList().ForEach(delegate(DataRow rowCopy)
            //        {
            //            alertDs.AlertOrganization.Where
            //                (
            //                row =>
            //                row.AlertID == grConstant.AlertId &&
            //                row.OrganizationID == Convert.ToInt32(rowCopy[alertDs.AlertOrganization.OrganizationIDColumn.ColumnName])).ToList().
            //                ForEach
            //                (delegate(AlertDS.AlertOrganizationRow row)
            //                {
            //                    row.Hidden = Convert.ToBoolean(rowCopy[alertDs.AlertOrganization.HiddenColumn.Ordinal]);
            //                    row.AcceptChanges();
            //                    row.SetModified();
            //                    copyAlertOrganizations.Rows.Remove(rowCopy);
            //                });
            //        });
            //    //create a query
            //    query = from copyAlertOrganization in copyAlertOrganizations.AsEnumerable()
            //            select copyAlertOrganization;
            //    //add records not in soucecodelist of organizations back to the table
            //    if (query.Count() > 0)
            //        query.ToList().ForEach(delegate(DataRow rowCopy)
            //        {
            //            AlertDS.AlertOrganizationRow alertOrganizationRow = alertDs.AlertOrganization.AddAlertOrganizationRow(
            //                Convert.ToInt32(rowCopy[alertDs.AlertOrganization.AlertIDColumn.ColumnName]),
            //                Convert.ToInt32(rowCopy[alertDs.AlertOrganization.OrganizationIDColumn.ColumnName]),
            //                Convert.ToDateTime(Convert.ToString(rowCopy[alertDs.AlertOrganization.LastModifiedColumn.ColumnName])),
            //                Convert.ToInt32(rowCopy[alertDs.AlertOrganization.LastStatEmployeeIDColumn.ColumnName]),
            //                Convert.ToInt32(rowCopy[alertDs.AlertOrganization.AuditLogTypeIDColumn.ColumnName]),
            //                Convert.ToString(rowCopy[alertDs.AlertOrganization.OrganizationNameColumn.ColumnName]),
            //                Convert.ToString(rowCopy[alertDs.AlertOrganization.OrganizationCityColumn.ColumnName]),
            //                Convert.ToString(rowCopy[alertDs.AlertOrganization.StateAbbrvColumn.ColumnName]),
            //                Convert.ToString(rowCopy[alertDs.AlertOrganization.OrganizationTypeColumn.ColumnName]),
            //                Convert.ToBoolean(rowCopy[alertDs.AlertOrganization.HiddenColumn.ColumnName])
            //                );
            //            alertOrganizationRow.AcceptChanges();
            //            alertOrganizationRow.SetModified();

            //        });

            //}

        }
    #endregion
        /// <summary>
        /// 1. Add the Organization to the existing Alert 
        /// 2. Add the new Organization to AlertOrganization
        /// 3. Save the dataSet
        /// </summary>
        /// <param name="organizationID"></param>
        public void AddOrganizationDefault(int newOrganizationID, int organizationID, int sourceCodeID)
        {
            //Step 1
            _alertDA.OrganizationID = organizationID;
            _alertDA.SourceCodeID = sourceCodeID;       
            _alertDA.AddAlertOrganizationDefault();
            
            Select();

            //Step 2
            //add Associated Organization
            if (((AlertDS)AssociatedDataSet).AlertOrganization.Count == 0)
                return;
            ((AlertDS)AssociatedDataSet).AlertOrganization.AlertIDColumn.DefaultValue = ((AlertDS)AssociatedDataSet).Alert[grConstant.FirstRow].AlertID;
            AlertDS.AlertOrganizationRow alertOrganizationRow = ((AlertDS)AssociatedDataSet).AlertOrganization.NewAlertOrganizationRow();
            alertOrganizationRow.OrganizationID = newOrganizationID;
            ((AlertDS)AssociatedDataSet).AlertOrganization.AddAlertOrganizationRow(alertOrganizationRow);

            //Step 3
            SaveDataSet();
        }
    }

}
