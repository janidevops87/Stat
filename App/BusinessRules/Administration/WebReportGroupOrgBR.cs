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
    public class WebReportGroupOrgBR : BaseBR, IOrganizationSearch
    {
        private WebReportGroupOrgDA _webReportGroupOrgDA;
        
        //public SearchParameter OrganizationSearchParameter
        //{
        //    get { return _webReportGroupOrgDA.OrganizationSearchParameter; }
        //    set { _webReportGroupOrgDA.OrganizationSearchParameter = value; }
        //}
        public WebReportGroupOrgBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new WebReportGroupOrgDS();
            AssociatedDA = new WebReportGroupOrgDA();
            _webReportGroupOrgDA = (WebReportGroupOrgDA)AssociatedDA;

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
            WebReportGroupOrgDS webReportGroupOrgDS = (WebReportGroupOrgDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < webReportGroupOrgDS.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(webReportGroupOrgDS.Tables[forLoop]);
                SetDefaultCreateValues(webReportGroupOrgDS.Tables[forLoop]);
            }

        }
        protected override void BusinessRulesAfterSave()
        {
            SetWebReportGroupOrgID();
        }

        #endregion
        #region Fields/Properties
        private GeneralConstant grConstant;
        private int webReportGroupOrgID;
        public int WebReportGroupOrgId
        {
            get { return webReportGroupOrgID; }
            set
            {
                webReportGroupOrgID = value;
                ((WebReportGroupOrgDA)AssociatedDA).WebReportGroupOrgId = value;
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

                WebReportGroupOrgDS webReportGroupOrgDS = (WebReportGroupOrgDS)AssociatedDataSet;
                if (row.Table.Columns.Contains("WebReportGroupOrgID") && !row.Table.Columns["WebReportGroupOrgID"].AutoIncrement)
                    row[row.Table.Columns["WebReportGroupOrgID"].Ordinal] = webReportGroupOrgDS.WebReportGroupOrg[grConstant.FirstRow].WebReportGroupOrgID;
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
            WebReportGroupOrgDS webReportGroupOrgDS = (WebReportGroupOrgDS)AssociatedDataSet;
            SetDefaultValue(webReportGroupOrgDS.WebReportGroupOrg);
        }
        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        public void AddEmptyRow()
        {
            WebReportGroupOrgDS webReportGroupOrgDS = (WebReportGroupOrgDS)AssociatedDataSet;

            if (webReportGroupOrgDS.WebReportGroupOrg.Count > 0)
            {
                ClearDataFromTables(webReportGroupOrgDS);
            }

            SetDefaultValue(webReportGroupOrgDS.WebReportGroupOrg);
            if (webReportGroupOrgDS.WebReportGroupOrg.Count == 0)
                AddEmptyRow(webReportGroupOrgDS.WebReportGroupOrg);
        }

        private static void ClearDataFromTables(WebReportGroupOrgDS webReportGroupOrgDS)
        {
            webReportGroupOrgDS.WebReportGroupOrg.Clear();
        }
        private void SetWebReportGroupOrgID()
        {
            WebReportGroupOrgDS webReportGroupOrgDS = (WebReportGroupOrgDS)AssociatedDataSet;
            if (webReportGroupOrgDS.WebReportGroupOrg.Rows.Count > 0)
            {
                WebReportGroupOrgId = webReportGroupOrgDS.WebReportGroupOrg[grConstant.FirstRow].WebReportGroupOrgID;
            }
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            WebReportGroupOrgDS webReportGroupOrgDS = (WebReportGroupOrgDS)AssociatedDataSet;
            if (dataTable.Columns.Contains("WebReportGroupOrgID") && !dataTable.Columns["AlertID"].AutoIncrement)
            {
                dataTable.Columns["WebReportGroupOrgID"].DefaultValue = webReportGroupOrgDS.WebReportGroupOrg[grConstant.FirstRow].WebReportGroupOrgID;
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


        private void AddDefaultData(WebReportGroupOrgDS.WebReportGroupOrgDataTable table)
        {
            WebReportGroupOrgDS.WebReportGroupOrgRow newRow = table.NewWebReportGroupOrgRow();
            WebReportGroupOrgDS webReportGroupOrgDs = ((WebReportGroupOrgDS)AssociatedDataSet);
            //add default data
            webReportGroupOrgDs.WebReportGroupOrg.AddWebReportGroupOrgRow(newRow);
        }

        public void SelectWebReportGroupOrg(int webReportGroupOrgId)
        {
            ((WebReportGroupOrgDA)AssociatedDA).SelectWebReportGroupOrg(webReportGroupOrgId);
            Select();
        }


        public void Select()
        {
            base.Select();
            ((WebReportGroupOrgDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
        #region WebReportGroupOrgOrganization
        public void SearchOrganization()
        {

        }
    #endregion
        /// <summary>
        /// 1. Add the Organization to the existing WebReportGroupOrg 
        /// 2. Add the new Organization to WebReportGroupOrgOrganization
        /// 3. Save the dataSet
        /// </summary>
        /// <param name="organizationID"></param>
        public void AddOrganizationDefault(int newOrganizationID, int organizationID)
        {
            //Step 1
            _webReportGroupOrgDA.OrganizationID = organizationID;    

            _webReportGroupOrgDA.AddWebReportGroupOrgDefault();
            
            Select();

            
            //Step 2
            //add Associated Organization
            if (AssociatedDataSet.webReportGroupOrgDs().WebReportGroupOrgSearch.Count == 0)
                return;
            AssociatedDataSet.webReportGroupOrgDs().WebReportGroupOrgSearch.ToList().ForEach(row =>
                {
                    AssociatedDataSet.webReportGroupOrgDs().WebReportGroupOrg.WebReportGroupIDColumn.DefaultValue = row.WebReportGroupID;
                    AssociatedDataSet.webReportGroupOrgDs().WebReportGroupOrg.ReportIDColumn.DefaultValue = 0; //default 0 column not used
                    WebReportGroupOrgDS.WebReportGroupOrgRow webReportGroupOrgRow = AssociatedDataSet.webReportGroupOrgDs().WebReportGroupOrg.NewWebReportGroupOrgRow();

                    webReportGroupOrgRow.OrganizationID = newOrganizationID;
                    AssociatedDataSet.webReportGroupOrgDs().WebReportGroupOrg.AddWebReportGroupOrgRow(webReportGroupOrgRow);
                });
            //Step 3
            SaveDataSet();
        }
    }

    public static class DataSetConversionWebReportGroupOrg
    {
        public static WebReportGroupOrgDS webReportGroupOrgDs(this DataSet dataset)
        {
            try
            {
                return (WebReportGroupOrgDS)dataset;
            }
            catch
            {
                return null;
            }
        }
    }
    

}
