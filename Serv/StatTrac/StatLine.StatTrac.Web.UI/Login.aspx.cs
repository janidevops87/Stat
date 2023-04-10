using System;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.UI.MasterPages;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for Login.
	/// </summary>
	public partial class Login : BasePage
	{
		protected Content loginRegion;

		public Login() : base(PageName.Login)
		{
			BaseMenuControl.MainMenu = MenuName.Root;	
		}		
		protected void Page_Load(object sender, System.EventArgs e)
		{
			this.Title = "Login";
			
			RuleName = AuthRule.None;
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
