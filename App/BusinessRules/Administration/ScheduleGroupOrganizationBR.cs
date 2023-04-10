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
    public class ScheduleGroupOrganizationBR : BaseBR, IOrganizationSearch
    {
        private ScheduleGroupOrganizationDA _scheduleGroupOrganizationDA;

        //public SearchParameter OrganizationSearchParameter
        //{
        //    get { return _scheduleGroupOrganizationDA.OrganizationSearchParameter; }
        //    set { _scheduleGroupOrganizationDA.OrganizationSearchParameter = value; }
        //}
        public ScheduleGroupOrganizationBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new ScheduleGroupOrganizationDS();
            AssociatedDA = new ScheduleGroupOrganizationDA();
            _scheduleGroupOrganizationDA = (ScheduleGroupOrganizationDA)AssociatedDA;

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
            ScheduleGroupOrganizationDS scheduleGroupOrganizationDS = (ScheduleGroupOrganizationDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < scheduleGroupOrganizationDS.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(scheduleGroupOrganizationDS.Tables[forLoop]);
                SetDefaultCreateValues(scheduleGroupOrganizationDS.Tables[forLoop]);
            }

        }
        protected override void BusinessRulesAfterSave()
        {
            SetScheduleGroupOrganizationID();
        }

        #endregion
        #region Fields/Properties
        private GeneralConstant grConstant;
        private int scheduleGroupOrganizationID;
        public int ScheduleGroupOrganizationId
        {
            get { return scheduleGroupOrganizationID; }
            set
            {
                scheduleGroupOrganizationID = value;
                ((ScheduleGroupOrganizationDA)AssociatedDA).ScheduleGroupOrganizationId = value;
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

                ScheduleGroupOrganizationDS scheduleGroupOrganizationDS = (ScheduleGroupOrganizationDS)AssociatedDataSet;
                if (row.Table.Columns.Contains("ScheduleGroupOrganizationID") && !row.Table.Columns["ScheduleGroupOrganizationID"].AutoIncrement)
                    row[row.Table.Columns["ScheduleGroupOrganizationID"].Ordinal] = scheduleGroupOrganizationDS.ScheduleGroupOrganization[grConstant.FirstRow].ScheduleGroupOrganizationID;
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
            ScheduleGroupOrganizationDS scheduleGroupOrganizationDS = (ScheduleGroupOrganizationDS)AssociatedDataSet;
            SetDefaultValue(scheduleGroupOrganizationDS.ScheduleGroupOrganization);
        }
        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        public void AddEmptyRow()
        {
            ScheduleGroupOrganizationDS scheduleGroupOrganizationDS = (ScheduleGroupOrganizationDS)AssociatedDataSet;

            if (scheduleGroupOrganizationDS.ScheduleGroupOrganization.Count > 0)
            {
                ClearDataFromTables(scheduleGroupOrganizationDS);
            }

            SetDefaultValue(scheduleGroupOrganizationDS.ScheduleGroupOrganization);
            if (scheduleGroupOrganizationDS.ScheduleGroupOrganization.Count == 0)
                AddEmptyRow(scheduleGroupOrganizationDS.ScheduleGroupOrganization);
        }

        private static void ClearDataFromTables(ScheduleGroupOrganizationDS scheduleGroupOrganizationDS)
        {
            scheduleGroupOrganizationDS.ScheduleGroupOrganization.Clear();
        }
        private void SetScheduleGroupOrganizationID()
        {
            ScheduleGroupOrganizationDS scheduleGroupOrganizationDS = (ScheduleGroupOrganizationDS)AssociatedDataSet;
            if (scheduleGroupOrganizationDS.ScheduleGroupOrganization.Rows.Count > 0)
            {
                ScheduleGroupOrganizationId = scheduleGroupOrganizationDS.ScheduleGroupOrganization[grConstant.FirstRow].ScheduleGroupOrganizationID;
            }
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            ScheduleGroupOrganizationDS scheduleGroupOrganizationDS = (ScheduleGroupOrganizationDS)AssociatedDataSet;
            if (dataTable.Columns.Contains("ScheduleGroupOrganizationID") && !dataTable.Columns["AlertID"].AutoIncrement)
            {
                dataTable.Columns["ScheduleGroupOrganizationID"].DefaultValue = scheduleGroupOrganizationDS.ScheduleGroupOrganization[grConstant.FirstRow].ScheduleGroupOrganizationID;
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


        private void AddDefaultData(ScheduleGroupOrganizationDS.ScheduleGroupOrganizationDataTable table)
        {
            ScheduleGroupOrganizationDS.ScheduleGroupOrganizationRow newRow = table.NewScheduleGroupOrganizationRow();
            ScheduleGroupOrganizationDS scheduleGroupOrganizationDs = ((ScheduleGroupOrganizationDS)AssociatedDataSet);
            //add default data
            scheduleGroupOrganizationDs.ScheduleGroupOrganization.AddScheduleGroupOrganizationRow(newRow);
        }

        public void SelectScheduleGroupOrganization(int scheduleGroupOrganizationId)
        {
            ((ScheduleGroupOrganizationDA)AssociatedDA).SelectScheduleGroupOrganization(scheduleGroupOrganizationId);
            Select();
        }


        public void Select()
        {
            base.Select();
            ((ScheduleGroupOrganizationDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
        #region ScheduleGroupOrganizationOrganization
        public void SearchOrganization()
        {

        }
        #endregion
        /// <summary>
        /// 1. Add the Organization to the existing ScheduleGroupOrganization 
        /// 2. Add the new Organization to ScheduleGroupOrganizationOrganization
        /// 3. Save the dataSet
        /// </summary>
        /// <param name="organizationID"></param>
        public void AddOrganizationDefault(int newOrganizationID, int organizationID, int sourceCodeID)
        {
            //Step 1
            _scheduleGroupOrganizationDA.OrganizationID = organizationID;
            _scheduleGroupOrganizationDA.SourceCodeID =  sourceCodeID;
            _scheduleGroupOrganizationDA.AddScheduleGroupOrganizationDefault();

            Select();

            //Step 2
            //add Associated Organization
            if (((ScheduleGroupOrganizationDS)AssociatedDataSet).ScheduleGroupOrganizationSearch.Count == 0)
                return;

            AssociatedDataSet.scheduleGroupOrganizationDs().ScheduleGroupOrganizationSearch.ToList().ForEach(row =>
                {

                    ///((ScheduleGroupOrganizationDS)AssociatedDataSet).ScheduleGroupOrganization.ScheduleGroupIDColumn.DefaultValue = ((ScheduleGroupOrganizationDS)AssociatedDataSet).ScheduleGroupOrganization[grConstant.FirstRow].ScheduleGroupID;
                    AssociatedDataSet.scheduleGroupOrganizationDs().ScheduleGroupOrganization.ScheduleGroupIDColumn.DefaultValue = row.ScheduleGroupID;
                    ScheduleGroupOrganizationDS.ScheduleGroupOrganizationRow scheduleGroupOrganizationOrganizationRow = ((ScheduleGroupOrganizationDS)AssociatedDataSet).ScheduleGroupOrganization.NewScheduleGroupOrganizationRow();
                    scheduleGroupOrganizationOrganizationRow.OrganizationID = newOrganizationID;
                    ((ScheduleGroupOrganizationDS)AssociatedDataSet).ScheduleGroupOrganization.AddScheduleGroupOrganizationRow(scheduleGroupOrganizationOrganizationRow);

                });
                //Step 3
                SaveDataSet();

        }
    }
    public static class DataSetConversion
    {
        public static ScheduleGroupOrganizationDS scheduleGroupOrganizationDs(this DataSet dataset)
        {
            try
            {
                return (ScheduleGroupOrganizationDS)dataset;
            }
            catch
            {
                return null;
            }
        }
    }

}
