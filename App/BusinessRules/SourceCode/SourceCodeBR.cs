using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.SourceCode;
using Statline.Stattrac.DataAccess.SourceCode;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.BusinessRules.SourceCode
{
    public class SourceCodeBR : BaseBR, IOrganizationSearch
    {
        private SourceCodeDA _sourceCodeDA;
        public SearchParameter OrganizationSearchParameter 
        {   get{return _sourceCodeDA.OrganizationSearchParameter;}
            set{ _sourceCodeDA.OrganizationSearchParameter = value; }
        }
        public SourceCodeBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new SourceCodeDS();
            AssociatedDA = new SourceCodeDA();
            _sourceCodeDA = (SourceCodeDA)AssociatedDA;
            
        }
        public enum SourceCodeDisabledInterval
        { 
            DefaultValue = 0
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
            //sourceCodeDS.EnforceConstraints = true;
            //AddEmptyRow();

            ////modify the SourceCode to 
            ((SourceCodeDS)AssociatedDataSet).SourceCode
                .ToList().ForEach
            (delegate(SourceCodeDS.SourceCodeRow row)
            {
                row.AcceptChanges();
            });

            ////modify the SourceCodeASp to 
            ((SourceCodeDS)AssociatedDataSet).SourceCodeASP
                .ToList().ForEach
            (delegate(SourceCodeDS.SourceCodeASPRow row)
            {
                row.AcceptChanges();
            });

            ////modify the DonorTracURL to 
            ((SourceCodeDS)AssociatedDataSet).DonorTracURL
                .ToList().ForEach
            (delegate(SourceCodeDS.DonorTracURLRow row)
            {
                row.AcceptChanges();
            });
 
        }
        protected override void BusinessRulesBeforeSave()
        {
            //check the state of each table if the data has changed update the lastmodified, logtype and LastStatEmployeeID
            SourceCodeDS sourceCodeDS = (SourceCodeDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < sourceCodeDS.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(sourceCodeDS.Tables[forLoop]);
                SetDefaultCreateValues(sourceCodeDS.Tables[forLoop]);
            }                


            
        }
        protected override void BusinessRulesAfterSave()
        {
            SetSourceCodeID();
        }
        public void AcceptRowChanges()
        {
            BusinessRulesAfterSelect();
        }

#endregion
    #region Fields/Properties
        private GeneralConstant grConstant;
        private int sourceCodeID;
        public int SourceCodeID
        {
            get { return sourceCodeID; }
            set
            {
                sourceCodeID = value;
                ((SourceCodeDA)AssociatedDA).SourceCodeID = value;
            }
        }
        public int CheckForSourceCodeDuplicatesResults
        {
            get
            {
                return ((SourceCodeDA)AssociatedDA).CheckForSourceCodeDuplicatesResults;
            }
            set
            {
                ((SourceCodeDA)AssociatedDA).CheckForSourceCodeDuplicatesResults = value;
            }
        }
        public int CheckForExistingDefaultSourceCodeResults
        {
            get
            {
                return ((SourceCodeDA)AssociatedDA).CheckForExistingDefaultSourceCodeResults;
            }
            set
            {
                ((SourceCodeDA)AssociatedDA).CheckForExistingDefaultSourceCodeResults = value;
            }
        }
        public string SourceCodeName
        {
            get
            {
                return ((SourceCodeDA)AssociatedDA).SourceCodeName;
            }
            set
            {
                ((SourceCodeDA)AssociatedDA).SourceCodeName = value;
            }
        }
        public int SourceCodeCallTypeId
        {
            get
            {
                return ((SourceCodeDA)AssociatedDA).SourceCodeCallTypeId;
            }
            set
            {
                ((SourceCodeDA)AssociatedDA).SourceCodeCallTypeId = value;
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

            // row => row.RowState == DataRowState.Modified)

        }

        private void SetDefaultCreateValues(DataTable table)
        {   //
            table.Select().ToList().ForEach(delegate(DataRow row)
            {
                if (row.RowState != DataRowState.Added)
                    return;
                
                SourceCodeDS sourceCodeDS = (SourceCodeDS)AssociatedDataSet;
                if (row.Table.Columns.Contains("SourceCodeID") && !row.Table.Columns["SourceCodeID"].AutoIncrement)
                    row[row.Table.Columns["SourceCodeID"].Ordinal] = sourceCodeDS.SourceCode[grConstant.FirstRow].SourceCodeID;
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
            SourceCodeDS sourceCodeDS = (SourceCodeDS)AssociatedDataSet;
            SetDefaultValue(sourceCodeDS.SourceCode);
            SetDefaultValue(sourceCodeDS.SourceCodeOrganization);
            SetDefaultValue(sourceCodeDS.AspSourceCodeMap);
            SetDefaultValue(sourceCodeDS.DonorTracURL);
            SetDefaultValue(sourceCodeDS.DonorTracIdentifier);
            SetDefaultValue(sourceCodeDS.SourceCodeTransplantCenter);
            SetDefaultValue(sourceCodeDS.SourceCodeASP);
        }
        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        public void AddEmptyRow()
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)AssociatedDataSet;

            if (sourceCodeDS.SourceCode.Count > 0) 
            {
                ClearDataFromTables(sourceCodeDS);
            }

            
            SetDefaultValue(sourceCodeDS.SourceCode);
            if (sourceCodeDS.SourceCode.Count == 0)
                AddEmptyRow(sourceCodeDS.SourceCode);

            SetDefaultValue(sourceCodeDS.SourceCodeASP);
            if (sourceCodeDS.SourceCodeASP.Count == 0)
                AddEmptyRow(sourceCodeDS.SourceCodeASP);

            SetDefaultValue(sourceCodeDS.DonorTracURL);
            if (sourceCodeDS.DonorTracURL.Count == 0)
                AddEmptyRow(sourceCodeDS.DonorTracURL);
        }

        private static void ClearDataFromTables(SourceCodeDS sourceCodeDS)
        {
            sourceCodeDS.SourceCodeASP.Clear();
            sourceCodeDS.SourceCodeTransplantCenter.Clear();
            sourceCodeDS.DonorTracIdentifier.Clear();
            sourceCodeDS.DonorTracURL.Clear();
            sourceCodeDS.AspSourceCodeMap.Clear();
            sourceCodeDS.SourceCode.Clear();
        }
        private void SetSourceCodeID()
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)AssociatedDataSet;
            if (sourceCodeDS.SourceCode.Count == 0)
                return;
            
            //if grConstant.SourceCodeId is 0, this record was added and we need to get the new Id
            //if this was a modify use the same SourceCodeId
            if (grConstant.SourceCodeId == 0)
            {
                grConstant.SourceCodeId = sourceCodeDS.SourceCode.Max(SourceCodeRow => SourceCodeRow.SourceCodeID);
            }
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)AssociatedDataSet;
            if (dataTable.Columns.Contains("SourceCodeID") && !dataTable.Columns["SourceCodeID"].AutoIncrement)
                dataTable.Columns["SourceCodeID"].DefaultValue = sourceCodeDS.SourceCode[grConstant.FirstRow].SourceCodeID;
            if (dataTable.Columns.Contains("SourceCodeType"))
                dataTable.Columns["SourceCodeType"].DefaultValue = grConstant.SourceCodeCallTypeId;
            if (dataTable.Columns.Contains("SourceCodeCallTypeID"))
                dataTable.Columns["SourceCodeCallTypeID"].DefaultValue = grConstant.SourceCodeCallTypeId;
            if (dataTable.Columns.Contains("LastStatEmployeeID"))
                dataTable.Columns["LastStatEmployeeID"].DefaultValue = StattracIdentity.Identity.UserId;
            if (dataTable.Columns.Contains("LastModified"))
                dataTable.Columns["LastModified"].DefaultValue = grConstant.CurrentDateTime;
            if (dataTable.Columns.Contains("AuditLogTypeID"))
                dataTable.Columns["AuditLogTypeID"].DefaultValue = GeneralConstant.AuditLogType.Create;
            // Set default value. SourceCodeDisabledInterval cannot be null. 
            if (dataTable.Columns.Contains("SourceCodeDisabledInterval"))
                dataTable.Columns["SourceCodeDisabledInterval"].DefaultValue = SourceCodeDisabledInterval.DefaultValue;

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


        private void AddDefaultData(SourceCodeDS.SourceCodeDataTable table)
        {
            SourceCodeDS.SourceCodeRow newRow = table.NewSourceCodeRow();
            SourceCodeDS sourceCodeDs = ((SourceCodeDS)AssociatedDataSet);
            //add default data
            sourceCodeDs.SourceCode.AddSourceCodeRow(newRow);
        }

        public void AddDefaultData(SourceCodeDS.SourceCodeASPDataTable table)
        {
            SourceCodeDS.SourceCodeASPRow newRow = table.NewSourceCodeASPRow();
            SourceCodeDS sourceCodeDs = ((SourceCodeDS)AssociatedDataSet);
            //add default data
            sourceCodeDs.SourceCodeASP.AddSourceCodeASPRow(newRow);
        }

        public void AddDefaultData(SourceCodeDS.DonorTracURLDataTable table)
        {
            SourceCodeDS.DonorTracURLRow newRow = table.NewDonorTracURLRow();
            SourceCodeDS sourceCodeDs = ((SourceCodeDS)AssociatedDataSet);
            //add default data
            sourceCodeDs.DonorTracURL.AddDonorTracURLRow(newRow);
        }

        public void SelectSourceCode(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectSourceCode(sourceCodeId);
            Select();
        }
        public void SelectASPSourceCodeMap(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectASPSourceCodeMap(sourceCodeId);
            Select();
        }
        public void SelectDonorTracURL(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectDonorTracURL(sourceCodeId);
            Select();
        }
        public void SelectDonorTracIdentifier(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectDonorTracIdentifier(sourceCodeId);
            Select();
        }
        public void SelectSourceCodeTransplantCenter(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectSourceCodeTransplantCenter(sourceCodeId);
            Select();
        }
        public void SelectSourceCodeASP(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectSourceCodeASP(sourceCodeId);
            Select();
        }
        
        public void SelectSourceCodeOrganization(int sourceCodeId)
        {
            ((SourceCodeDA)AssociatedDA).SelectSourceCodeOrganization(sourceCodeId);
            Select();
        }

        public void Select()
        {
            base.Select();
            ((SourceCodeDA)AssociatedDA).SetDefaultTableSelect();
        }
        public int CheckForSourceCodeDuplicates(int sourceCodeId, string sourceCodeName, int sourceCodeCallTypeID)
        {

            //set values in the BR used to check for SourceCode
            SourceCodeID = sourceCodeId;
            SourceCodeName = sourceCodeName;
            SourceCodeCallTypeId = sourceCodeCallTypeID;

            //Setup DA for query
            ((SourceCodeDA)AssociatedDA).CheckForSourceCodeDuplicates();
            ExecuteNonQuery();

            return CheckForSourceCodeDuplicatesResults;
        }
        public int CheckForExistingDefaultSourceCode(int sourceCodeId, string sourceCodeName)
        {

            //set values in the BR used to check for SourceCode
            SourceCodeID = sourceCodeId;
            SourceCodeName = sourceCodeName;

            //Setup DA for query
            ((SourceCodeDA)AssociatedDA).CheckForExistingDefaultSourceCode();
            ExecuteNonQuery();

            return CheckForExistingDefaultSourceCodeResults;
        }
    #endregion
