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
using Statline.StatTrac.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsAlertsControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected DropDownReportSourceCode localddlSourceCode;
        protected void Page_Load(object sender, EventArgs e)
        {       
            if (!Visible)
                return;
            localddlSourceCode = (DropDownReportSourceCode)Parent.FindControl("ddlSourceCode");
            if (localddlSourceCode != null)
            {
                localddlSourceCode.AutoPostBack = true;
                localddlSourceCode.SelectedIndexChanged += new EventHandler(localddlSourceCode_SelectedIndexChanged);
            }

            if (IsPostBack)
                return;
            if (Page.Cookies.UserOrgID != ConstHelper.STATLINEORGANIZATIONID)
                divAlertGroup_Visible(false);

            //add controls outside of the refresh panel that trigger a refresh
            ajaxPanelAlert.AddLinkedRequestTrigger(localddlSourceCode);
            ajaxPanelAlert.AddLinkedRequestTrigger(ddlAlertType);

            ddlAlertGroup_Load();
        }

        #region IBaseParameters Members
        protected void divAlertGroup_Visible(bool visible)
        {
            divAlertGroup.Visible = visible;
            ddlAlertGroup.Visible = visible;
        }
        public void BuildParams(Hashtable reportParams)
        {
            if(ddlAlertType.SelectedItem.Text != "...")
                reportParams.Add(ReportParams.AlertTypeID, ddlAlertType.SelectedValue);
            if (ddlAlertGroup.SelectedRow != null)
                reportParams.Add(ReportParams.AlertID, ddlAlertGroup.SelectedRow.Cells[0]);

        }

        #endregion

        protected void ddlAlertGroup_Load()
        {
            odsAlertGroup.SelectParameters["alertTypeId"].DefaultValue = ddlAlertType.SelectedValue.ToString();
            if (localddlSourceCode != null)
                if(localddlSourceCode.SelectedItem != null)
                    odsAlertGroup.SelectParameters["sourceCodeName"].DefaultValue = localddlSourceCode.SelectedItem.ToString();
        }
        protected void odsAlertGroup_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (Page.Cookies.UserOrgID != ConstHelper.STATLINEORGANIZATIONID || !Visible || ddlAlertGroup == null)
                e.Cancel = true;                
        }
        protected void odsAlertGroup_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
            ddlAlertGroup.DisplayValue = "...";
        }
        protected void ddlAlertType_SelectedIndexChanged(object sender, EventArgs e)
        {
            odsAlertGroup.DataBind();
        }
        protected void localddlSourceCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAlertGroup.Rows.ColumnFilters.Clear();
            ddlAlertGroup.Rows.Clear();

            odsAlertGroup.SelectParameters["sourceCodeName"].DefaultValue = localddlSourceCode.SelectedItem.ToString();
        }
        private void ddlAlertGroupHideColumns()
        {
            ddlAlertGroup.Columns[ddlAlertGroup.Columns.IndexOf("AlertID")].Hidden = true;
        }
    }
}