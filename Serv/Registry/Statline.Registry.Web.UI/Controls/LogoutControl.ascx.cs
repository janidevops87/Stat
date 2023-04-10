using System.Security;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Report;
using System;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Web.UI;
using System.Collections;

namespace Statline.Registry.Web.UI.Controls
{

	/// <summary>
	///		Summary description for LoginControl.
	/// </summary>
	public partial class LogoutControl  : BaseUserControl
	{


		protected void Page_Load(object sender, System.EventArgs e)
		{                
                //this.Visible = !this.Page.User.Identity.IsAuthenticated;
                this.Visible = true;
                Session.RemoveAll();
                Page.Cookies.ClearCookies();
                TicketManager.DestroyTicket();
                QueryStringManager.Redirect(PageName.Login);

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

	}
}
