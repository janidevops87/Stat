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
    public partial class QA : BasePage
    {
        public QA() : base(PageName.QA)
        {
            Title = "QA";

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            // the folling code suports added functionality to redirect users based on their access rights
            // if the user does not have access to ReferralUpdate they should not go to the referral search screen
            if (SecurityChecker.CheckAccessToRule(AuthRule.QAQMForm))
                QueryStringManager.Redirect(PageName.QAMonitoring);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAReview))
                QueryStringManager.Redirect(PageName.QAReview);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAPendingReview))
                QueryStringManager.Redirect(PageName.QAPendingReview);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAConfig))
                QueryStringManager.Redirect(PageName.QAConfig);
        }
    }
}
