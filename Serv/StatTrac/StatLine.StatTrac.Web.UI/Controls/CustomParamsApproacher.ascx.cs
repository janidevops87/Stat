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
    public partial class CustomParamsApproacher : Statline.StatTrac.Web.UI.BaseUserControl, Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && this.Visible)
                DataBind();

        }
        public override void DataBind()
        {
            Statline.StatTrac.Web.UI.WebControls.DropDownReportGroup localddlReportGroup = (Statline.StatTrac.Web.UI.WebControls.DropDownReportGroup)Parent.FindControl("ddlReportGroup");
            if (localddlReportGroup != null)
                odsApproacherOrganization.SelectParameters["reportGroupID"].DefaultValue = Convert.ToString(localddlReportGroup.SelectedValue.ToString());
            
            //ddlApproacherOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            //ddlApproacherOrganization.Columns.FromKey("OrganizationID").Hidden = true;

            //ddlApproachPerson.DropDownLayout.BaseTableName = "ApproachPersonList";
            //ddlApproachPerson.Columns.FromKey("PersonID").Hidden = true;
            //ddlApproachPerson.Columns.FromKey("PersonTitle").Hidden = true;
            ajaxPanelApproacher.AddRefreshTarget(ddlApproachPerson);
        }
        public void BuildParams(Hashtable parameters)
        {
            if (ddlApproacherOrganization.SelectedRow != null)
                parameters.Add(ReportParams.OrganizationID, ddlApproacherOrganization.SelectedRow.Cells.FromKey("OrganizationID").Value);
            else
                parameters.Add(ReportParams.OrganizationID, Page.Cookies.UserOrgID);
            if (ddlApproachPerson.SelectedRow != null)
                parameters.Add(ReportParams.ApproachPersonID, ddlApproachPerson.SelectedRow.Cells.FromKey("PersonID").Value);
        
        }

        protected void ddlApproacherOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {

            odsApproachPerson.SelectParameters["organizationID"].DefaultValue = ddlApproacherOrganization.SelectedRow.Cells[1].Value.ToString();

        }

        protected void odsApproachPerson_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsApproachPerson.SelectParameters["organizationID"].DefaultValue == "0" || !Visible)
                e.Cancel = true;
        }

       protected void ddlApproacherOrganization_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlApproacherOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlApproacherOrganization.Columns.FromKey("OrganizationID").Hidden = true;

        }

        protected void ddlApproachPerson_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlApproachPerson.DropDownLayout.BaseTableName = "ApproachPersonList";
            ddlApproachPerson.Columns.FromKey("PersonID").Hidden = true;
            ddlApproachPerson.Columns.FromKey("PersonTitle").Hidden = true;
            ddlApproachPerson.Columns.FromKey("Checked").Hidden = true;
        }

        protected void ddlApproachPerson_DataBound(object sender, EventArgs e)
        {
            ddlApproachPerson.DropDownLayout.BaseTableName = "ApproachPersonList";
            ddlApproachPerson.Columns.FromKey("PersonID").Hidden = true;
            ddlApproachPerson.Columns.FromKey("PersonTitle").Hidden = true;
            ddlApproachPerson.Columns.FromKey("Checked").Hidden = true;
        }


    }
}