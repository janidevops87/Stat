using System.Collections;

namespace Statline.StatTrac.Web.UI.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	/// <summary>
	///		Summary description for CustomParamsStatTracUserControl.
	/// </summary>
	/// <remarks>
	/// <P>Name: CustomParamsStatTracUserControl </P>
	/// <P>Date Created: 8/25/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Provides the Custom Params for AuditTrail Reports </P>
	/// </remarks> 
	public partial class CustomParamsStatTracUserControl : Statline.StatTrac.Web.UI.BaseUserControl, Statline.StatTrac.Web.UI.IBaseParameters
	{
		
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack && this.Visible)
				DataBind();
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
			ddlStatTracUser.UserOrgID = Page.Cookies.UserOrgID;
			ddlStatTracUser.DataBind();
		}

		public void BuildParams(Hashtable reportParams)
		{
			if(ddlStatTracUser.SelectedItem.Text != "...")
				reportParams.Add(
					ReportParams.User.ToString(), 
					ddlStatTracUser.SelectedValue);

		}
	}
}
