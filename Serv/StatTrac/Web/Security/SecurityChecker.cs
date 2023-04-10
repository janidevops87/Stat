using System;
using System.Configuration;
using System.Security.Principal;
using System.Web;
using Microsoft.Practices.EnterpriseLibrary.Security;

namespace Statline.StatTrac.Web.Security
{
	/// <summary>
	/// Summary description for SecurityChecker.
	/// </summary>
	public class SecurityChecker
	{
		
		private SecurityChecker(){}
        public static bool CheckAccessToRule(AuthRule rule)
        {
            CustomPrincipal wp = TicketManager.CurrentPrincipal;
            bool roleValidated = false;

            roleValidated = SecurityHelper.Authorized(rule.ToString(), wp);
            return roleValidated;
        }
		public static bool RedirectIfNotAuthorized(AuthRule rule) 
		{
            
			bool roleValidated = false;
            roleValidated = CheckAccessToRule(rule);
			if(roleValidated)
				return roleValidated;
			
			HttpContext.Current.Response.Redirect( "~/AccessDenied.aspx", true );
			return false;

		}
		public static bool RedirectIfNotUser()
		{
            bool roleValidated = false;
            AuthRule rule = AuthRule.User;
            roleValidated = CheckAccessToRule(rule);

			if(roleValidated)
				return roleValidated;
			
			HttpContext.Current.Response.Redirect( "~/AccessDenied.aspx", true );
			return false;
		}

		public static bool RedirectIfNotAdminstrator()
		{
//			HttpContext current = HttpContext.Current;			
//			WindowsIdentity wi = (WindowsIdentity)current.User.Identity;
//			WindowsPrincipal wp = new WindowsPrincipal(wi);
//			bool roleValidated = false;
//			
//			string userRole = ConfigurationSettings.AppSettings[ "AdminRole" ];
//			string[] userRoleArray = userRole.Split( new char[] { ',' } );
//
//			foreach( string role in userRoleArray )
//			{
//				roleValidated =  wp.IsInRole( role );
//				if( roleValidated )
//					return true;
//			}
//
//			current.Response.Redirect( "~/AccessDenied.aspx", true );
			return false;

		}

	}
}
