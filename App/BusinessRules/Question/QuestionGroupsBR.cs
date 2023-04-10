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
    public class QuestionGroupsBR : BaseBR
    {
        public QuestionGroupsBR()
		{
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new QuestionDS();            
            AssociatedDA = new QuestionGroupsDA(); 
        }

        #region Fields/Properties
        private GeneralConstant grConstant;
        private int questionID;
        public int QuesitonID
        {
            get { return questionID; }
            set
            {
                questionID = value;
                ((QuestionGroupsDA)AssociatedDA).QuestionID = value;
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
            SetDefaultValue(questionDs.Question);
            SetDefaultValue(questionDs.QuestionAssociated);
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

        //public void SelectQuestions(int questionID, int questionCategoryID,Int16 inactive)
        //{
        //    ((QuestionGroupsDA)AssociatedDA).SelectQuestions(questionID, questionCategoryID,inactive);
        //    Select();

        //}

        //public void SelectQuestions(Int16 inactive)
        //{
        //    ((QuestionGroupsDA)AssociatedDA).SelectQuestions(inactive);
        //    Select();

        //}

        public void SelectAssociatedQuestions(int questionAssocID)
        {
            ((QuestionGroupsDA)AssociatedDA).SelectAssociatedQuestions(questionAssocID);
            Select();

        }

        public void SelectAssociatedQuestions(int questionAssocID, int questionID, int childQuestionID)
        {
            ((QuestionGroupsDA)AssociatedDA).SelectAssociatedQuestions(questionAssocID, questionID, childQuestionID);
            Select();

        }

        protected void Select()
        {
            base.Select();
            ((QuestionGroupsDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
    }
}
