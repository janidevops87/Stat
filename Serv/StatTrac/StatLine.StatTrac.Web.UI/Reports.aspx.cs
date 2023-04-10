using System;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI.MasterPages;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for Reports.
	/// </summary>
	public partial class Reports : Statline.StatTrac.Web.UI.BasePageSecure
	{
		
		public Reports() : base(PageName.Reports)
		{
			Title = "Reports";

		}
		
		protected void Page_Load(object sender, System.EventArgs e)
		{
			BaseMenuControl.MainMenu = MenuName.Reports;
			BaseMenuControl.SubMenu = MenuName.ReportList;
			
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
