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
    public partial class QuestionConfigurationQuestionControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public QuestionConfigurationQuestionControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR();
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(QuestionConfigQuestion), questionDS.QuestionGroupAssociation);
        }

        public override void BindDataToUI()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;

            questionGroupConfigBR.SelectQuestions(GRConstant.QuestionGroupConfigID);
            ultraGrid1.DataMember = questionDS.QuestionGroupAssociation.TableName;
            ultraGrid1.DataSource = questionDS;

        }
    }
}
