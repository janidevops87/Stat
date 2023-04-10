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
using Statline.Stattrac.Data.Types.Criteria;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.BusinessRules.Criteria;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaFSControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private CriteriaDS criteriaDS;
        private CriteriaFSProcessorsControl criteriaFSProcessorsControl;
        private CriteriaFSUpdateControl criteriaFSUpdateControl;

        public CriteriaFSControl()
        {
            InitializeComponent();

            criteriaFSProcessorsControl = new CriteriaFSProcessorsControl();
            criteriaFSUpdateControl = new CriteriaFSUpdateControl();

            tabControl.AddTabItem(AppScreenType.CriteriaFSProcessors, "Processors", criteriaFSProcessorsControl);
            tabControl.AddTabItem(AppScreenType.CriteriaUpdateCriteriaAndQuestions, "Update Criteria and Questions", criteriaFSUpdateControl);

            BusinessRule = new CriteriaBR();

         }

        public override void BindDataToUI()
        {
            criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;

            criteriaFSProcessorsControl.InitializeBR(BusinessRule);
            criteriaFSProcessorsControl.BindDataToUI();

            //_currencyManager = (CurrencyManager)BindingContext[criteriaDS, criteriaDS.Criteria.TableName];
        }
    }
}
