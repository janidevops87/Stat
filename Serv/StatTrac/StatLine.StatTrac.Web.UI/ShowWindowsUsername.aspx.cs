using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Security.Principal;
using System.Threading;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Configuration;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for ShowWindowsUsername.
	/// </summary>
	public partial class ShowWindowsUsername : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			this.ShowD1();
		}

		private void ShowD1()
		{

			HttpContext current = HttpContext.Current;
			WindowsIdentity wi = (WindowsIdentity)current.User.Identity;
			WindowsPrincipal wp = new WindowsPrincipal(wi);
            
			//bool wpAdmin = wp.IsInRole(WindowsBuiltInRole.Administrator);
			bool fsbRole = false;



			bool roleValidated = false;

			string userRole = ConfigurationSettings.AppSettings[ "UserRole" ];
			string[] userRoleArray = userRole.Split( new char[] { ',' } );

			foreach( string role in userRoleArray )
			{
				roleValidated =  wp.IsInRole( role );
				Response.Write(string.Format("role: {0} IsIn: {1}<br>", role.ToString(), wp.IsInRole( role )));		
				if( roleValidated )
					fsbRole =  true;
			}
			Response.Write( string.Format( @"Doggy\Family Services Board = {0}<BR>", fsbRole ) ); 

			Response.Write( string.Format( @"Username = {0}<br>", wp.Identity.Name ) ); 
		}


		private void ShowD2()
		{
			
			AppDomain myDomain = Thread.GetDomain();

			myDomain.SetPrincipalPolicy(PrincipalPolicy.WindowsPrincipal);
			WindowsPrincipal myPrincipal = (WindowsPrincipal)Thread.CurrentPrincipal;
    
			Response.Write( string.Format( "{0} belongs to: ", myPrincipal.Identity.Name.ToString() ) );

			Array wbirFields = Enum.GetValues(typeof(WindowsBuiltInRole));

			foreach (object roleName in wbirFields)
			{
				try
				{
					Response.Write( string.Format( "{0}? {1}.", roleName, myPrincipal.IsInRole((WindowsBuiltInRole)roleName ) ) );
				} 
				catch (Exception)
				{
					Response.Write( string.Format( "{0}: Could not obtain role for this RID.", roleName) );
				}
			}
		}

		private void ShowD3()
		{
			//this.Request.
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
