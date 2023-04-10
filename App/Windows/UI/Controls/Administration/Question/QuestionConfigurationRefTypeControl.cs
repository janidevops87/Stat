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

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionConfigurationRefTypeControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public QuestionConfigurationRefTypeControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR(); 
            lblValueYes.Text = "then the question(s) when the Current Appropriate/Acceptable or Consent contains at least one\n";
            lblValueYes.Text = lblValueYes.Text + "Yes for the category selected.  If more than on category is selected, \n";
            lblValueYes.Text = lblValueYes.Text + "all selected categories must contain a Yes to ask the question(s).";
            lblRuledOut.Text = "then display the question(s) when the Current Appropriate/Acceptable or Consent \n";
            lblRuledOut.Text = lblRuledOut.Text + "contains all ruled out reasons for the category selected.";
            
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(QuestionConfigRefType), questionDS.QuestionConfigReferralType);
        }

        public override void BindDataToUI()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;

            questionGroupConfigBR.SelectReferralType(0, GRConstant.QuestionGroupConfigID);
            ultraGrid1.DataMember = questionDS.QuestionConfigReferralType.TableName;
            ultraGrid1.DataSource = questionDS;

        }
    }
}
