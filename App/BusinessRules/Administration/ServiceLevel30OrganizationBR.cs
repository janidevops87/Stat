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
    public class ServiceLevel30OrganizationBR : BaseBR, IOrganizationSearch
    {
        private ServiceLevel30OrganizationDA _serviceLevel30OrganizationDA;

        //public SearchParameter OrganizationSearchParameter
        //{
        //    get { return _serviceLevel30OrganizationDA.OrganizationSearchParameter; }
        //    set { _serviceLevel30OrganizationDA.OrganizationSearchParameter = value; }
        //}
        public ServiceLevel30OrganizationBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new ServiceLevel30OrganizationDS();
            AssociatedDA = new ServiceLevel30OrganizationDA();
            _serviceLevel30OrganizationDA = (ServiceLevel30OrganizationDA)AssociatedDA;

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
            ServiceLevel30OrganizationDS serviceLevel30OrganizationDS = (ServiceLevel30OrganizationDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < serviceLevel30OrganizationDS.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(serviceLevel30OrganizationDS.Tables[forLoop]);
                SetDefaultCreateValues(serviceLevel30OrganizationDS.Tables[forLoop]);
            }

        }
        protected override void BusinessRulesAfterSave()
        {
            SetServiceLevel30OrganizationID();
        }

        #endregion
        #region Fields/Properties
        private GeneralConstant grConstant;
        private int serviceLevel30OrganizationID;
        public int ServiceLevel30OrganizationId
        {
            get { return serviceLevel30OrganizationID; }
            set
            {
                serviceLevel30OrganizationID = value;
                ((ServiceLevel30OrganizationDA)AssociatedDA).ServiceLevelOrganizationId = value;
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

                ServiceLevel30OrganizationDS serviceLevel30OrganizationDS = (ServiceLevel30OrganizationDS)AssociatedDataSet;
                if (row.Table.Columns.Contains("ServiceLevelOrganizationID") && !row.Table.Columns["ServiceLevelOrganizationID"].AutoIncrement)
                    row[row.Table.Columns["ServiceLevelOrganizationID"].Ordinal] = serviceLevel30OrganizationDS.ServiceLevel30Organization[grConstant.FirstRow].ServiceLevelOrganizationID;
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
            ServiceLevel30OrganizationDS serviceLevel30OrganizationDS = (ServiceLevel30OrganizationDS)AssociatedDataSet;
            SetDefaultValue(serviceLevel30OrganizationDS.ServiceLevel30Organization);
        }
        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        public void AddEmptyRow()
        {
            ServiceLevel30OrganizationDS serviceLevel30OrganizationDS = (ServiceLevel30OrganizationDS)AssociatedDataSet;

            if (serviceLevel30OrganizationDS.ServiceLevel30Organization.Count > 0)
            {
                ClearDataFromTables(serviceLevel30OrganizationDS);
            }

            SetDefaultValue(serviceLevel30OrganizationDS.ServiceLevel30Organization);
            if (serviceLevel30OrganizationDS.ServiceLevel30Organization.Count == 0)
                AddEmptyRow(serviceLevel30OrganizationDS.ServiceLevel30Organization);
        }

        private static void ClearDataFromTables(ServiceLevel30OrganizationDS serviceLevel30OrganizationDS)
        {
            serviceLevel30OrganizationDS.ServiceLevel30Organization.Clear();
        }
        private void SetServiceLevel30OrganizationID()
        {
            ServiceLevel30OrganizationDS serviceLevel30OrganizationDS = (ServiceLevel30OrganizationDS)AssociatedDataSet;
            if (serviceLevel30OrganizationDS.ServiceLevel30Organization.Rows.Count > 0)
            {
                ServiceLevel30OrganizationId = serviceLevel30OrganizationDS.ServiceLevel30Organization[grConstant.FirstRow].ServiceLevelOrganizationID;
            }
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            ServiceLevel30OrganizationDS serviceLevel30OrganizationDS = (ServiceLevel30OrganizationDS)AssociatedDataSet;
            if (dataTable.Columns.Contains("ServiceLevelOrganizationID") && !dataTable.Columns["AlertID"].AutoIncrement)
            {
                dataTable.Columns["ServiceLevelOrganizationID"].DefaultValue = serviceLevel30OrganizationDS.ServiceLevel30Organization[grConstant.FirstRow].ServiceLevelOrganizationID;
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


        private void AddDefaultData(ServiceLevel30OrganizationDS.ServiceLevel30OrganizationDataTable table)
        {
            ServiceLevel30OrganizationDS.ServiceLevel30OrganizationRow newRow = table.NewServiceLevel30OrganizationRow();
            ServiceLevel30OrganizationDS serviceLevel30OrganizationDs = ((ServiceLevel30OrganizationDS)AssociatedDataSet);
            //add default data
            serviceLevel30OrganizationDs.ServiceLevel30Organization.AddServiceLevel30OrganizationRow(newRow);
        }

        public void SelectServiceLevel30Organization(int serviceLevelOrganizationId)
        {
            ((ServiceLevel30OrganizationDA)AssociatedDA).SelectServiceLevel30Organization(serviceLevelOrganizationId);
            Select();
        }


        public void Select()
        {
            base.Select();
            ((ServiceLevel30OrganizationDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
        #region ServiceLevel30OrganizationOrganization
        public void SearchOrganization()
        {

        }
        #endregion
        /// <summary>
        /// 1. Add the Organization to the existing ServiceLevel30Organization 
        /// 2. Add the new Organization to ServiceLevel30OrganizationOrganization
        /// 3. Save the dataSet
        /// </summary>
        /// <param name="organizationID"></param>
        public void AddOrganizationDefault(int newOrganizationID, int organizationID, int sourceCodeID, int criteriaStatus)
        {
            //Step 1
            _serviceLevel30OrganizationDA.OrganizationID = organizationID;
            _serviceLevel30OrganizationDA.SourceCodeID = sourceCodeID;
            _serviceLevel30OrganizationDA.CriteriaStatus = criteriaStatus;

            _serviceLevel30OrganizationDA.AddServiceLevel30OrganizationDefault();

            Select();

            //Step 2
            //add Associated Organization
            if (((ServiceLevel30OrganizationDS)AssociatedDataSet).ServiceLevel30Organization.Count == 0)
                return;
            ((ServiceLevel30OrganizationDS)AssociatedDataSet).ServiceLevel30Organization.ServiceLevelIDColumn.DefaultValue = ((ServiceLevel30OrganizationDS)AssociatedDataSet).ServiceLevel30Organization[grConstant.FirstRow].ServiceLevelID;
            ServiceLevel30OrganizationDS.ServiceLevel30OrganizationRow serviceLevel30OrganizationOrganizationRow = ((ServiceLevel30OrganizationDS)AssociatedDataSet).ServiceLevel30Organization.NewServiceLevel30OrganizationRow();
            serviceLevel30OrganizationOrganizationRow.OrganizationID = newOrganizationID;
            ((ServiceLevel30OrganizationDS)AssociatedDataSet).ServiceLevel30Organization.AddServiceLevel30OrganizationRow(serviceLevel30OrganizationOrganizationRow);

            //Step 3
            SaveDataSet();
        }
    }

}
