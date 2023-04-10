using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Question;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Windows.UI;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Question;
using Statline.Stattrac.Constant.GridColumns;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    
    public partial class QuestionAddEditControl : Statline.Stattrac.Windows.UI.BaseGridSearch
    {
        private QuestionNavigation questionNavigation;
        

        public QuestionNavigation QuestionNavigation
        {
          get { return questionNavigation; }
          set { questionNavigation = value; }
        }
        
        public QuestionAddEditControl()
        {
            InitializeComponent();
            InitializeBR(new QuestionDetailBR());
            BindValueList();
            btnSearch.Visible = false;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                DialogResult result = BaseMessageBox.ShowOkCancel("Are you sure you want to delete this Question? Press OK to continue");
                if (result == DialogResult.Cancel) return;
            }
        }

        private void BindValueList()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            ultraGrid.DataMember = questionDS.Question.TableName;
            ultraGrid.DataSource = BusinessRule.AssociatedDataSet;
            base.BindDataToUI();
        }

        private void ckDisplayAllQuestions_CheckedChanged(object sender, EventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionDetailBR questionBR = (QuestionDetailBR)BusinessRule;
            Windows.Forms.CheckBox checkbox = sender as Windows.Forms.CheckBox;
            if ((bool)checkbox.Checked)
            {
                questionBR.SelectQuestions(1);
            }
            else
            {
                questionBR.SelectQuestions(0);
            }
            ultraGrid.DataMember = questionDS.Question.TableName;
            ultraGrid.DataSource = questionDS;
            base.BindDataToUI();
        }

        private void ultraGrid_DoubleClick(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                GRConstant.QuestionID = (int)cellsCollection[0].Value;
            }
            else
            {
                return;
            }
            QuestionNavigation.DisplayEditDetails();
        }

        private void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid.ColumnDisplay(band, typeof(QuestionAddEdit), questionDS.Question);
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                GRConstant.QuestionID = (int)cellsCollection[0].Value;
            }
            else
            {
                return;
            }
            QuestionNavigation.DisplayEditDetails();
        }

        protected override void ReloadGrid()
        {
            // create the Business rule object
            QuestionDetailBR questionAddEditBR = (QuestionDetailBR)BusinessRule;
            questionAddEditBR.SelectQuestions(0);
            RefreshPage();
            
        }
    }
}
