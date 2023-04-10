using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.ScreenConfig;
using Statline.Stattrac.DataAccess.ScreenConfig;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.BusinessRules.ScreenConfig
{
    public class ScreenConfigBR : BaseBR, IOrganizationSearch
    {
        private ScreenConfigDA screenConfigDA;
        public SearchParameter OrganizationSearchParameter
        {
            get { return screenConfigDA.OrganizationSearchParameter; }
            set { screenConfigDA.OrganizationSearchParameter = value; }
        }
        public ScreenConfigBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new ScreenConfigDS();
            AssociatedDA = new ScreenConfigDA();
            screenConfigDA = (ScreenConfigDA)AssociatedDA;
        }

        public int ScreenID
        {
            get { return screenId; }
            set
            {
                screenId = value;
                AssociatedDA = new ScreenConfigDA(value);
            }
        }

        private int screenId;

        #region Fields/Properties
        private GeneralConstant grConstant;
        //private int questionID;
        //public int QuesitonID
        //{
        //    get { return questionID; }
        //    set
        //    {
        //        questionID = value;
        //        ((QuestionDetailDA)AssociatedDA).QuestionID = value;
        //    }
        //}
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
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)AssociatedDataSet;
            SetDefaultValue(screenConfigDS.ScreenFieldAttribute);
            SetDefaultValue(screenConfigDS.ScreenConfig);
        }
        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)AssociatedDataSet;
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

        //public void SelectQuestions(int questionID, int questionCategoryID, Int16 inactive)
        //{
        //    ((ScreenConfigDA)AssociatedDA).SelectQuestions(questionID, questionCategoryID, inactive);
        //    Select();

        //}

        public void SelectScreen(int screenID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectScreen(screenID);
            Select();

        }

        public void SelectServiceLevel(int serviceLevelID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectServiceLevel(serviceLevelID);
            Select();

        }

        public void SelectSourceCode(int sourceCodeID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectSourceCode(sourceCodeID);
            Select();

        }

        public void SelectVitalSigns(int tcssListVitalSignId)
        {
            ((ScreenConfigDA)AssociatedDA).SelectVitalSigns(tcssListVitalSignId);
            Select();

        }

        public void SelectLabProfile(int tcssListLabId)
        {
            ((ScreenConfigDA)AssociatedDA).SelectLabProfile(tcssListLabId);
            Select();

        }

        public void SelectServiceLevelCustomList(int serviceLevelID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectServiceLevelCustomList(serviceLevelID);
            Select();

        }

        public void SelectServiceLevelCustomField(int serviceLevelID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectServiceLevelCustomField(serviceLevelID);
            Select();

        }

        public void SelectRegistryServiceLevel(int serviceLevelID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectRegistryServiceLevel(serviceLevelID);
            Select();

        }

        public void SelectScreenField(int screenConfigID)
        {
            ((ScreenConfigDA)AssociatedDA).SelectScreenField(screenConfigID);
            Select();

        }
        //protected void Select()
        //{
        //    base.Select();
        //    ((QuestionDetailDA)AssociatedDA).SetDefaultTableSelect();
        //}
        #endregion

        #region IOrganizationSearch Members

        public void SearchOrganization()
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
