using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Question;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.BusinessRules.Question;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionAssociatedControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private QuestionGroupsControl questionGroups;
        //private CurrencyManager _currencyManager;

        public QuestionGroupsControl QuestionGroupsControl
        {
            get { return questionGroups; }
            set { questionGroups = value; }
        }

        public QuestionAssociatedControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR(); 
            BindToValues();
        }
        
        protected void BindToValues()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;
            //questionBR.SelectAssociatedQuestions(GRConstant.QuestionID);
            //txtGroup.BindDataSet(questionDS, "QuestionGroup", questionDS.QuestionGroup.QuestionGroupColumn.ColumnName);
            questionGroupConfigBR.SelectQuestions(0);
            ugQuestionAssoc.DataMember = questionDS.QuestionGroupAssociation.TableName;
            ugQuestionAssoc.DataSource = questionDS;
            
        }
        public override void BindDataToUI()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            string callType = QuestionGroupsControl.callBackCallType();
            string questionGroup = QuestionGroupsControl.callBackQuestionGroup();
            string displayAll = QuestionGroupsControl.callBackCKDisplayAll();
            //When Display all is checked, its actually show all inactive, which is 0)
            ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["CallTypeID"].FilterConditions.Clear();
            ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["QuestionGroupID"].FilterConditions.Clear();
            ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(callType));
            FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            if (displayAll == "False")
            {
                FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
                ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            }
            //else
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["CallTypeID"].FilterConditions.Add(newfilter);
            ugQuestionAssoc.DisplayLayout.Bands[0].ColumnFilters["QuestionGroupID"].FilterConditions.Add(newfilter1);

            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;
            questionGroupConfigBR.SelectQuestionsConfig(Convert.ToInt32(questionGroup),0);
            ugQuestionConfig.DataMember = questionDS.QuestionGroupConfig.TableName;
            ugQuestionConfig.DataSource = questionDS;
            
        }
        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (ugQuestionConfig.Selected.Rows.Count == 1 && ugQuestionConfig.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugQuestionConfig.Selected.Rows[0].Cells;
                GRConstant.QuestionGroupConfigID = (int)cellsCollection["QuestionGroupConfigID"].Value;
            }
            QuestionGroupsControl.DisplayEditDetails();
        }

       
        private void ugQuestionAssoc_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugQuestionAssoc.ColumnDisplay(band, typeof(QuestionGroupConfig), questionDS.QuestionGroupAssociation);
            e.Layout.Bands[0].Columns["Inactive"].Header.VisiblePosition = 0;
            e.Layout.Bands[0].Columns["DisplayOrder"].Header.VisiblePosition = 1;
            //e.Layout.Bands[0].Columns["Screen"].Header.VisiblePosition = 2;
            e.Layout.Bands[0].Columns["Question"].Header.VisiblePosition = 2;
            e.Layout.Bands[0].Columns["Question"].CellActivation = Activation.NoEdit;  
            //e.Layout.Bands[0].Columns["QuestionConfigOnInitialCall"].Header.VisiblePosition = 4;
            //e.Layout.Bands[0].Columns["QuestionConfigOnUpdate"].Header.VisiblePosition = 5;
            //e.Layout.Bands[0].Columns["QuestionConfigAskOnIncomplete"].Header.VisiblePosition = 6;
            //e.Layout.Bands[0].Columns["QuestionConfigAskUntilYes"].Header.VisiblePosition = 7;
            //e.Layout.Bands[0].Columns["QuestionConfigOnTime"].Header.VisiblePosition = 8;
        }


        private void ugQuestionConfig_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugQuestionConfig.ColumnDisplay(band, typeof(QuestionGroupConfig1), questionDS.QuestionGroupConfig);
            //ugQuestionConfig.UltraGridType = UltraGridType.ReadOnly;
            //e.Layout.Bands[0].Columns["Inactive"].Header.VisiblePosition = 0;
            //e.Layout.Bands[0].Columns["DisplayOrder"].Header.VisiblePosition = 1;
            e.Layout.Bands[0].Columns["Screen"].Header.VisiblePosition = 1;
            e.Layout.Bands[0].Columns["Question"].Header.VisiblePosition = 2;
            e.Layout.Bands[0].Columns["QuestionConfigOnInitialCall"].Header.VisiblePosition = 3;
            e.Layout.Bands[0].Columns["QuestionConfigOnUpdate"].Header.VisiblePosition = 4;
            e.Layout.Bands[0].Columns["QuestionConfigAskOnIncomplete"].Header.VisiblePosition = 5;
            e.Layout.Bands[0].Columns["QuestionConfigAskUntilYes"].Header.VisiblePosition = 6;
            e.Layout.Bands[0].Columns["QuestionConfigOnTime"].Header.VisiblePosition = 7;
            //ugQuestionConfig.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            ////e.Layout.ViewStyleBand = ViewStyleBand.OutlookGroupBy;
            //ugQuestionConfig.DisplayLayout.Bands[0].SortedColumns.Band.Columns.Add("Screen");
            //e.Layout.Bands[0].SortedColumns.Band.Columns.Add("Screen");
            //e.Layout.Override.HeaderPlacement = HeaderPlacement.FixedOnTop;       
        }

        private void ugQuestionConfig_DoubleClick(object sender, EventArgs e)
        {
            if (ugQuestionConfig.Selected.Rows.Count == 1 && ugQuestionConfig.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugQuestionConfig.Selected.Rows[0].Cells;
                GRConstant.QuestionGroupConfigID = (int)cellsCollection["QuestionGroupConfigID"].Value;
            }
            else
            {
                return;
            }
            QuestionGroupsControl.DisplayEditDetails();
        }
        

        private void brnAdd1_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtGroup.Text))
            {
                QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
                QuestionDS.QuestionGroupRow row = questionDS.QuestionGroup.NewQuestionGroupRow();
                row.Inactive = (bool)ckInactive.Checked;
                row.DefaultGroupSourceCode = (bool)ckDefaultGroup.Checked;
                row.QuestionGroup = txtGroup.Text;
                questionDS.QuestionGroup.Rows.Add(row);
                //do this?
                ugQuestionAssoc.DataSource = null;
                ugQuestionAssoc.Refresh();
                //ugQuestionAssoc.DataMember = questionDS.QuestionGroup.TableName;
                //ugQuestionAssoc.DataSource = questionDS;
            }
        }
    }
}
