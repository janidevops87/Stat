using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Collections;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.Forms;
//using Statline.Stattrac.Data.Types.Criteria;
//using Statline.Stattrac.BusinessRules.Criteria;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaTriageQuestionsControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private CriteriaTriageAssociatedQuestionsControl criteriaTriageAssociatedQuestionsControl;
        private CriteriaTriageQuestionConfigurationControl criteriaTriageQuestionConfigurationControl;

        public CriteriaTriageQuestionsControl()
        {
            InitializeComponent();

            criteriaTriageAssociatedQuestionsControl = new CriteriaTriageAssociatedQuestionsControl();
            criteriaTriageQuestionConfigurationControl = new CriteriaTriageQuestionConfigurationControl();

            tabControl.AddTabItem(AppScreenType.CriteriaTriageAssociatedQuestions, "Associated Questions", criteriaTriageAssociatedQuestionsControl);
            tabControl.AddTabItem(AppScreenType.CriteriaTriageQuestionConfiguration, "Question Configuration", criteriaTriageQuestionConfigurationControl);
        }

    }
}
