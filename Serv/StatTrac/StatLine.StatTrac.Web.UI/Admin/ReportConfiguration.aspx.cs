using System;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI.MasterPages;

namespace Statline.StatTrac.Web.UI.Admin
{
	/// <summary>
	/// Summary description for ReportConfigurataion.
	/// </summary>
	public partial class ReportConfiguration : BasePageSecure
	{

		public ReportConfiguration() : base(PageName.ReportConfiguration)
		{
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			BaseMenuControl.MainMenu = MenuName.Administration;
			BaseMenuControl.SubMenu = MenuName.ReportConfiguration;
			RuleName = AuthRule.Administrator;
		}

		#region Web Form Designer generated code

		protected override void OnInit(EventArgs e)
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