using System.Security;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Report;
using System;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls
{

	/// <summary>
	///		Summary description for LoginControl.
	/// </summary>
	public partial class LoginControl  : BaseUserControl
	{


		protected void Page_Load(object sender, System.EventArgs e)
		{
            //set the default focus
            Page.Form.DefaultFocus = txtUserName.ClientID;
			this.Visible = !this.Page.User.Identity.IsAuthenticated;
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

		protected void btnLogin_ServerClick(object sender, System.EventArgs e)
		{
			Page.Validate();

			if(!Page.IsValid)
				return;	
			//page is valid Authenticate
			bool authenticated = false;	
			
			try
			{
				authenticated = SecurityHelper.Authenticate(txtUserName.Text, txtPassword.Text, Page.Cookies);
			}
			catch (SecurityException ex)
			{
				DisplayMessages.Add( MessageType.ErrorMessage, ex.Message );
			}
			
			
			if (!authenticated)
				return;
            // user is authenticated so set the users Cookies
            CookieManager.SetUserCookies(txtUserName.Text.ToString(), txtPassword.Text.ToString(), Page.Cookies);

			TicketManager.SetTicket(txtUserName.Text, true);
			//TicketManager.SetPrincipal();
			QueryStringManager.RedirectFromLogin();
		}

	}
}
