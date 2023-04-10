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

namespace Statline.StatTac.Web.UI.Controls
{
    public partial class CustomParamsRegistryDonorDesignationStatus : 
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region IBaseParameters Members
        public void BuildParams(Hashtable reportParams)
        {
            if (chkBoxNewYes.Checked)
                reportParams.Add(
                    ReportParams.NewYes.ToString(),
                    chkBoxNewYes.Checked.ToString());

            if (chkBoxYesToYes.Checked)
                reportParams.Add(
                    ReportParams.YesToYes.ToString(),
                    chkBoxYesToYes.Checked.ToString());

            if (chkBoxNoToYes.Checked)
                reportParams.Add(
                    ReportParams.NoToYes.ToString(),
                    chkBoxNoToYes.Checked.ToString());

            if(chkBoxTotalYes.Enabled = true)
                if (chkBoxTotalYes.Checked)
                    reportParams.Add(
                        ReportParams.TotalYes.ToString(),
                        chkBoxTotalYes.Checked.ToString());

            if (chkBoxYesToNo.Checked)
                reportParams.Add(
                    ReportParams.YesToNo.ToString(),
                    chkBoxYesToNo.Checked.ToString());
        }
        #endregion
    }
}