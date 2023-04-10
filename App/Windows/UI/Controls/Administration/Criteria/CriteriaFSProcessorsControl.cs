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
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;



namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaFSProcessorsControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private CriteriaDS criteriaDS;
        public CriteriaFSProcessorsControl()
        {
            InitializeComponent();
            BindValueList();
        }
        public override void BindDataToUI()
        {
            criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)

                return;

            availableSelectedControl1.DataMember = criteriaDS.CriteriaProcessor.TableName;
            availableSelectedControl1.ColumnList = typeof(CriteriaProcessor);
            availableSelectedControl1.DataSource = criteriaDS;

        }

        [Description("This is used to pass the parameters for searching back to the BR/DA for")]
//        public SearchParameter OrganizationSearchParameter
//        {
//            get { return processorSearchParameter.BRSearchParameter; }
//            set { organizationSearchParameter.BRSearchParameter = value; }
//        }

        //public string IdColumn
        //{
        //    get { return idColumn; }
        //    set { idColumn = value; }
        //}

        private void BindValueList()
        {
            //Hashtable paramList = new Hashtable();
            //paramList.Add("CallTypeGroups", "Referral,OASIS");
            cbStateProvince.BindData("StateListSelect");
            cbOrganizationType.BindData("OrganizationTypeListSelect");
            SetDefaultSelections();
        }
        private void SetDefaultSelections()
        {
            //Set default OrganizationType
            int DefaultOrganizationType = Convert.ToInt32(BaseConfiguration.GetSetting(SettingName.CriteriaProcessorDefaultOrganizationType));
            cbOrganizationType.SelectedValue = DefaultOrganizationType; 
        }

        private void cbStatProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            GRConstant.CriteriaProcessorStateId =  Convert.ToInt32(cbStateProvince.SelectedValue);
        }

        private void cbOrganizationType_SelectedIndexChanged(object sender, EventArgs e)
        {
            GRConstant.CriteriaProcessorTypeId = Convert.ToInt32(cbOrganizationType.SelectedValue);
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            //Fill processor data table(All)
            CriteriaBR criteriaBR = (CriteriaBR)BusinessRule;
            criteriaBR.SearchProcessor();
        }
    }
}
