using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Question;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Question;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionGroupsControl : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        private QuestionAssociatedControl questionAssociatedControl;
        private QuestionConfigurationControl questionConfigurationControl;
        public QuestionGroupsControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR();
            questionAssociatedControl = new QuestionAssociatedControl();
            questionConfigurationControl = new QuestionConfigurationControl();
            tabControl.AddTabItem(AppScreenType.QuestionMultipleGroups, "Associated Questions", questionAssociatedControl);
            tabControl.AddTabItem(AppScreenType.QuestionDetails, "Question Configuration", questionConfigurationControl);
            //change to set properties
            questionConfigurationControl.QuestionGroupsControl = this;
            questionAssociatedControl.QuestionGroupsControl = this;
            chkDisplayAllQuestionGroup.Checked = true;
        }

        protected override void BindDataToUI()
        {
            cbQuestionGroup.BindData("QuestionGroupListSelect");
            cbCallType.BindData("CallTypeListSelect");
            
        }
                
        public string callBackQuestionGroup()
        {
            if (cbQuestionGroup.SelectedValue != null)
            {
                return cbQuestionGroup.SelectedValue.ToString();
            }
            else
            {
                return null;
            }
        }

        public string callBackCKDisplayAll()
        {
           return chkDisplayAllQuestionGroup.Checked.ToString();
        }

        public string callBackCallType()
        {
            if (cbCallType.SelectedValue != null)
            {
                return cbCallType.SelectedValue.ToString();
            }
            else
            {
                return null;
            }
        }

        public void DisplayEditDetails()
        {
            tabControl.Tabs[((int)AppScreenType.QuestionDetails).ToString()].Selected = true;
            questionConfigurationControl.InitializeBR(BusinessRule);
            questionConfigurationControl.BindDataToUI();
        }

        private void cbCallType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbCallType.SelectedIndex < 1 || cbCallType.SelectedItem == null)
                return;
            questionAssociatedControl.BindDataToUI();
        }

        private void cbQuestionGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbQuestionGroup.SelectedIndex < 1 || cbQuestionGroup.SelectedItem == null)
                return;
            questionAssociatedControl.BindDataToUI();
        }

        private void chkDisplayAllQuestionGroup_CheckedChanged(object sender, EventArgs e)
        {
            questionAssociatedControl.BindDataToUI();
        }


        protected override void UpdateParameters()
        {
            ((QuestionGroupConfigBR)BusinessRule).QuestionGroupConfigID = GRConstant.QuestionGroupConfigID;
        }

        private void tabControl_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            if (tabControl.SelectedTab.Text == "Question Configuration")
            {
                chkDisplayAllQuestionGroup.Visible = false;
                cbCallType.Enabled = false;
                cbQuestionGroup.Enabled = false;
            }
            else
            {
                chkDisplayAllQuestionGroup.Visible = true;
                cbCallType.Enabled = true;
                cbQuestionGroup.Enabled = true;
            }
                
        }
    }
}
