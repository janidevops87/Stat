using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Criteria;
using Statline.Stattrac.DataAccess.Criteria;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.BusinessRules.Criteria
{
    public class CriteriaBR : BaseBR, IOrganizationSearch
    {
        private CriteriaDA _criteriaDA;

        public SearchParameter OrganizationSearchParameter
        {   get { return _criteriaDA.OrganizationSearchParameter; }
            set { _criteriaDA.OrganizationSearchParameter = value; }
        }
        public SearchParameter IndicationSearchParameter
        {
            get { return _criteriaDA.IndicationSearchParameter; }
            set { _criteriaDA.IndicationSearchParameter = value; }
        }

        public CriteriaBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new CriteriaDS();
            AssociatedDA = new CriteriaDA();
            _criteriaDA = (CriteriaDA)AssociatedDA;

        }

        #region Fields/Properties
        private GeneralConstant grConstant;
        private int criteriaID;
        private int criteriaStatus;
        private int donorCategoryID;
        private int sourceCodeID;
        private int organizationID;

        public int CriteriaID
        {
            get { return criteriaID; }
            set
            {
                criteriaID = value;
                ((CriteriaDA)AssociatedDA).CriteriaID = value;
            }
        }
        public int CriteriaStatus
        {
            get { return criteriaStatus; }
            set
            {
                criteriaStatus = value;
                ((CriteriaDA)AssociatedDA).CriteriaStatus = value;
            }
        }

        public int DonorCategoryID
        {
            get { return donorCategoryID; }
            set
            {
                donorCategoryID = value;
                ((CriteriaDA)AssociatedDA).DonorCategoryID = value;
            }
        }
        public int SourceCodeID
        {
            get { return sourceCodeID; }
            set
            {
                sourceCodeID = value;
                ((CriteriaDA)AssociatedDA).SourceCodeID = value;
            }
        }
        public int OrganizationID
        {
            get { return organizationID; }
            set
            {
                organizationID = value;
                ((CriteriaDA)AssociatedDA).OrganizationID = value;
            }
        }

        #endregion

        #region private methods
        private void SetDefaultModifiedValues(DataTable table)
        {
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

            // row => row.RowState == DataRowState.Modified)

        }

        private void AddEmptyRow()
        {
            //RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)AssociatedDataSet;
            //SetDefaultValue(ruleOutIndicationsDS.Indication);
            //if (ruleOutIndicationsDS.Indication.Count == 0)
            //    AddEmptyRow(ruleOutIndicationsDS.Indication);

        }

        /// <summary>
        /// Set the default values on the tables
        /// </summary>
        private void SetDefaultValue()
        {
            CriteriaDS criteriaDs = (CriteriaDS)AssociatedDataSet;
            SetDefaultValue(criteriaDs.Criteria);
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            CriteriaDS criteriaDS = (CriteriaDS)AssociatedDataSet;
            //if (dataTable.Columns.Contains("OrganizationID") && !dataTable.Columns["OrganizationID"].AutoIncrement)
            //{
            //    dataTable.Columns["OrganizationID"].DefaultValue = organizationDS.Organization[grConstant.FirstRow].OrganizationID;
            //}
            if (dataTable.Columns.Contains("LastStatEmployeeID"))
                dataTable.Columns["LastStatEmployeeID"].DefaultValue = StattracIdentity.Identity.UserId;
            if (dataTable.Columns.Contains("LastModified"))
                dataTable.Columns["LastModified"].DefaultValue = grConstant.CurrentDateTime;
            if (dataTable.Columns.Contains("AuditLogTypeID"))
                dataTable.Columns["AuditLogTypeID"].DefaultValue = GeneralConstant.AuditLogType.Create;
        }

        public void SelectCriteria(int criteriaID, int donorCategoryID)
        {
            ((CriteriaDA)AssociatedDA).SelectCriteria(criteriaID);
            Select();
        }
        public void SelectCriteriaSourceCode(int criteriaID)
        {
            ((CriteriaDA)AssociatedDA).SelectCriteriaSourceCode(criteriaID);
            Select();
        }
        protected void Select()
        {
            base.Select();
            ((CriteriaDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion

        #region Associated Organizations and Processors
        public void SearchOrganization()
        {
            _criteriaDA.SearchOrganization();

            //may need add functionality here to clear some all of the organization List
            //find and remove any records with the current CriteriaID
            // create a copy of rows in sourcecodeID what have been modified
            CriteriaDS criteriaDs = ((CriteriaDS)AssociatedDataSet);
            DataTable copyCriteriaOrganizations = null;

            IEnumerable<DataRow> query =
                from criteriaOrganization in ((DataTable)criteriaDs.CriteriaOrganization).AsEnumerable()
                where
                    (criteriaOrganization.Field<Int32>(
                         criteriaDs.CriteriaOrganization.CriteriaIDColumn.ColumnName) == grConstant.CriteriaId)
                where
                    criteriaOrganization.RowState == DataRowState.Modified
                select criteriaOrganization;

            if (query.Count() > 0)
                copyCriteriaOrganizations = query.CopyToDataTable<DataRow>();

            //clear all records with a current CriteriaID
            criteriaDs.CriteriaOrganization.Where
            (
                row =>
                row.CriteriaID == grConstant.CriteriaId
            ).ToList().ForEach
            (delegate(CriteriaDS.CriteriaOrganizationRow row)
            {
                criteriaDs.CriteriaOrganization.RemoveCriteriaOrganizationRow(row);
            }
            );

            //run the query
            Select();

            //may need to add functionality here after the sprocs is executed.
            //use the copy of the modified records to and reset the records
            if (copyCriteriaOrganizations != null)
            {
                //create a query
                query = from copyCriteriaOrganization in copyCriteriaOrganizations.AsEnumerable()
                        select copyCriteriaOrganization;
                //use the query to loop throught the records
                //update records if they exist in the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                        criteriaDs.CriteriaOrganization.Where
                            (
                            row =>
                            row.CriteriaID == grConstant.CriteriaId &&
                            row.OrganizationID == Convert.ToInt32(rowCopy[criteriaDs.CriteriaOrganization.OrganizationIDColumn.ColumnName])).ToList().
                            ForEach
                            (delegate(CriteriaDS.CriteriaOrganizationRow row)
                            {
                                row.Hidden = Convert.ToBoolean(rowCopy[criteriaDs.CriteriaOrganization.HiddenColumn.Ordinal]);
                                row.AcceptChanges();
                                row.SetModified();
                                copyCriteriaOrganizations.Rows.Remove(rowCopy);
                            });
                    });
                //create a query
                query = from copyCriteriaOrganization in copyCriteriaOrganizations.AsEnumerable()
                        select copyCriteriaOrganization;
                //add records not in soucecodelist of organizations back to the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                        CriteriaDS.CriteriaOrganizationRow criteriaOrganizationRow = criteriaDs.CriteriaOrganization.AddCriteriaOrganizationRow(
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaOrganization.CriteriaIDColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaOrganization.OrganizationIDColumn.ColumnName]),
                            Convert.ToDateTime(Convert.ToString(rowCopy[criteriaDs.CriteriaOrganization.LastModifiedColumn.ColumnName])),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaOrganization.LastStatEmployeeIDColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaOrganization.AuditLogTypeIDColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaOrganization.OrganizationNameColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaOrganization.OrganizationCityColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaOrganization.StateAbbrvColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaOrganization.OrganizationTypeColumn.ColumnName]),
                            Convert.ToBoolean(rowCopy[criteriaDs.CriteriaOrganization.HiddenColumn.ColumnName])
                            );
                        criteriaOrganizationRow.AcceptChanges();
                        criteriaOrganizationRow.SetModified();

                    });

            }
        }
        public void SearchIndication()
        {
            _criteriaDA.SearchIndication(grConstant.CriteriaId);

            //may need add functionality here to clear some all of the organization List
            //find and remove any records with the current CriteriaID
            // create a copy of rows in sourcecodeID what have been modified
            CriteriaDS criteriaDs = ((CriteriaDS)AssociatedDataSet);
            DataTable copyCriteriaIndications = null;

            IEnumerable<DataRow> query =
                from criteriaIndication in ((DataTable)criteriaDs.CriteriaIndication).AsEnumerable()
                where
                    (criteriaIndication.Field<Int32>(
                         criteriaDs.CriteriaIndication.CriteriaIDColumn.ColumnName) == grConstant.CriteriaId)
                where
                    criteriaIndication.RowState == DataRowState.Modified
                select criteriaIndication;

            if (query.Count() > 0)
                copyCriteriaIndications = query.CopyToDataTable<DataRow>();

            //clear all records with a current CriteriaID
            criteriaDs.CriteriaIndication.Where
            (
                row =>
                row.CriteriaID == grConstant.CriteriaId
            ).ToList().ForEach
            (delegate(CriteriaDS.CriteriaIndicationRow row)
            {
                criteriaDs.CriteriaIndication.RemoveCriteriaIndicationRow(row);
            }
            );

            //run the query
            Select();

            //may need to add functionality here after the sprocs is executed.
            //use the copy of the modified records to and reset the records
            if (copyCriteriaIndications != null)
            {
                //create a query
                query = from copyCriteriaIndication in copyCriteriaIndications.AsEnumerable()
                        select copyCriteriaIndication;
                //use the query to loop throught the records
                //update records if they exist in the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                        criteriaDs.CriteriaIndication.Where
                            (
                            row =>
                            row.CriteriaID == grConstant.CriteriaId &&
                            row.IndicationID == Convert.ToInt32(rowCopy[criteriaDs.CriteriaIndication.IndicationIDColumn.ColumnName])).ToList().
                            ForEach
                            (delegate(CriteriaDS.CriteriaIndicationRow row)
                            {
                                row.Hidden = Convert.ToBoolean(rowCopy[criteriaDs.CriteriaIndication.HiddenColumn.Ordinal]);
                                row.AcceptChanges();
                                row.SetModified();
                                copyCriteriaIndications.Rows.Remove(rowCopy);
                            });
                    });
                //create a query
                query = from copyCriteriaIndication in copyCriteriaIndications.AsEnumerable()
                        select copyCriteriaIndication;
                //add records not in soucecodelist of organizations back to the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                        CriteriaDS.CriteriaIndicationRow criteriaIndicationRow = criteriaDs.CriteriaIndication.AddCriteriaIndicationRow(
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaIndication.CriteriaIDColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaIndication.IndicationIDColumn.ColumnName]),
                            Convert.ToDateTime(Convert.ToString(rowCopy[criteriaDs.CriteriaIndication.LastModifiedColumn.ColumnName])),
                            Convert.ToInt16(rowCopy[criteriaDs.CriteriaIndication.IndicationHighRiskColumn.ColumnName]),
                            Convert.ToInt16(rowCopy[criteriaDs.CriteriaIndication.IndicationStandardMROColumn.ColumnName]),
                            Convert.ToInt16(rowCopy[criteriaDs.CriteriaIndication.UpdatedFlagColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaIndication.LastStatEmployeeIDColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaIndication.AuditLogTypeIDColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaIndication.IndicationNameColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaIndication.IndicationResponseNameColumn.ColumnName]),
                            Convert.ToBoolean(rowCopy[criteriaDs.CriteriaIndication.HiddenColumn.ColumnName])
                            );
                        criteriaIndicationRow.AcceptChanges();
                        criteriaIndicationRow.SetModified();

                    });

            }
        }

        public void SearchProcessor()
        {
            _criteriaDA.SearchProcessor(grConstant.CriteriaId, grConstant.CriteriaProcessorTypeId, grConstant.CriteriaProcessorStateId);

            //may need add functionality here to clear some all of the organization List
            //find and remove any records with the current CriteriaID
            // create a copy of rows in sourcecodeID what have been modified
            CriteriaDS criteriaDs = ((CriteriaDS)AssociatedDataSet);
            DataTable copyCriteriaProcessors = null;

            IEnumerable<DataRow> query =
                //from criteriaDs.CriteriaOrganization in criteriaDs.CriteriaOrganization.AsEnumerable()
                from criteriaProcessor in ((DataTable)criteriaDs.CriteriaProcessor).AsEnumerable()
                where
                    (criteriaProcessor.Field<Int32>(
                         criteriaDs.CriteriaProcessor.CriteriaIDColumn.ColumnName) == grConstant.CriteriaId)
                where
                    criteriaProcessor.RowState == DataRowState.Modified
                select criteriaProcessor;

            if (query.Count() > 0)
                copyCriteriaProcessors = query.CopyToDataTable<DataRow>();

            //clear all records with a current CriteriaID
            criteriaDs.CriteriaProcessor.Where
            (
                row =>
                row.CriteriaID == grConstant.CriteriaId
            ).ToList().ForEach
            (delegate(CriteriaDS.CriteriaProcessorRow row)
            {
                criteriaDs.CriteriaProcessor.RemoveCriteriaProcessorRow(row);
            }
            );

            //run the query
            Select();

            //may need to add functionality here after the sprocs is executed.
            //use the copy of the modified records to and reset the records
            if (copyCriteriaProcessors != null)
            {
                //create a query
                query = from copyCriteriaProcessor in copyCriteriaProcessors.AsEnumerable()
                        select copyCriteriaProcessor;
                //use the query to loop throught the records
                //update records if they exist in the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                        criteriaDs.CriteriaProcessor.Where
                            (
                            row =>
                            row.CriteriaID == grConstant.CriteriaId &&
                            row.OrganizationID == Convert.ToInt32(rowCopy[criteriaDs.CriteriaProcessor.OrganizationIDColumn.ColumnName])).ToList().
                            ForEach
                            (delegate(CriteriaDS.CriteriaProcessorRow row)
                            {
                                row.Hidden = Convert.ToBoolean(rowCopy[criteriaDs.CriteriaProcessor.HiddenColumn.Ordinal]);
                                row.AcceptChanges();
                                row.SetModified();
                                copyCriteriaProcessors.Rows.Remove(rowCopy);
                            });
                    });
                //create a query
                query = from copyCriteriaProcessor in copyCriteriaProcessors.AsEnumerable()
                        select copyCriteriaProcessor;
                //add records not in soucecodelist of organizations back to the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                        CriteriaDS.CriteriaProcessorRow criteriaProcessorRow = criteriaDs.CriteriaProcessor.AddCriteriaProcessorRow(
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaProcessor.CriteriaIDColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaProcessor.OrganizationIDColumn.ColumnName]),
                            Convert.ToDateTime(Convert.ToString(rowCopy[criteriaDs.CriteriaProcessor.LastModifiedColumn.ColumnName])),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaProcessor.LastStatEmployeeIDColumn.ColumnName]),
                            Convert.ToInt32(rowCopy[criteriaDs.CriteriaProcessor.AuditLogTypeIDColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaProcessor.OrganizationNameColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaProcessor.OrganizationCityColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaProcessor.StateAbbrvColumn.ColumnName]),
                            Convert.ToString(rowCopy[criteriaDs.CriteriaProcessor.OrganizationTypeColumn.ColumnName]),
                            Convert.ToBoolean(rowCopy[criteriaDs.CriteriaProcessor.HiddenColumn.ColumnName])
                            );
                        criteriaProcessorRow.AcceptChanges();
                        criteriaProcessorRow.SetModified();

                    });

            }
        }
        #endregion

        /// <summary>
        /// 1. Add the Organization to the existing Criteria 
        /// 2. Add the new Organization to CriteriaOrganization
        /// 3. Save the dataSet
        /// </summary>
        /// <param name="organizationID"></param>
        public void AddOrganizationDefault(int newOrganizationID)
        {
            //Step 1
            _criteriaDA.AddCriteriaOrganizationDefault();

            Select();

            //Step 2
            //add Associated Organization
            if (((CriteriaDS)AssociatedDataSet).CriteriaSearch.Rows.Count == 0)
                return;
            ((CriteriaDS)AssociatedDataSet).CriteriaOrganization.CriteriaIDColumn.DefaultValue = ((CriteriaDS)AssociatedDataSet).CriteriaSearch[grConstant.FirstRow].CriteriaID;
            ((CriteriaDS)AssociatedDataSet).CriteriaOrganization.HiddenColumn.DefaultValue = true;
            
            CriteriaDS.CriteriaOrganizationRow criteriaOrganizationRow = ((CriteriaDS)AssociatedDataSet).CriteriaOrganization.NewCriteriaOrganizationRow();
            criteriaOrganizationRow.OrganizationID = newOrganizationID;

            ((CriteriaDS)AssociatedDataSet).CriteriaOrganization.AddCriteriaOrganizationRow(criteriaOrganizationRow);

            //Step 3
            SaveDataSet();
        }
    }
}
