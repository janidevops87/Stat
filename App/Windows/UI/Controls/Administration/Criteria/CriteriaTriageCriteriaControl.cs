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
    public partial class CriteriaTriageCriteriaControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private CriteriaDS criteriaDS;
        private CurrencyManager _currencyManager;
        public CriteriaTriageCriteriaControl()
        {
            InitializeComponent();

        }
                /// <summary>
        /// Bind data to UI
        /// </summary>
        public override void BindDataToUI()
        {
            criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;

            //Rule Out information
            string tableName = criteriaDS.Criteria.TableName.ToString();

            chkInactive.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaMaleNotAppropriateColumn.ColumnName);
            chkDefaultGroupForSourceCode.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFemaleNotAppropriateColumn.ColumnName);
            txtCriteriaGroup.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaGroupNameColumn.ColumnName);

            _currencyManager = (CurrencyManager)BindingContext[criteriaDS, criteriaDS.Criteria.TableName];
        }
    }
}
