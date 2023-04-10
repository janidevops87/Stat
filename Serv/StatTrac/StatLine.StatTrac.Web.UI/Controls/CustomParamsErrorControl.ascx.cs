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
    public partial class CustomParamsErrorControl : 
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {
            if (txtErrorComputer.Value.Length > 0)
                reportParams.Add(ReportParams.ErrorComputer, txtErrorComputer.Value.ToString());
            if (txtErrorDescription.Value.Length > 0)
                reportParams.Add(ReportParams.ErrorDescription, txtErrorDescription.Value.ToString());
            if (txtErrorSource.Value.Length > 0)
                reportParams.Add(ReportParams.ErrorSource, txtErrorSource.Value.ToString());

        }

        #endregion
    }
}