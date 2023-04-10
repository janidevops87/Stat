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

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsGroupByFacilityControl : 
        Statline.StatTrac.Web.UI.BaseUserControl, 
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (Page.Cookies.UserOrgID == 194 && Page.Cookies.ReportDisplayName == "Referral Activity")
            {
                chkBoxGroupByReferralFacility.Text = "Group By Alert Group:";
                chkBoxGroupByReferralFacility.Checked = true;
            }
            else
                chkBoxGroupByReferralFacility.Text = "Group By Referral Facility:"; 

        }

        public void BuildParams(Hashtable parameters)
        {
            //check each of the params 
            //if the check box is not enable grab the value.
            //if the check box is enable assume null and do nothing
            if (chkBoxGroupByReferralFacility.Checked)
               parameters.Add(
                   ReportParams.GroupByReferralFacility.ToString(), 
                   chkBoxGroupByReferralFacility.Checked.ToString());
        }
    }
}