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
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI
{
    public partial class Update : BasePage
    {		
        public Update() : base( PageName.Update )
		{
            Title = "Update";

		}
        protected void Page_Load(object sender, EventArgs e)
        {
            //RuleName = AuthRule.Update;
            // the folling code suports added functionality to redirect users based on their access rights
            // if the user does not have access to ReferralUpdate they should not go to the referral search screen
            if (SecurityChecker.CheckAccessToRule(AuthRule.ReferralUpdate))
                QueryStringManager.Redirect(PageName.ReferralSearch);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.ScheduleSearch))
                QueryStringManager.Redirect(PageName.ScheduleSearch);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.ReferralFacilityCompliance))
                QueryStringManager.Redirect(PageName.ReferralFacilityCompliance);
            //else if (SecurityChecker.CheckAccessToRule(AuthRule.QA))
            //    QueryStringManager.Redirect(PageName.QA);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.Update))
                QueryStringManager.Redirect(PageName.ReferralSearch);
        }
    }
}



