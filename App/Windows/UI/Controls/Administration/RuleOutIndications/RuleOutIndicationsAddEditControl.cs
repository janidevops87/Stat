using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.RuleOutIndications;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Windows.UI;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.RuleOutIndications;
using Statline.Stattrac.Constant.GridColumns;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.RuleOutIndications
{
    public partial class RuleOutIndicationsAddEditControl : Statline.Stattrac.Windows.UI.BaseGridSearch
    {
        private RuleOutIndicationsNavigation ruleOutIndicationsNavigation;
        public RuleOutIndicationsNavigation RuleOutIndicationsNavigation
        {
            get { return ruleOutIndicationsNavigation; }
            set { ruleOutIndicationsNavigation = value; }
        }
        
        public RuleOutIndicationsAddEditControl()
        {
            InitializeComponent();
            InitializeBR(new RuleOutIndicationsBR());
            BindValueList();
            btnSearch.Visible = false;
        }

        private void BindValueList()
        {
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            ultraGrid.DataMember = ruleOutIndicationsDS.Indication.TableName;
            ultraGrid.DataSource = BusinessRule.AssociatedDataSet;
            base.BindDataToUI();

        }
        protected override void ReloadGrid()
        {
            // create the Business rule object
            RuleOutIndicationsBR ruleOutIndicationsBR = (RuleOutIndicationsBR)BusinessRule;
            //ruleOutIndicationsBR.SelectAssociatedCriteriaGroups(GRConstant.IndicationId);
            RefreshPage();

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                DialogResult result = BaseMessageBox.ShowOkCancel("Are you sure you want to delete this Indication? Press OK to continue");
                if (result == DialogResult.Cancel) return;
                //Delete Row
                ultraGrid.Selected.Rows[0].Delete();

            }

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            if (ruleOutIndicationsDS == null)
                return;
            //ruleOutIndicationsDS.Indication.Indication row = ruleOutIndicationsDS.Indication.NewIndicationRow();
            //ruleOutIndicationsDS.Indication.Rows.Add();
            //_currencyManager.Position = ruleOutIndicationsDS.Indication.Rows.IndexOf(ruleOutIndicationsDS.Indication.NewIndicationRow());

            GRConstant.IndicationId = 0;
            GRConstant.ChildQuestionID = -1;

            RuleOutIndicationsNavigation.DisplayEditDetails();
        }

        private void ultraGrid_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                int questionAssociatedID;

                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                GRConstant.IndicationId = (int)cellsCollection[0].Value; //questionID
                if (cellsCollection[10].Value is DBNull)
                {
                    questionAssociatedID = 0;
                }
                else
                {
                    questionAssociatedID = (int)cellsCollection[10].Value; //questionID
                }

                GRConstant.ChildQuestionID = questionAssociatedID;

            }
            else
            {
                return;
            }

            RuleOutIndicationsNavigation.DisplayEditDetails();
        }

        private void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            if (ruleOutIndicationsDS == null)
                return;
            const int band = 0;
            ultraGrid.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.RuleOutIndications), ruleOutIndicationsDS.Indication);

            FilterInactiveRuleOutIndications();

        }

        private void chkDisplayAllRuleOutIndications_CheckedChanged(object sender, EventArgs e)
        {
            FilterInactiveRuleOutIndications();

        }
        private void FilterInactiveRuleOutIndications()
        {
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            //Clear filter
            ultraGrid.DisplayLayout.Bands[band].ColumnFilters.ClearAllFilters();
            if ((bool)chkDisplayAllRuleOutIndications.Checked == false)
            {
                //Apply filter
                FilterCondition displayAllIndications = new FilterCondition(FilterComparisionOperator.Equals, false);
                ultraGrid.DisplayLayout.Bands[band].ColumnFilters[ruleOutIndicationsDS.Indication.InactiveColumn.ColumnName].
                FilterConditions.Add(displayAllIndications);
            }
        }
    }
}
