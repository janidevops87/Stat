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
    public partial class QAConfig : BasePage
    {
        public QAConfig() : base(PageName.QAConfig)
		{
            Title = "QA Config";

		}
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SecurityChecker.CheckAccessToRule(AuthRule.QAConfig))
                QueryStringManager.Redirect(PageName.QAManageQualityMonitoringForms);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAConfig))
                QueryStringManager.Redirect(PageName.QAManageErrorLocation);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAConfig))
                QueryStringManager.Redirect(PageName.QAManageProcessSteps);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAConfig))
                QueryStringManager.Redirect(PageName.QAManageErrorTypes);
            else if (SecurityChecker.CheckAccessToRule(AuthRule.QAConfig))
                QueryStringManager.Redirect(PageName.QAManageErrorList);

        }
    }
}
