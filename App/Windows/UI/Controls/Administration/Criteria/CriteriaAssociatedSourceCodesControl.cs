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
using Statline.Stattrac.BusinessRules.Criteria;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaAssociatedSourceCodesControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {   
        //private RuleOutIndicationsDS ruleOutIndicationsDS;
        private CurrencyManager _currencyManager;
        private CriteriaDS criteriaDS; 

        public CriteriaAssociatedSourceCodesControl()
        {
            InitializeComponent();
            BusinessRule = new CriteriaBR();
            BindValueList();
        }

        public override void BindDataToUI()
        {
            criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;

            ugSourceCodes.DataMember = criteriaDS.CriteriaSourceCode.TableName;
            ugSourceCodes.DataSource = BusinessRule.AssociatedDataSet;
            base.BindDataToUI();

            _currencyManager = (CurrencyManager)BindingContext[criteriaDS, criteriaDS.Criteria.TableName];

        }
        private void BindValueList()
        {
            criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;

            //Hashtable paramList = new Hashtable();
            //paramList.Add("StatEmployeeUserId", StattracIdentity.Identity.UserId);
            //ugSourceCodes.BindValueList("SourceCodeListSelect", criteriaDS.CriteriaSourceCode.SourceCodeIDColumn.ColumnName, criteriaDS.CriteriaSourceCode, criteriaDS.CriteriaSourceCode.SourceCodeNameColumn.ColumnName);
            //paramList.Clear();

        }
        private void ugSourceCodes_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugSourceCodes.ColumnDisplay(band, typeof(CriteriaSourceCode), criteriaDS.CriteriaSourceCode);

        }
    }
}
