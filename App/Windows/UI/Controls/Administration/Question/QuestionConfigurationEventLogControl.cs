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
    public partial class QuestionConfigurationEventLogControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public QuestionConfigurationEventLogControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR();
            lblEventTypeText.Text = "Select an event type where the question shall display.\n\n";
            lblEventTypeText.Text = lblEventTypeText.Text + "Display on New Event - should the question display on the New Event screen \n";
            lblEventTypeText.Text = lblEventTypeText.Text + "Display on On Call - should the question display on the On Call screen\n";
            lblEventTypeText.Text = lblEventTypeText.Text + "Schedule Organization and Schedule - Will display only if the specified schedule is selected in the On Call screen";
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(QuestionConfigEventType), questionDS.QuestionConfigEventType);
        }

        public override void BindDataToUI()
        {
            QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;
            
            questionGroupConfigBR.SelectEventLog(0, GRConstant.QuestionGroupConfigID);
            ultraGrid1.DataMember = questionDS.QuestionConfigEventType.TableName;
            ultraGrid1.DataSource = questionDS;

        }
    }
}
