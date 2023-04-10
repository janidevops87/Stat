using System.Security;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Report;
using System;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Web.UI;

namespace Statline.Registry.Web.UI.Controls
{

	/// <summary>
	///		Summary description for LoginControl.
	/// </summary>
	public partial class LoginControl  : BaseUserControl
	{


		protected void Page_Load(object sender, System.EventArgs e)
		{
                Page.Form.DefaultFocus = txtUserName.ClientID;
                //this.Visible = !this.Page.User.Identity.IsAuthenticated;
                this.Visible = true;
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
                authenticated = SecurityHelper.Authenticate(txtUserName.Text, txtPassword.Text);
			}
			catch (SecurityException ex)
			{
				DisplayMessages.Add( MessageType.ErrorMessage, ex.Message );
			}

            if (!authenticated)
            {
                Int32 FailedCount;

                if (Session["FailedCount"] != null) FailedCount = (Int32)(Session["FailedCount"]);
                else { FailedCount = 0; }

                FailedCount = (FailedCount + 1);
                Session.Add("FailedCount", FailedCount);

                if (FailedCount > 2)
                {
                    QueryStringManager.Redirect(PageName.LoginFailure);
                }
                return;
            }
            else
            {
                CookieManager.SetUserCookies(txtUserName.Text.ToString(), txtPassword.Text.ToString(), Page.Cookies);
                TicketManager.SetTicket(txtUserName.Text, true);
                TicketManager.SetPrincipal();

                //Check if user has rights for registry access
                if (
                    (SecurityChecker.CheckAccessToRule(AuthRule.Search) == true ) ||
                    (SecurityChecker.CheckAccessToRule(AuthRule.RegistryUpdate) == true) ||
                    (SecurityChecker.CheckAccessToRule(AuthRule.MaintainCategory) == true)
                   )
                {
                    QueryStringManager.RedirectFromLogin();

                }
                else
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "You do not have permission to access this site");
                    TicketManager.DestroyTicket();
                }
            }
		}

        protected void btnReset_Click(object sender, EventArgs e)
        {
            TicketManager.DestroyTicket();
            QueryStringManager.Redirect(PageName.Login);
        }

	}
}
