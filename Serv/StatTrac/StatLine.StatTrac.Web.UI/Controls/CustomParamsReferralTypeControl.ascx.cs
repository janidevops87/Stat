using System.Collections;

namespace Statline.StatTrac.Web.UI.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.UI.WebControls;

	/// <summary>
	///		Summary description for CustomParamsReferralTypeControl.
	/// </summary>
	public partial class CustomParamsReferralTypeControl : Statline.StatTrac.Web.UI.BaseUserControl, 
		Statline.StatTrac.Web.UI.IBaseParameters
	{

        protected DropDownReportSourceCode localddlSourceCode;
        protected DropDownReportGroup localddlReportGroup;
        protected Infragistics.WebUI.Misc.WebAsyncRefreshPanel localajaxPanelCooridnatorOrganizationGroup;
		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!Visible)
                return;
            localddlSourceCode = (DropDownReportSourceCode)Parent.FindControl( "ddlSourceCode");
            if (localddlSourceCode != null)
            {
                localddlSourceCode.AutoPostBack = true;
                localddlSourceCode.SelectedIndexChanged += new EventHandler(localddlSourceCode_SelectedIndexChanged);
            }

            localddlReportGroup = (DropDownReportGroup)Parent.FindControl("ddlReportGroup");
            if (localddlReportGroup != null)
            {
                localddlReportGroup.AutoPostBack = true;
                localddlReportGroup.SelectedIndexChanged += new EventHandler(localddlReportGroup_SelectedIndexChanged);
            }
            
            localajaxPanelCooridnatorOrganizationGroup = (Infragistics.WebUI.Misc.WebAsyncRefreshPanel)Parent.FindControl("ajaxPanelCooridnatorOrganizationGroup");
            localajaxPanelCooridnatorOrganizationGroup.RefreshTargetIDs = ajaxPanelReferralType.ID.ToString();
            //ajaxPanelReferralType.RefreshTargetIDs = "localajaxPanelCooridnatorOrganizationGroup";
            // localajaxPanelCooridnatorOrganizationGroup.RefreshTargetIDs = "localajaxPanelCooridnatorOrganizationGroup";
			if(!IsPostBack && this.Visible)
				DataBind();
            if (Page.Cookies.ReportID == 220)
            {
                this.lblReferralType.Text = "Pending Referral Type:";
            }
            else
            {
                this.lblReferralType.Text = "Referral Type:";
            }

		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion

		public override void DataBind()
		{
            ddlReferralTypeDataBind();
            

		}

        private void ddlReferralTypeDataBind()
        {
            if (localddlReportGroup != null)
                ddlReferralType.ReportGroupID = Convert.ToInt32(localddlReportGroup.SelectedValue);            
            if (localddlSourceCode != null)
                ddlReferralType.SourceCodeID = Convert.ToInt32(localddlSourceCode.SelectedValue);

            ddlReferralType.DataBind();
            if (Page.Cookies.ReportName.IndexOf("PendingReferrals") > 0)
            {
                ddlReferralType.Items.Remove(ddlReferralType.Items.FindByText("..."));
            }
        }

		public void BuildParams(Hashtable reportParams)
		{
			if(ddlReferralType.SelectedItem.Text != "...")
			{
				reportParams.Add(ReportParams.ReferralType.ToString(),
					ddlReferralType.SelectedValue);
			}
		}
        protected void localddlReportGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlReferralTypeDataBind();
        }
        protected void localddlSourceCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlReferralTypeDataBind();
            
        }

	}
}
