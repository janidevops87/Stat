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
    public partial class CustomParamsSummarizeByMonthControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void BuildParams(Hashtable reportParams)
        {
            if (chkBoxSummarizeByMonth.Checked)
                reportParams.Add(ReportParams.SummarizeByMonth, chkBoxSummarizeByMonth.Checked);
        }
    }
}