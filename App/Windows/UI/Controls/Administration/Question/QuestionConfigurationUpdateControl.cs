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
    public partial class QuestionConfigurationUpdateControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public QuestionConfigurationUpdateControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR();
            lblUpdate.Text = "Select an event type where the question shall display.\n\n";
            lblUpdate.Text = lblUpdate.Text + "Schedule Organization and Schedule - Will display only if the specified, \n";
            lblUpdate.Text = lblUpdate.Text + "schedule is selected in the On Call screen.";

        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(QuestionConfigEventTypeUpdate), questionDS.QuestionConfigEventTypeUpdate);
        }

        public override void BindDataToUI()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;

            questionGroupConfigBR.SelectEventUpdate(0, GRConstant.QuestionGroupConfigID);
            ultraGrid1.DataMember = questionDS.QuestionConfigEventTypeUpdate.TableName;
            ultraGrid1.DataSource = questionDS;

        }
    }
}
