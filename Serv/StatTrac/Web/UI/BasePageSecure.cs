using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Data.Types;
using Statline.Configuration;

namespace Statline.StatTrac.Web.UI
{

	public class BasePageSecure : BasePage
	{

		public BasePageSecure( PageName pageName ) : base( pageName )
		{
		}
	

		public BasePageSecure()
		{
		}

		protected override bool RequiresAuthentication
		{
			get
			{
				return true;
			}
		}

		private void Page_Init(
			object sender, 
			System.EventArgs e)
		{

			if( this.RequiresAuthentication )
			{
				if(!User.Identity.IsAuthenticated)
				{
					QueryStringManager.RedirectToLogin();
				}
			}
			
			bool user = SecurityChecker.RedirectIfNotAuthorized(this.RuleName);

			if( user &
				QueryStringManager.CurrentPageName != PageName.Maintenance & 
				QueryStringManager.CurrentPageName != PageName.AccessDenied &
				QueryStringManager.CurrentPageName != PageName.GeneralError &
				QueryStringManager.CurrentPageName != PageName.Help 
				)
			{
				if( !ApplicationSettings.GetSettingBool( SettingName.ApplicationEnabled ) )
				{
					QueryStringManager.Redirect( PageName.Maintenance );
				}
			}

		}

		private void Page_Load(
			object sender, 
			System.EventArgs e)
		{

		}

		override protected void OnInit(EventArgs e)
		{
			this.Init += new System.EventHandler(this.Page_Init);
			this.Load += new System.EventHandler( this.Page_Load );

			base.OnInit(e);

		}
		

	}
}