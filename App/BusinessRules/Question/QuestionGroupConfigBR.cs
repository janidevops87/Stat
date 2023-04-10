using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Question;
using Statline.Stattrac.DataAccess.Question;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.BusinessRules.Question
{
    public class QuestionGroupConfigBR : BaseBR
    {       
        public QuestionGroupConfigBR()
		{
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new QuestionDS();            
            AssociatedDA = new QuestionGroupsConfigDA(); 
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
            //organizationDS.EnforceConstraints = true;

            AddEmptyRow();

            //modify the OrganizationDisplaySetting to 
            ((QuestionDS)AssociatedDataSet).QuestionGroupConfig
                .ToList().ForEach
            (delegate(QuestionDS.QuestionGroupConfigRow row)
            {
                row.AcceptChanges();
            });

        }
        protected override void BusinessRulesAfterSave()
        {
            SetQuestionGroupConfigID();
        }
        protected override void BusinessRulesBeforeSave()
        {
            //check the state of each table if the data has changed update the lastmodified, logtype and LastStatEmployeeID
            QuestionDS questionDs = (QuestionDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < questionDs.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(questionDs.Tables[forLoop]);
            }

            ////the following statement loops through the QuestionGroupConfig and sets new records to Added
            ((QuestionDS)AssociatedDataSet).QuestionConfigFieldUpdate.Where
                (
                    row => row.QuestionGroupConfigID < 0 && row.Hidden == false
                ).ToList().ForEach
                (delegate(QuestionDS.QuestionConfigFieldUpdateRow row)
                {
                    if (row.QuestionGroupConfigID < 1 && row.RowState == DataRowState.Unchanged)
                        row.SetAdded();
                });
        }

        #endregion
        #region Fields/Properties
        private GeneralConstant grConstant;
        private int questionGroupConfigID;
        public int QuestionGroupConfigID
        {
            get { return questionGroupConfigID; }
            set
            {
                questionGroupConfigID = value;
                ((QuestionGroupsConfigDA)AssociatedDA).QuestionGroupConfigID = value;
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
        private void SetQuestionGroupConfigID()
        {
            QuestionDS questionDS = (QuestionDS)AssociatedDataSet;
            QuestionGroupConfigID = questionDS.QuestionGroupConfig[grConstant.FirstRow].QuestionGroupConfigID;
        }
        private void AddEmptyRow()
        {
            //QuestionDS questionDS = (QuestionDS)AssociatedDataSet;
            //SetDefaultValue(questionDS.Question);
            //if (questionDS.Question.Count == 0)
            //    AddEmptyRow(questionDS.Question);

        }

        /// <summary>
        /// Set the default values on the tables
        /// </summary>
        private void SetDefaultValue()
        {
            QuestionDS questionDs = (QuestionDS)AssociatedDataSet;
            SetDefaultValue(questionDs.QuestionGroupConfig);
            //SetDefaultValue(questionDs.QuestionAssociated);
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            QuestionDS organizationDS = (QuestionDS)AssociatedDataSet;
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

        public void SelectQuestions(int questionGroupConfigID)
        {
            ((QuestionGroupsConfigDA)AssociatedDA).SelectQuestions(questionGroupConfigID);
            Select();

        }

        public void SelectQuestionsConfig(int questionGroupID, int questionGroupConfigID)
        {
            ((QuestionGroupsConfigDA)AssociatedDA).SelectQuestionsConfig(questionGroupID, questionGroupConfigID);
            Select();

        }

        //public void SelectQuestions(Int16 inactive)
        //{
        //    ((QuestionDetailDA)AssociatedDA).SelectQuestions(inactive);
        //    Select();

        //}

        public void SelectAssociatedQuestions(int childQuestionID)
        {
            ((QuestionDetailDA)AssociatedDA).SelectAssociatedQuestions(childQuestionID);
            Select();

        }

        public void SelectScreenFields(int screenID, int questionGroupConfigID)
        {
            ((QuestionGroupsConfigDA)AssociatedDA).SelectScreenFields(screenID, questionGroupConfigID);
            Select();

        }

        public void SelectReferralType(int questionConfigReferralTypeID, int questionGroupConfigID)
        {
            ((QuestionGroupsConfigDA)AssociatedDA).SelectReferralType(questionConfigReferralTypeID, questionGroupConfigID);
            Select();

        }

        public void SelectEventLog(int questionConfigEventTypeID, int questionGroupConfigID)
        {
            ((QuestionGroupsConfigDA)AssociatedDA).SelectEventLog(questionConfigEventTypeID, questionGroupConfigID);
            Select();

        }

        public void SelectEventUpdate(int questionConfigEventTypeUpdateID, int questionGroupConfigID)
        {
            ((QuestionGroupsConfigDA)AssociatedDA).SelectEventUpdate(questionConfigEventTypeUpdateID, questionGroupConfigID);
            Select();

        }

        //protected void Select()
        //{
        //    base.Select();
        //    ((QuestionDetailDA)AssociatedDA).SetDefaultTableSelect();
        //}
        #endregion
    }
}
