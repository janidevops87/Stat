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
    public partial class CustomParamsRegistryGroupByControl : 
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {
            if (radioButtonReportFormat.Items[0].Selected)
                 reportParams.Add(
                    ReportParams.ReportFormat.ToString(),
                    "Standard");

             if (radioButtonReportFormat.Items[1].Selected)
             {
                 if (chkBoxGroupByAge.Checked == true && chkBoxGroupByGender.Checked == true)
                     reportParams.Add(
                         ReportParams.ReportFormat.ToString(),
                         "AgeGender");

                 if (chkBoxGroupByAge.Checked == true && chkBoxGroupByGender.Checked == false)
                     reportParams.Add(
                     ReportParams.ReportFormat.ToString(),
                     "Age");

                 if (chkBoxGroupByAge.Checked == false && chkBoxGroupByGender.Checked == true)
                     reportParams.Add(
                     ReportParams.ReportFormat.ToString(),
                     "Gender");
             }
        }

        #endregion


        protected void raidoButtonReportFormat_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (radioButtonReportFormat.Items[0].Selected)
            {
                chkBoxGroupByAge.Checked = false;
                chkBoxGroupByGender.Checked = false;
            }
            else
            {
                chkBoxGroupByAge.Checked = true;
                chkBoxGroupByGender.Checked = true;
            }
        }


    
    }
}