using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.RuleOutIndications;
using Statline.Stattrac.DataAccess.RuleOutIndications;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.BusinessRules.RuleOutIndications
{
    public class RuleOutIndicationsBR : BaseBR
    {
        public RuleOutIndicationsBR()
		{
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new RuleOutIndicationsDS();
            AssociatedDA = new RuleOutIndicationsDA(); 
        }
        #region Fields/Properties
        private GeneralConstant grConstant;
        private int indicationID;
        private int questionID;
        private int childQuestionID;

        public int ChildQuestionID
        {
            get { return childQuestionID; }
            set
            {
                childQuestionID = value;
                ((RuleOutIndicationsDA)AssociatedDA).ChildQuestionID = value;
            }
        }

        public int QuesitonID
        {
            get { return questionID; }
            set
            {
                questionID = value;
                ((RuleOutIndicationsDA)AssociatedDA).QuestionID = value;
            }
        }
        public int IndicationID
        {
            get { return indicationID; }
            set
            {
                indicationID = value;
                ((RuleOutIndicationsDA)AssociatedDA).IndicationID = value;
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
                    row[row.Table.Columns["LastStatEmployeeID"].Ordinal] = Statline.Stattrac.Constant.StattracIdentity.Identity.UserId;
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
            RuleOutIndicationsDS ruleOutIndicationsDs = (RuleOutIndicationsDS)AssociatedDataSet;
            SetDefaultValue(ruleOutIndicationsDs.Indication);
            SetDefaultValue(ruleOutIndicationsDs.IndicationResponse);
            SetDefaultValue(ruleOutIndicationsDs.AssociatedCriteriaGroups);
            SetDefaultValue(ruleOutIndicationsDs.Question);
            SetDefaultValue(ruleOutIndicationsDs.IndicationQuestionAssociated);

        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            RuleOutIndicationsDS organizationDS = (RuleOutIndicationsDS)AssociatedDataSet;
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

        public void SelectIndications(int indicationID, int indicationCategoryID, Int16 inactive)
        {
            ((RuleOutIndicationsDA)AssociatedDA).SelectIndication(indicationID);
            Select();
        }

        public void SelectIndicationResponse(Int16 inactive)
        {
            ((RuleOutIndicationsDA)AssociatedDA).SelectIndicationResponse(indicationID);
            Select();
        }

        public void SelectAssociatedCriteriaGroups(Int32 indicationId)
        {
            ((RuleOutIndicationsDA)AssociatedDA).SelectAssociatedCriteriaGroups(indicationId);
            Select();
        }

        public void SelectIndicationAssociatedQuestions(int childQuestionID)
        {
            ((RuleOutIndicationsDA)AssociatedDA).SelectIndicationAssociatedQuestions(childQuestionID);
            Select();

        }

        protected void Select()
        {
            base.Select();
            ((RuleOutIndicationsDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
    }
}
