using System;
using System.Collections;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Criteria;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Criteria;
using Statline.Stattrac.Framework;
//using Statline.Stattrac.Windows.Controls.Administration;


namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaEditManager : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        public int CriteriaID { get; set; }
        //private CriteriaTriageCriteriaControl criteriaTriageCriteriaControl;
        private CriteriaRuleOutControl criteriaRuleOutControl;
        private CriteriaTriageQuestionsControl criteriaTriageQuestionsControl;
        private CriteriaFSControl criteriaFSControl;
        //private AssociatedOrganizationsControl associatedOrganizationControl;
        private CriteriaAssociatedSourceCodesControl criteriaAssociatedSourceCodesControl;

        private CurrencyManager _currencyManager;

        public CriteriaEditManager()
        {
            InitializeComponent();

            //criteriaTriageCriteriaControl = new CriteriaTriageCriteriaControl();
            criteriaRuleOutControl = new CriteriaRuleOutControl();
            criteriaTriageQuestionsControl = new CriteriaTriageQuestionsControl();
            //criteriaFSControl = new CriteriaFSControl();
            //associatedOrganizationControl = new AssociatedOrganizationsControl();

            criteriaAssociatedSourceCodesControl = new CriteriaAssociatedSourceCodesControl();


            tabControl.AddTabItem(AppScreenType.CriteriaTriageCriteria, "Triage Criteria", criteriaRuleOutControl); //criteriaTriageCriteriaControl);
            tabControl.AddTabItem(AppScreenType.CriteriaTriageQuestions, "Triage Questions", criteriaTriageQuestionsControl);
            tabControl.AddTabItem(AppScreenType.CriteriaFSCriteria, "Family Services Criteria", criteriaFSControl);
            //tabControl.AddTabItem(AppScreenType.CriteriaAssociatedOrganizations, "Associated Organizations", associatedOrganizationControl);
            tabControl.AddTabItem(AppScreenType.CriteriaAssociatedSourceCodes, "Associated Source Codes", criteriaAssociatedSourceCodesControl);

            BusinessRule = new CriteriaBR();
            BindValueList();

        }
        private void BindValueList()
        {
            Hashtable paramList = new Hashtable();
            string criteriaCallTypeGroup = BaseConfiguration.GetSetting(SettingName.CriteriaCallTypeGroup);

            paramList.Add("CallTypeGroups", criteriaCallTypeGroup);
            cbCallType.BindData("CallTypeGroupListSelect", paramList);
            paramList.Clear();

            paramList.Add("CallTypeID", "-1");
            cbServiceLevel.BindData("ServiceLevelCallTypeListSelect", paramList);
            paramList.Clear();

            cbTriageCategory.BindData("DonorCategoryListSelect");
        }
        protected override void BindDataToUI()
        {
            //BusinessRule = new CriteriaBR();

            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;

            string tableName = criteriaDS.Criteria.TableName;

            cbCriteriaGroup.DisplayMember = criteriaDS.Criteria.CriteriaGroupNameColumn.ColumnName;
            cbCriteriaGroup.ValueMember = criteriaDS.Criteria.CriteriaIDColumn.ColumnName;
            cbCriteriaGroup.DataSource = criteriaDS.Criteria.DefaultView;

            //criteriaTriageCriteriaControl.InitializeBR(BusinessRule);
            //criteriaTriageCriteriaControl.BindDataToUI();

            criteriaRuleOutControl.InitializeBR(BusinessRule);
            criteriaRuleOutControl.BindDataToUI();

            criteriaFSControl.InitializeBR(BusinessRule);
            criteriaFSControl.BindDataToUI();

            criteriaAssociatedSourceCodesControl.InitializeBR(BusinessRule);
            criteriaAssociatedSourceCodesControl.BindDataToUI();

            
            //The following code configures the AssociatedOrganizationControl
            //Before the control can be used the BR needs to implement the IOrganizationSearch Interface
            //and the BR and DA need to implement a SearchParameter
            //1. Initialize
            //2. BindDataToUI
            //3. Set the OrganizationSeachParameter
            //4. Available Selected Visule Column List
            //5. DataTable
            //6. DataSet
            //associatedOrganizationControl.InitializeBR(BusinessRule);
            //associatedOrganizationControl.BindDataToUI();
            //associatedOrganizationControl.OrganizationSearchParameter =
            //    ((CriteriaBR)BusinessRule).OrganizationSearchParameter;
            //associatedOrganizationControl.ColumnList = typeof(CriteriaOrganization);
            //associatedOrganizationControl.DataMember = criteriaDS.CriteriaOrganization.TableName;
            //associatedOrganizationControl.DataSource = criteriaDS;

            _currencyManager = (CurrencyManager)BindingContext[criteriaDS, criteriaDS.Criteria.TableName];
            _currencyManager.Position = criteriaDS.Criteria.Rows.IndexOf(criteriaDS.Criteria.FindByCriteriaID(Convert.ToInt32(cbCriteriaGroup.SelectedValue)));

        }
        private void tab_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {

        }

        private void pnlBody_Paint(object sender, PaintEventArgs e)
        {

        }


        private void CriteriaFilter(CriteriaDS criteriaDS)
        {
            string criteriaFilterString = string.Format("{0} = {1}",
                                                        criteriaDS.Criteria.DonorCategoryIDColumn.ColumnName,
                                                        GRConstant.DonorCategoryId
                                                        );

            criteriaDS.Criteria.DefaultView.RowFilter = criteriaFilterString;
        
        }

        private void cbCallType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbCallType.SelectedIndex > 0)
            {
                Hashtable paramList = new Hashtable();
                paramList.Add("CallTypeID", cbCallType.SelectedValue.ToString());
                cbServiceLevel.BindData("ServiceLevelCallTypeListSelect", paramList);
                paramList.Clear();
            }
        }

        private void cbServiceLevel_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        private void cbTriageCategory_SelectedIndexChanged(object sender, EventArgs e)
        {   
            //Apply Triage Category filter 
            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;
            if (cbTriageCategory.SelectedIndex > 0)
            {
                GRConstant.DonorCategoryId = Convert.ToInt32(cbTriageCategory.SelectedValue);
                CriteriaFilter(criteriaDS);
            }
        }

        private void cbCriteriaGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;
            if (cbCriteriaGroup.SelectedIndex > 0)
            {
                GRConstant.CriteriaId = Convert.ToInt32(cbCriteriaGroup.SelectedValue);

                //_currencyManager.Position = criteriaDS.Criteria.Rows.IndexOf(criteriaDS.Criteria.FindByCriteriaID(GRConstant.CriteriaId));
                criteriaRuleOutControl.PositionCurrencyManager(GRConstant.CriteriaId);
                //criteriaRuleOutControl.Refresh();

                //Update associated sourcecodes
                CriteriaBR criteriaBR = (CriteriaBR)BusinessRule;
                criteriaBR.SelectCriteriaSourceCode(GRConstant.CriteriaId);
                criteriaAssociatedSourceCodesControl.Refresh();
                
            }
        }
    }
}
