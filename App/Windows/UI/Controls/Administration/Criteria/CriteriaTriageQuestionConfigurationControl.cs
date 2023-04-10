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
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Windows.UI.Controls.Administration.Question;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaTriageQuestionConfigurationControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private CriteriaQuestionTimingControl criteriaQuestionTimingControl;
        private QuestionConfigurationEventLogControl questionConfigurationEventLogControl;
        private QuestionConfigurationRefTypeControl questionConfigRefTypeControl;
        private QuestionConfigurationQuestionControl questionConfigQuestionControl;

        public CriteriaTriageQuestionConfigurationControl()
        {
            InitializeComponent();
            criteriaQuestionTimingControl = new CriteriaQuestionTimingControl();
            questionConfigRefTypeControl = new QuestionConfigurationRefTypeControl();
            questionConfigurationEventLogControl = new QuestionConfigurationEventLogControl();
            questionConfigQuestionControl = new QuestionConfigurationQuestionControl();
            this.baseUserControl1.Controls.Clear();
            this.baseUserControl2.Controls.Clear();
            this.baseUserControl3.Controls.Clear();
            this.baseUserControl4.Controls.Clear();

            this.baseUserControl1.Controls.Add(criteriaQuestionTimingControl);
            this.baseUserControl2.Controls.Add(questionConfigRefTypeControl);
            this.baseUserControl3.Controls.Add(questionConfigurationEventLogControl);
            this.baseUserControl4.Controls.Add(questionConfigQuestionControl);


        }
    }
}
