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
    public partial class CustomParamsTrackingTypeControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
        }

        protected void ddlTrackingType_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlTrackingType.DropDownLayout.BaseTableName = "QATrackingType";
            ddlTrackingType.Columns[ddlTrackingType.Columns.IndexOf("QATrackingTypeID")].Hidden = true;
        }

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {
            if (ddlTrackingType.SelectedRow != null)
                reportParams.Add(ReportParams.TrackingTypeID, ddlTrackingType.SelectedRow.Cells.FromKey("QATrackingTypeID").Value);
        }

        #endregion

        protected void odsTrackingType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }
    }
}