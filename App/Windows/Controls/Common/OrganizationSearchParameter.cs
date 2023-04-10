using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Security;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.Controls.Common
{
    public partial class OrganizationSearchParameter : Statline.Stattrac.Windows.UI.BaseUserControl
    {
        private SecurityHelper securityHelper;
        public SearchParameter BRSearchParameter { get; set; }
        public OrganizationSearchParameter()
        {
            InitializeComponent();
            securityHelper = SecurityHelper.GetInstance();
            
        }
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {
            BindValueList();
        }     
        private void BindValueList()
        {            
            if(cbState.Items.Count == 0)
                cbState.BindData("StateListSelect");
            if(cbOrganizationType.Items.Count == 0)
                cbOrganizationType.BindData("OrganizationTypeListSelect");
            if (cbAdministrationGroup.Items.Count == 0)
                cbAdministrationGroup.BindData("AdministrationGroupListSelect");
            if (cbSourceCode.Items.Count == 0)
                cbSourceCode.BindData("SourceCodeListSelect");
            
            //ccarroll 06/27/2011 wi:12946
            ClearBrParams();
        }
        [Description("Call Method to set the BR searchParameter objects values.")]
        public void SetBrParams()
        {
            //set the values for each of the parameters
            if ((int)cbAdministrationGroup.SelectedValue > 0)
                BRSearchParameter.AdministrationGroupFieldValue = cbAdministrationGroup.Text;
            else
                BRSearchParameter.AdministrationGroupFieldValue = String.Empty;

            BRSearchParameter.SourceCodeId = (int)cbSourceCode.SelectedValue;
            BRSearchParameter.OrganizationName = txtOrganizationName.Text;
            BRSearchParameter.StateId = (int)cbState.SelectedValue;
            BRSearchParameter.OrganizationTypeId = (int)cbOrganizationType.SelectedValue;
            BRSearchParameter.ContractedStatlineClient = (Boolean)(chkContractedStatlineClient.Checked);
            BRSearchParameter.View_Asp_Organizations = securityHelper.Authorized(SecurityRule.View_ASP_Organizations.ToString());
            
        }
        private void ClearBrParams()
        {
            //reset parameters
            if (BRSearchParameter != null)
            {
                BRSearchParameter.AdministrationGroupFieldValue = String.Empty;
                BRSearchParameter.SourceCodeId = GRConstant.DefaultValue;
                BRSearchParameter.OrganizationName = String.Empty;
                BRSearchParameter.StateId = GRConstant.DefaultValue;
                BRSearchParameter.OrganizationTypeId = GRConstant.DefaultValue;
                BRSearchParameter.ContractedStatlineClient = false;
                BRSearchParameter.View_Asp_Organizations = securityHelper.Authorized(SecurityRule.View_ASP_Organizations.ToString());
            }

        }
    }
}
