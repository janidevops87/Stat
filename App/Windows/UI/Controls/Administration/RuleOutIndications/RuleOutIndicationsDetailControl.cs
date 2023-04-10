using System;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.RuleOutIndications;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.RuleOutIndications;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.RuleOutIndications
{
    public partial class RuleOutIndicationsDetailControl : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        //private RuleOutIndicationsDS ruleOutIndicationsDS;
        private CurrencyManager _currencyManager;

        public RuleOutIndicationsDetailControl()
        {
            InitializeComponent();
            BusinessRule = new RuleOutIndicationsBR();
        }

        protected override void BindDataToUI()
        {
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            if (ruleOutIndicationsDS == null)
                return;
            string tableName = ruleOutIndicationsDS.Indication.TableName.ToString();

            cbResponse.BindData("IndicationResponseListSelect");
            if (GRConstant.IndicationId != 0)
            {
                chkInactive.BindDataSet(ruleOutIndicationsDS, tableName, ruleOutIndicationsDS.Indication.InactiveColumn.ColumnName);
                txtRuleOutName.BindDataSet(ruleOutIndicationsDS, tableName, ruleOutIndicationsDS.Indication.IndicationNameColumn.ColumnName);
                cbResponse.BindDataSet(ruleOutIndicationsDS, tableName, ruleOutIndicationsDS.Indication.IndicationResponseIDColumn.ColumnName);

                _currencyManager = (CurrencyManager)BindingContext[ruleOutIndicationsDS, ruleOutIndicationsDS.Indication.TableName];
                _currencyManager.Position = ruleOutIndicationsDS.Indication.Rows.IndexOf(ruleOutIndicationsDS.Indication.FindByIndicationID(Convert.ToInt32(GRConstant.IndicationId)));

            }

            ugAssociatedAdditionalQuestions.DataMember = ruleOutIndicationsDS.IndicationQuestionAssociated.TableName;
            ugAssociatedAdditionalQuestions.DataSource = ruleOutIndicationsDS;

            ugAssociatedCriteriaGroups.DataMember = ruleOutIndicationsDS.AssociatedCriteriaGroups.TableName;
            ugAssociatedCriteriaGroups.DataSource = ruleOutIndicationsDS;

        }

        private void pnlBody_Paint(object sender, PaintEventArgs e)
        {

        }
        protected override void UpdateParameters()
        {
            ((RuleOutIndicationsBR)BusinessRule).IndicationID = GRConstant.IndicationId;
            ((RuleOutIndicationsBR)BusinessRule).ChildQuestionID = GRConstant.ChildQuestionID;
        }

        private void ugAssociatedAdditionalQuestions_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugAssociatedAdditionalQuestions.ColumnDisplay(band, typeof(QuestionDetail), ruleOutIndicationsDS.IndicationQuestionAssociated);

        }

        private void ugAssociatedCriteriaGroups_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
        
        }

        private void ugAssociatedAdditionalQuestions_AfterRowInsert(object sender, RowEventArgs e)
        {
            //TODO: check if QuestionAssociatedID exists in Indications table.
            // if it does not add it. Insert new Question records.
            RuleOutIndicationsDS ruleOutIndicationsDS = (RuleOutIndicationsDS)BusinessRule.AssociatedDataSet;
            if (ruleOutIndicationsDS == null)
                return;

        }

        private void ugAssociatedAdditionalQuestions_AfterRowUpdate(object sender, RowEventArgs e)
        {
            //TODO: update Question and QuestionAssociated DS
        }

        private void cbResponse_SelectionChangeCommitted(object sender, EventArgs e)
        {

        }
    }
}
