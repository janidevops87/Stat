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

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsDisplayEventLog : 
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SecurityChecker.CheckAccessToRule(AuthRule.BlockEventLog))
                this.Visible = false;
        }

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {
            if (chkBoxDisplayEventLog.Checked)
                reportParams.Add(
                    ReportParams.DisplayEventLog.ToString(),
                    chkBoxDisplayEventLog.Checked.ToString());

        }

        #endregion
    }
}