using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.Registry.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsRegistryOutreachEvents : 
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected RegistryCommon dsCommonData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && this.Visible)
               
            {
                Int32 RegistryOwnerID = RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
                BuildControls(RegistryOwnerID);
                if (RegistryOwnerID == 2)
                {
                    //CODA Enable SourceCode
                    txtBoxSourceCode.Enabled = true;
                }
                else 
                {
                    txtBoxSourceCode.Enabled = false;
                }
 
                ddlMainCategory.State = radioButtonListState.SelectedValue;
                ddlMainCategory.DataBind();

                ddlSubCategory.State = radioButtonListState.SelectedValue;
                ddlSubCategory.DataBind();

               //ddlMainCategory = new Statline.StatTrac.Web.UI.WebControls.DropDownRegistryMainCategory();
               //ddlSubCategory = new Statline.StatTrac.Web.UI.WebControls.DropDownRegistrySubCategory();
            }

        }
        #region IBaseParameters Members

               
        public void BuildParams(Hashtable reportParams)
        {
            reportParams.Add(ReportParams.State, radioButtonListState.SelectedItem.Value);

            if (ddlMainCategory.SelectedItem.Text != " All")
                reportParams.Add(ReportParams.MainCategoryID, ddlMainCategory.SelectedItem.Value);
            else
                reportParams.Add(ReportParams.MainCategoryID, 0);

            if (ddlSubCategory.SelectedItem.Text != " All")
                reportParams.Add(ReportParams.SubCategoryID, ddlSubCategory.SelectedItem.Value);
            else
                reportParams.Add(ReportParams.SubCategoryID, 0);

            if (txtBoxSourceCode.Text.Length > 0)
                reportParams.Add(ReportParams.SourceCode, txtBoxSourceCode.Text);
        }
        private void BuildControls(Int32 registryOwnerID)
        {
            // Get registry owner states
            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            RegistryCommonManager.GetActiveStatesByOwner(dsCommonData, registryOwnerID, 0);

            // Build state listItem value pair
            for (int i = 0; i < dsCommonData.RegistryOwnerStateConfig.Rows.Count; i++)
            {
                string stateAbbrv = dsCommonData.RegistryOwnerStateConfig[i].RegistryOwnerStateAbbrv.ToString();
                string stateName = dsCommonData.RegistryOwnerStateConfig[i].RegistryOwnerStateName.ToString();
                ListItem listItem = new ListItem();
                listItem.Value = stateAbbrv;
                listItem.Text = stateName;
                if (i == 0) 
                {
                    listItem.Selected = true;
                }

                radioButtonListState.Items.Add(listItem);
            }
        }
        #endregion

        protected void DropDownRegistryMainCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            ddlSubCategory.State = radioButtonListState.SelectedValue;
            ddlSubCategory.EventCategory = Convert.ToInt32(ddlMainCategory.SelectedValue);
            ddlSubCategory.DataBind();

        }

        protected void radioButtonListState_SelectedIndexChanged(object sender, EventArgs e)
        {   
            
            ddlMainCategory.State = radioButtonListState.SelectedValue;
            ddlMainCategory.DataBind();
        }
    }
}