#region SourceCodeOrganization
        public void SearchOrganization()
        {
            _sourceCodeDA.SearchOrganization();
         
            //may need add functionality here to clear some all of the organization List
            //find and remove any records with the current SourceCodeID
            // create a copy of rows in sourcecodeID what have been modified
            SourceCodeDS sourceCodeDs = ((SourceCodeDS) AssociatedDataSet);
            DataTable copySourceCodeOrganizations = null;

            IEnumerable<DataRow> query =
                //from sourceCodeDs.SourceCodeOrganization in sourceCodeDs.SourceCodeOrganization.AsEnumerable()
                from sourceCodeOrganization in ((DataTable) sourceCodeDs.SourceCodeOrganization).AsEnumerable()
                where
                    (sourceCodeOrganization.Field<Int32>(
                         sourceCodeDs.SourceCodeOrganization.SourceCodeIDColumn.ColumnName) == grConstant.SourceCodeId)
                where
                    sourceCodeOrganization.RowState == DataRowState.Modified 
                select sourceCodeOrganization;
            
            if(query.Count() > 0)
                copySourceCodeOrganizations = query.CopyToDataTable<DataRow>();
            
            //clear all records from the Hidden column (un-selected)
            sourceCodeDs.SourceCodeOrganization.Where
            (
                row =>
                row.Hidden == false
            ).ToList().ForEach
            (delegate(SourceCodeDS.SourceCodeOrganizationRow row)
                 {
                     sourceCodeDs.SourceCodeOrganization.RemoveSourceCodeOrganizationRow(row);
                 }
            );

            //run the query
            Select();
            
            //may need to add functionality here after the sprocs is executed.
            //use the copy of the modified records to and reset the records
            if (copySourceCodeOrganizations != null)
            {
                //create a query
                query = from copySourceCodeOrganization in copySourceCodeOrganizations.AsEnumerable() 
                        select copySourceCodeOrganization;
                //use the query to loop throught the records
                //update records if they exist in the table
                if (query.Count() > 0)
                    query.ToList().ForEach(delegate(DataRow rowCopy)
                    {
                         sourceCodeDs.SourceCodeOrganization.Where 
                             (
                             row =>
                             row.SourceCodeID == grConstant.SourceCodeId &&
                             row.OrganizationID == Convert.ToInt32(rowCopy[sourceCodeDs.SourceCodeOrganization.OrganizationIDColumn.ColumnName])).ToList().
                             ForEach
                             (delegate(SourceCodeDS.SourceCodeOrganizationRow row)
                               {
                                       row.Hidden = Convert.ToBoolean(rowCopy[sourceCodeDs.SourceCodeOrganization.HiddenColumn.Ordinal]);
                                       row.AcceptChanges();
                                        row.SetModified();
                                       copySourceCodeOrganizations.Rows.Remove(rowCopy); 
                               });
                      });
                    //create a query
                    query = from copySourceCodeOrganization in copySourceCodeOrganizations.AsEnumerable()
                        select copySourceCodeOrganization;
                    //add records not in soucecodelist of organizations back to the table
                    if(query.Count() > 0)
                        query.ToList().ForEach(delegate(DataRow rowCopy)
                        {
                            SourceCodeDS.SourceCodeOrganizationRow sourceCodeOrganizationRow = sourceCodeDs.SourceCodeOrganization.AddSourceCodeOrganizationRow(
                                Convert.ToInt32(rowCopy[sourceCodeDs.SourceCodeOrganization.SourceCodeIDColumn.ColumnName]),
                                Convert.ToInt32(rowCopy[sourceCodeDs.SourceCodeOrganization.OrganizationIDColumn.ColumnName]),
                                Convert.ToDateTime(Convert.ToString(rowCopy[sourceCodeDs.SourceCodeOrganization.LastModifiedColumn.ColumnName])),
                                Convert.ToInt32(rowCopy[sourceCodeDs.SourceCodeOrganization.LastStatEmployeeIDColumn.ColumnName]),
                                Convert.ToInt32(rowCopy[sourceCodeDs.SourceCodeOrganization.AuditLogTypeIDColumn.ColumnName]),
                                Convert.ToString(rowCopy[sourceCodeDs.SourceCodeOrganization.OrganizationNameColumn.ColumnName]),
                                Convert.ToString(rowCopy[sourceCodeDs.SourceCodeOrganization.OrganizationCityColumn.ColumnName]),
                                Convert.ToString(rowCopy[sourceCodeDs.SourceCodeOrganization.StateAbbrvColumn.ColumnName]),
                                Convert.ToString(rowCopy[sourceCodeDs.SourceCodeOrganization.OrganizationTypeColumn.ColumnName]),
                                Convert.ToBoolean(rowCopy[sourceCodeDs.SourceCodeOrganization.HiddenColumn.ColumnName])
                                );
                                sourceCodeOrganizationRow.AcceptChanges();
                                sourceCodeOrganizationRow.SetModified();

                        });

            }
#endregion
        }

        /// <summary>
        /// 1. Add the Organization to the existing SourceCode 
        /// 2. Add the new Organization to SourceCodeOrganization
        /// 3. Save the dataSet
        /// </summary>
        /// <param name="organizationID"></param>
        public void AddOrganizationDefault(int organizationID)
        {
            //Step 1
            _sourceCodeDA.OrganizationID = organizationID;
            _sourceCodeDA.SourceCodeID = grConstant.SourceCodeId;
            if (_sourceCodeDA.SourceCodeID== 0)
                return;
            AssociatedDataSet.Clear();
            SelectDataSet();

            //Step 2
            ((SourceCodeDS)AssociatedDataSet).SourceCodeOrganization.SourceCodeIDColumn.DefaultValue = _sourceCodeDA.SourceCodeID;
            SourceCodeDS.SourceCodeOrganizationRow sourceCodeOrganizationRow = ((SourceCodeDS)AssociatedDataSet).SourceCodeOrganization.NewSourceCodeOrganizationRow();
            sourceCodeOrganizationRow.OrganizationID = organizationID;
            sourceCodeOrganizationRow.Hidden = true;
            ((SourceCodeDS)AssociatedDataSet).SourceCodeOrganization.AddSourceCodeOrganizationRow(sourceCodeOrganizationRow);

            //Step 3
            SaveDataSet();
        }
    }

}
