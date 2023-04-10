using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Question;
using Statline.Stattrac.Data.Types.Question;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionNavigation : Statline.Stattrac.Windows.UI.BaseUserControl
    {
        public QuestionDetailsControl questionDetailsControl;
        private QuestionMultiGroupsControl questionMultiGroupsControl;
        private QuestionGroupsControl questionGroupsControl;
        public QuestionAddEditControl questionAddEditControl;
        public QuestionNavigation()
        {
            InitializeComponent();
            questionDetailsControl = new QuestionDetailsControl();
            questionAddEditControl = new QuestionAddEditControl();
            questionMultiGroupsControl = new QuestionMultiGroupsControl();
            questionGroupsControl = new QuestionGroupsControl();
            
            tabControl.AddTabItem(AppScreenType.QuestionAddEdit, "Add/Edit Questions", questionAddEditControl);
            tabControl.AddTabItem(AppScreenType.QuestionDetails, "Question Details", questionDetailsControl);
            tabControl.AddTabItem(AppScreenType.QuestionMultipleGroups, "Question Multiple Groups", questionMultiGroupsControl);
            tabControl.AddTabItem(AppScreenType.QuestionGroups, "Question Groups", questionGroupsControl);
            tabControl.Tabs[((int)AppScreenType.QuestionDetails).ToString()].Visible = false;
            questionAddEditControl.QuestionNavigation = this;
            BusinessRule = new QuestionDetailBR();
        }

        private void tabControl_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            
        }

        public void DisplayEditDetails()
        {
            tabControl.Tabs[((int)AppScreenType.QuestionDetails).ToString()].Visible = true;
            tabControl.Tabs[((int)AppScreenType.QuestionDetails).ToString()].Selected = true;
        }
    }
}
