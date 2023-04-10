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
using Statline.StatTrac.Web.UI.Controls;
using Statline.Registry.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;

namespace Statline.StatTac.Web.UI.Controls
{   
    public partial class CustomParamsRegistryStateControl :
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected RegistryCommon dsCommonData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Visible)
                {
                    Int32 RegistryOwnerID = RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
                    BuildControls(RegistryOwnerID);
                }
            }
        }

        #region IBaseParameters Members
        public string SelectedStates()
        {
            //loop through the state list and build the comma seperate string
            string selectedStates = "";
            foreach (ListItem liState in chkBoxListState.Items)
            {
                if (liState.Selected == true)
                {
                    if (selectedStates.Length > 0)
                        selectedStates += ",";
                    selectedStates += liState.Value;
                }
            }
            return selectedStates;
        }
        public void BuildParams(Hashtable reportParams)
        {
            string selectedStates = SelectedStates();
            //if there were states selected add the list to reportParams
            if (selectedStates.Length > 0)
                reportParams.Add(ReportParams.State, selectedStates);

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
                listItem.Selected = true;

                chkBoxListState.Items.Add(listItem);
            }
        }

        #endregion

        protected void chkBoxListState_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}