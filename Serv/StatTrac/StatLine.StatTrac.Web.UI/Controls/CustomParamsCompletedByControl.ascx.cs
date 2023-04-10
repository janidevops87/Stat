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
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsCompletedByControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {   //Set Logged in users Default Organization
                    odsCompletedBy.SelectParameters["OrganizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General");
                    throw;
                }
            }
        }
        public void BuildParams(Hashtable parameters)
        {
            if (ddlCompletedBy.SelectedRow != null)
                parameters.Add(ReportParams.CompletedByID, ddlCompletedBy.SelectedRow.Cells.FromKey("PersonID").Value);
        }
        protected void ddlCompletedBy_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlCompletedBy.Columns.FromKey("PersonID").Hidden = true;
        }

        protected void odsCompletedBy_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }
    }
}