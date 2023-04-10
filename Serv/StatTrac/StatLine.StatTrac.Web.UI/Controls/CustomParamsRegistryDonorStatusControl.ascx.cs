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
    public partial class CustomParamsRegistryDonorStatusControl :
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Visible)
                {
                }
            }
        }

        #region IBaseParameters Members
        public void BuildParams(Hashtable reportParams)
        {
            //Add selected value to ReportParams
            if (ddlDonorStatus.SelectedIndex > 0)
            {
                reportParams.Add(ReportParams.DonorStatus, ddlDonorStatus.SelectedValue.ToString());
            }

         }

        #endregion

    }
}