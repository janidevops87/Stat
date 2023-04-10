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
using Statline.StatTrac.Web.UI;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;


namespace Statline.Registry.Web.UI.Controls
{
    public partial class RegistryStatisticsReport : BaseUserControlSecure
    {
        Int32 RegistryOwnerID;
        protected RegistryCommon dsCommonData;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack) 
            {
                if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
                else { SetSession(); } 

                odsRegistryStatisticsReport.SelectParameters[0].DefaultValue =  GetStateSelection();
                odsRegistryStatisticsReport.DataBind();
            }
        }

        private String GetStateSelection()
        {
            // Set active state selection
            String StateSelection = "";

            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            RegistryCommonManager.GetActiveStatesByOwner(dsCommonData, RegistryOwnerID, 0);
            
            // Build active state string
            for (int i = 0; i < dsCommonData.RegistryOwnerStateConfig.Rows.Count; i++)
            {
                string stateAbbrv = dsCommonData.RegistryOwnerStateConfig[i].RegistryOwnerStateAbbrv.ToString();
                StateSelection = StateSelection + stateAbbrv;
                if (i != dsCommonData.RegistryOwnerStateConfig.Rows.Count)
                {
                    StateSelection = StateSelection + ",";
                }
            }
            return StateSelection;
        }

        protected void odsRegistryStatisticsReport_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {

        }
        public void SetSession()
        {
            RegistryOwnerID = RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
            Session.Add("RegistryOwnerID", RegistryOwnerID.ToString());
        }

    }
}