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
    public partial class CustomParamsAgeRangeControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void BuildParams(Hashtable parameters)
        {
            if (ddlAgeRange.SelectedRow != null)
                parameters.Add(ReportParams.AgeRange, ddlAgeRange.SelectedRow.Cells.FromKey("Switch").Value);
        }

        protected void ddlAgeRange_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlAgeRange.Columns.FromKey("Switch").Hidden = true;
        }

        protected void odsAgeRange_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }
    }
}