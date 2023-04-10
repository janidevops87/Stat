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
	///		Summary description for CustomParamsCauseOfDeathControl.
	/// </summary>
	public partial class CustomParamsCauseOfDeathControl : Statline.StatTrac.Web.UI.BaseUserControl, 
		Statline.StatTrac.Web.UI.IBaseParameters
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
			ddlCauseOfDeath.DataBind();
		}
		public void BuildParams(Hashtable reportParams)
		{
			if(ddlCauseOfDeath.SelectedItem.Text != "...")
			{
				reportParams.Add(ReportParams.CauseOfDeath.ToString(),
					ddlCauseOfDeath.SelectedValue); 
			}
		}
	}
}
