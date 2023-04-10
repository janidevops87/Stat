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
using Statline.StatTrac.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsPendingReferralTypeControl : BaseUserControlSecure,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected DropDownReportGroup localddlReportGroup;
        //protected Infragistics.WebUI.Misc.WebAsyncRefreshPanel localajaxPanelRefType;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Visible)
                return;
            localddlReportGroup = (DropDownReportGroup)Parent.FindControl("ddlReportGroup");
            if (localddlReportGroup != null)
            {
                //ddlPendingReferralType.Items.Clear();
                ddlPendingReferralType.AutoPostBack = true;
                //ddlPendingReferralType.DataBind();
                localddlReportGroup.SelectedIndexChanged += new EventHandler(localddlReportGroup_SelectedIndexChanged);
                //odsPendingReferralType.SelectParameters["reportGroupID"].DefaultValue = localddlReportGroup.SelectedValue;
                //odsPendingReferralType.DataBind();
                
            }
            //localajaxPanelRefType = (Infragistics.WebUI.Misc.WebAsyncRefreshPanel)this.FindControl("ajaxPanelPendingReferralType");
            //localajaxPanelRefType.RefreshTargetIDs = "331";
            //localajaxPanelReportGroup.RefreshTargetIDs = ajaxPanelPendingReferralType.ID.ToString();
            ddlPendingReferralType.Items.Clear();
            //ddlPendingReferralType.DataBind();
            odsPendingReferralType.SelectParameters["reportGroupID"].DefaultValue = null;
            odsPendingReferralType.SelectParameters["reportGroupID"].DefaultValue = localddlReportGroup.SelectedValue;
            //odsPendingReferralType.Select();
            //odsPendingReferralType.DataBind();
            //ddlPendingReferralType.DataBind();
                //DataBind();
        }

        public void BuildParams(Hashtable reportParams)
        {
            if (ddlPendingReferralType.SelectedItem.Text != "- All -")
            {
                reportParams.Add(ReportParams.ReferralType.ToString(),
                    ddlPendingReferralType.SelectedValue);
            }
            //if (ddlPendingReferralType.SelectedRow != null)
            //    if (ddlPendingReferralType.SelectedRow.Cells.FromKey("ReferralTypeName").Text != "- All -")
            //    {
            //        {
            //            reportParams.Add(ReportParams.ReferralType, ddlPendingReferralType.SelectedRow.Cells.FromKey("ReferralTypeID").Value);
            //        }
            //    }
            //else
            //    //For this only control '- All -' is the default instead of '...', so when nothing selected set to null in this case
            //    reportParams.Add(ReportParams.ReferralType, null);
        }

        protected void odsPendingReferralType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }
        protected void localddlReportGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlPendingReferralType.DataBind();
            ////ddlPendingReferralTypeDataBind();
        }
        private void ddlPendingReferralTypeDataBind()
        {
            //if (localddlReportGroup != null)
            //    odsPendingReferralType.SelectParameters["reportGroupID"].DefaultValue = localddlReportGroup.SelectedValue;
            //odsPendingReferralType.SelectParameters["reportGroupID"].DefaultValue = localddlReportGroup.SelectedValue;
            //odsPendingReferralType.DataBind();
            //ddlPendingReferralType.DataBind();
            //ddlPendingReferralType.DataValueField = "ReferralTypeID";
            //ddlPendingReferralType.DataTextField = "ReferralTypeName";
            //ReportReferenceData ds = new ReportReferenceData();

            //try
            //{
            //    ds.ReferralType.Clear();
            //    Report.ReportReferenceManager.FillReportPendingReferralType(
            //    ds,
            //    Convert.ToInt32(localddlReportGroup.SelectedValue)
            //    );
            //}
            //catch
            //{
            //    throw;
            //}

            //DataView dataView =
            //    new DataView(ds.ReferralType);

            ////dataView.Sort = this.DataTextField;
           
            //ddlPendingReferralType.DataSource = dataView;
            //ddlPendingReferralType.DataMember = "ReferralType";
            ////ddlPendingReferralType.Items.Clear();
            //ddlPendingReferralType.DataBind();
        }

        protected void odsPendingReferralType_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {

        }

        protected void odsPendingReferralType_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {

        }

        protected void odsPendingReferralType_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {

        }

        protected void odsPendingReferralType_DataBinding(object sender, EventArgs e)
        {

        }
    }
}