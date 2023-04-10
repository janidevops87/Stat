using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI.MasterPages;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for ReportDisplay.
	/// </summary>
	public partial class ReportDisplay : BasePageSecure
	{
		
		public ReportDisplay() : base(PageName.ReportDisplay)
	{
		Title = "Display";


	}
		
	protected void Page_Load(object sender, System.EventArgs e)
	{
		BaseMenuControl.MainMenu = MenuName.Reports;
		BaseMenuControl.SubMenu = MenuName.ReportDisplay;
		RuleName = AuthRule.User;
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
		}
		#endregion
	}
}
