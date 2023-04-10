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

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionDetailsControl : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        public QuestionDetailsControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionDetailBR();            
        }

        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        protected override void BindDataToUI()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            string tableName = questionDS.Question.TableName;
            cbDisplayNA.BindData("QuestionDisplayNAListSelect");
            cbDisplayComments.BindData("QuestionDisplayCommentListSelect");
            cbIfYes.BindData("QuestionIfYesListSelect");
            cbQuestionCategory.BindData("QuestionCategoryListSelect");
            cbTrackEventLog.BindData("QuestionTrackEventLogListSelect");
            if (GRConstant.QuestionID != 0)
            {
                txtQuestion.BindDataSet(questionDS, tableName, questionDS.Question.QuestionColumn.ColumnName);
                chkInactive.BindDataSet(questionDS, tableName, questionDS.Question.InactiveColumn.ColumnName);
                cbDisplayComments.BindDataSet(questionDS, tableName, questionDS.Question.QuestionDisplayCommentIDColumn.ColumnName);
                cbDisplayNA.BindDataSet(questionDS, tableName, questionDS.Question.QuestionDisplayNAIDColumn.ColumnName);
                cbIfYes.BindDataSet(questionDS, tableName, questionDS.Question.QuestionIfYesIDColumn.ColumnName);
                cbQuestionCategory.BindDataSet(questionDS, tableName, questionDS.Question.QuestionCategoryIDColumn.ColumnName);
                cbTrackEventLog.BindDataSet(questionDS, tableName, questionDS.Question.QuestionTrackEventLogIDColumn.ColumnName);
            }
           
            //QuestionDetailBR questionBR = (QuestionDetailBR)BusinessRule;
            //questionBR.SelectAssociatedQuestions(GRConstant.QuestionID);
            ugAssocQuestions.DataMember = questionDS.QuestionAssociated.TableName;
            ugAssocQuestions.DataSource = questionDS;
            //base.BindDataToUI();
            
        }

        private void cbIfYes_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        
        private void ugAssocGroups_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
        }

        private void ugAssocQuestions_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugAssocQuestions.ColumnDisplay(band, typeof(QuestionDetail), questionDS.QuestionAssociated);
            
        }
        protected override void UpdateParameters()
        {
            ((QuestionDetailBR)BusinessRule).QuesitonID = GRConstant.QuestionID;
        }
    }
}
