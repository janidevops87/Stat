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

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaFSUpdateControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private CriteriaFSUpdateCriteriaControl criteriaFSUpdateCriteriaControl;
        private CriteriaFSUpdateQuestionsControl criteriaFSUpdateQuestionsControl;

        public CriteriaFSUpdateControl()
        {
            InitializeComponent();
            criteriaFSUpdateCriteriaControl = new CriteriaFSUpdateCriteriaControl();
            criteriaFSUpdateQuestionsControl = new CriteriaFSUpdateQuestionsControl();

            tabControl.AddTabItem(AppScreenType.CriteriaFSModifyCriteria, "Modify FS Criteria", criteriaFSUpdateCriteriaControl);
            tabControl.AddTabItem(AppScreenType.CriteriaFSQuestions, "Family Services Questions", criteriaFSUpdateQuestionsControl);

        }

        private void CriteriaFSUpdateControl_Load(object sender, EventArgs e)
        {

        }
    }
}
