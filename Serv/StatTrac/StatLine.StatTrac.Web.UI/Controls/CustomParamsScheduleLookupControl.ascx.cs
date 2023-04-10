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
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsScheduleLookupControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Visible || IsPostBack)
                return;
            odsScheduleGroup.SelectParameters["orgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsScheduleOrganization.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            
        }

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {
            if (ddlScheduleGroup.SelectedRow != null)
                reportParams.Add(ReportParams.ScheduleGroup, ddlScheduleGroup.SelectedRow.Cells.FromKey("ScheduleGroupID").Value.ToString());
            if (ddlScheduleOrganization.SelectedRow != null)
                reportParams.Add(ReportParams.ScheduleOrganization, ddlScheduleOrganization.SelectedRow.Cells.FromKey("OrganizationID").Value.ToString());

        }

        #endregion

        protected void ddlScheduleOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            odsScheduleGroup.SelectParameters["orgId"].DefaultValue = ddlScheduleOrganization.SelectedRow.Cells.FromKey("OrganizationID").Value.ToString();
        }

        protected void odsScheduleGroup_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsScheduleGroup.SelectParameters["orgID"].DefaultValue == null || !Visible)
                e.Cancel = true;
        }

        protected void odsScheduleGroup_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsScheduleOrganization_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsScheduleOrganization.SelectParameters["userOrgID"].DefaultValue == null || !Visible)
                e.Cancel = true;
        }

        protected void odsScheduleOrganization_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

        }

        protected void ddlScheduleOrganization_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            if (ddlScheduleOrganization.Columns.FromKey("OrganizationID") == null)
                return;
                ddlScheduleOrganization.Columns.FromKey("OrganizationID").Hidden = true;
                ddlScheduleOrganization.Columns.FromKey("OrganizationName").Width = 290;
        }

        protected void ddlScheduleGroup_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            if (ddlScheduleGroup.Columns.FromKey("ScheduleGroupID") == null)
                return;
            ddlScheduleGroup.Columns.FromKey("ScheduleGroupID").Hidden = true;
            ddlScheduleGroup.Columns.FromKey("ScheduleGroupName").Width = 290;
        }

        protected void ddlScheduleOrganization_DataBound(object sender, EventArgs e)
        {
            //set the dropdown with first value in list 
            ddlScheduleOrganization.SelectedIndex = 0;
            
        }

        protected void ddlScheduleGroup_DataBound(object sender, EventArgs e)
        {
            //set the dropdown with first value in list 
            ddlScheduleGroup.SelectedIndex = 0;
        }
    }
}