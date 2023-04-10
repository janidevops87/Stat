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
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsErrorInfoControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsErrorType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsErrorLocation.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsProcessStep.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            if (Page.Cookies.ReportName.Contains("QAbyError"))
            {
                Label1.Visible = false;
                ddlHowIndentified.Visible = false;
            }
        }
        public void BuildParams(Hashtable parameters)
        {
            if (ddlError.SelectedRow != null)
                parameters.Add(ReportParams.ErrorTypeID, ddlError.SelectedRow.Cells.FromKey("QAErrorTypeID").Value);
            if (ddlErrorLocation.SelectedRow != null)
                parameters.Add(ReportParams.ErrorLocationID, ddlErrorLocation.SelectedRow.Cells.FromKey("QAErrorLocationID").Value);
            if (ddlHowIndentified.SelectedRow != null)
                parameters.Add(ReportParams.HowIdentifiedID, ddlHowIndentified.SelectedRow.Cells.FromKey("QAErrorLogHowIdentifiedID").Value);
            if (ddlProcessStep.SelectedRow != null)
                parameters.Add(ReportParams.ProcessStepID, ddlProcessStep.SelectedRow.Cells.FromKey("QAProcessStepID").Value);
            if (ddlTrackingType.SelectedRow != null)
                parameters.Add(ReportParams.TrackingTypeID, ddlTrackingType.SelectedRow.Cells.FromKey("QATrackingTypeID").Value);
            if (ckboxNoErrors.Checked)
                parameters.Add(ReportParams.ZeroErrors, ckboxNoErrors.Checked);
        }
        protected void ddlHowIndentified_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlHowIndentified.DropDownLayout.BaseTableName = "QAErrorLogHowIdentified";
            ddlHowIndentified.Columns[ddlHowIndentified.Columns.IndexOf("QAErrorLogHowIdentifiedID")].Hidden = true;
        }

        protected void ddlProcessStep_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlProcessStep.DropDownLayout.BaseTableName = "DdlProcessStep";
            ddlProcessStep.Columns[ddlProcessStep.Columns.IndexOf("QAProcessStepID")].Hidden = true;
        }

        protected void ddlError_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlError.DropDownLayout.BaseTableName = "DdlErrorType";
            ddlError.Columns[ddlError.Columns.IndexOf("QAErrorTypeID")].Hidden = true;
        }
        protected void ddlErrorLocation_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlErrorLocation.DropDownLayout.BaseTableName = "QAErrorLocation";
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("QAErrorLocationID")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("OrganizationID")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("QAErrorLocationActive")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("LastModified")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("LastStatEmployeeID")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("AuditLogTypeID")].Hidden = true;
        }

        protected void ddlTrackingType_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            odsErrorType.SelectParameters["QATrackingTypeID"].DefaultValue = ddlTrackingType.SelectedRow.Cells[0].Value.ToString();
        }

        protected void ddlProcessStep_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {

        }

        protected void ddlTrackingType_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlTrackingType.DropDownLayout.BaseTableName = "QATrackingType";
            ddlTrackingType.Columns[ddlTrackingType.Columns.IndexOf("QATrackingTypeID")].Hidden = true;
        }

        protected void odsHowID_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsProcessStep_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsTrackingType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsErrorLocation_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsErrorType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

    }
}