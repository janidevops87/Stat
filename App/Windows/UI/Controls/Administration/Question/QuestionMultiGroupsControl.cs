using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Question;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.BusinessRules.Question;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionMultiGroupsControl : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        public QuestionMultiGroupsControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR();
        }

        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        protected override void BindDataToUI()
        {
            //fix this to only select adm groups
            cbAdmGroup.BindData("QuestionGroupListSelect");
            cbCallType.BindData("CallTypeListSelect");
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;
            //questionBR.SelectAssociatedQuestions(GRConstant.QuestionID);
            questionGroupConfigBR.SelectQuestionsConfig(1,1);
            ugAssocQuestions.DataMember = questionDS.QuestionGroupConfig.TableName;
            ugAssocQuestions.DataSource = questionDS;
           
        }

        private void btnSearch_Click(object sender, System.EventArgs e)
        {
            
            

            ugAssocQuestions.DisplayLayout.Bands[0].ColumnFilters["CallTypeID"].FilterConditions.Clear();
            ugAssocQuestions.DisplayLayout.Bands[0].ColumnFilters["QuestionGroupID"].FilterConditions.Clear();
            //ugAssocQuestions.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, (int)(cbCallType.SelectedValue));
            FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)(cbAdmGroup.SelectedValue));
            
            ugAssocQuestions.DisplayLayout.Bands[0].ColumnFilters["CallTypeID"].FilterConditions.Add(newfilter);
            ugAssocQuestions.DisplayLayout.Bands[0].ColumnFilters["QuestionGroupID"].FilterConditions.Add(newfilter1);
            //QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
        }

        private void ugMultiGroups_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {

        }

        private void ugAssocQuestions_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            //QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            //const int band = 0;
            //ugAssocQuestions.ColumnDisplay(band, typeof(QuestionMulti), questionDS.QuestionAssociated);
            //ugAssocQuestions.DisplayLayout.Bands[0].Columns.Add("CHECK", "");
            //ugAssocQuestions.DisplayLayout.Bands[0].Columns["CHECK"].DataType = typeof(bool);
            //ugAssocQuestions.DisplayLayout.Bands[0].Columns["CHECK"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.CheckBox;
            //e.Layout.Bands[0].Columns["Check"].Header.VisiblePosition = 0;
            //ugAssocQuestions.DisplayLayout.Bands[0].Columns.Add("QuestionAskCallerID", "Ask on Initial");
            ////ugAssocQuestions.DisplayLayout.Bands[0].Columns["CHECK"].DataType = typeof(bool);

            //ugAssocQuestions.DisplayLayout.Bands[0].Columns["QuestionAskCallerID"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            //ListControlBR listControlBR = new ListControlBR("QuestionAskCallerListSelect");
            //ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
            //ValueList valueList = new ValueList();
            //// Bind the value list for ListFsbStatusId 
            //listControlBR = new ListControlBR("QuestionAskCallerListSelect");
            //listControlDS = (ListControlDS)listControlBR.SelectDataSet();
            //valueList = new ValueList();
            //foreach (ListControlDS.ListControlRow listControlRow in listControlDS.ListControl)
            //{
            //    valueList.ValueListItems.Add(listControlRow.ListId, listControlRow.FieldValue);
            //}
            //e.Layout.Bands[0].Columns["QuestionAskCallerID"].ValueList = valueList;
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugAssocQuestions.ColumnDisplay(band, typeof(QuestionGroupConfig), questionDS.QuestionGroupConfig);
            e.Layout.Bands[0].Columns["Inactive"].Header.VisiblePosition = 0;
            e.Layout.Bands[0].Columns["DisplayOrder"].Header.VisiblePosition = 1;
            e.Layout.Bands[0].Columns["Screen"].Header.VisiblePosition = 2;
            e.Layout.Bands[0].Columns["Question"].Header.VisiblePosition = 3;
            e.Layout.Bands[0].Columns["QuestionConfigOnInitialCall"].Header.VisiblePosition = 4;
            e.Layout.Bands[0].Columns["QuestionConfigOnUpdate"].Header.VisiblePosition = 5;
            e.Layout.Bands[0].Columns["QuestionConfigAskOnIncomplete"].Header.VisiblePosition = 6;
            e.Layout.Bands[0].Columns["QuestionConfigAskUntilYes"].Header.VisiblePosition = 7;
            e.Layout.Bands[0].Columns["QuestionConfigOnTime"].Header.VisiblePosition = 8;
        }

        private void btnReset_Click(object sender, System.EventArgs e)
        {
            for (int i = 0; i < ugAssocQuestions.DisplayLayout.Rows.Count; i++)
            {
                ugAssocQuestions.Rows[i].Cells["Inactive"].Value = false;
            }
        }

        private void btnApplyQuestion_Click(object sender, System.EventArgs e)
        {
            for (int i = 0; i < ugAssocQuestions.DisplayLayout.Rows.Count; i++)
            {
                if (ugAssocQuestions.Rows[i].Cells["Inactive"].Text == "True")
                {
                    //assign associated questionid or questionid to a dataset?
                }
            }
        }
    }
}
