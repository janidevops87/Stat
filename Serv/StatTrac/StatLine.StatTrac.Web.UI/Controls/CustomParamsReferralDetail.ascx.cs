using System.Collections;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Statline.StatTrac.Web.UI.Controls
{

	/// <summary>
	///		Summary description for CustomParamsReferralDetail.
	/// </summary>
	public partial class CustomParamsReferralDetail : Statline.StatTrac.Web.UI.BaseUserControl,
		Statline.StatTrac.Web.UI.IBaseParameters
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			
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

		public void BuildParams(Hashtable reportParams)
		{
			if(chkBoxDisplaySecondaryData.Checked)
				reportParams.Add(
					ReportParams.DisplaySecondaryData.ToString(),
					chkBoxDisplaySecondaryData.Checked.ToString());
			if(chkBoxDisplaySecondaryDisposition.Checked)
				reportParams.Add(
					ReportParams.DisplaySecondaryDisposition.ToString(),
					chkBoxDisplaySecondaryDisposition.Checked.ToString());
			if(ddlSortSecondaryData.SelectedValue.Length > 0)
				reportParams.Add(
					ReportParams.SortSecondaryData.ToString(),
					ddlSortSecondaryData.SelectedValue.ToString());
	

		}
	}
}
