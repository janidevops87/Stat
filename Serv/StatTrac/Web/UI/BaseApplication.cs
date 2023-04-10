using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Security;
using System.IO;
using System.Reflection;
using System.Web;
using System.Web.Mail;
using System.Web.SessionState;
using System.Security.Principal;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Configuration;
using Statline.Diagnostics;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI;
using Statline.Registry;
using System.Web.Routing;
using Statline.Framework;
using System.Threading.Tasks;
using Statline.Framework.Logger;
using System.Security.Cryptography.X509Certificates;
using System.Diagnostics;
using Microsoft.Azure.KeyVault;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Framework.Transformation.Connection;
using Microsoft.Practices.EnterpriseLibrary.Security;
using Statline.Helpers;
using System.Linq;

namespace Statline.StatTrac.Web.UI
{

	enum WebMessageSource { Web };


	public class BaseApplication : System.Web.HttpApplication
	{

        protected virtual void RegisterRoutes(RouteCollection routes)
        {
        }

        static BaseApplication()
        {
            // removing code to create instance
            try
            {
                BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]).Write(WebMessageSource.Web.ToString());
            }
            catch { }

        }

        public BaseApplication()
		{
		}	

		protected void Application_Start(Object sender, EventArgs e)
		{

          //  Logger.SetLogWriter(new LogWriterFactory().Create());
            RegisterRoutes(RouteTable.Routes);
			try
			{
                BaseIdentity.ApplicationSecrets = ConfigurationManager.AppSettings.GetDbPasswords();
            }
			catch (Exception ex)
			{
				throw;
			}
           
			AppLogger.CreateInstance("Statline.StatTrac.Web.UI", "General", BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]);        
        }
 
		protected void Session_Start(Object sender, EventArgs e)
		{
		}

		protected void Application_BeginRequest(Object sender, EventArgs e)
		{
			if ( Request.UserLanguages!= null && 
				Request.UserLanguages.Length > 0)
			{
				string browserCulture = Request.UserLanguages[0];

				System.Globalization.CultureInfo requestCulture = 
					new System.Globalization.CultureInfo(browserCulture);
				
				try
				{
					if (requestCulture.IsNeutralCulture)
					{
						requestCulture = new System.Globalization.CultureInfo(
							browserCulture + "-" + browserCulture);
					}
				}
				catch
				{
					requestCulture = new System.Globalization.CultureInfo( "" );
				}

				System.Threading.Thread.CurrentThread.CurrentCulture =
					requestCulture;

				System.Threading.Thread.CurrentThread.CurrentUICulture =
					requestCulture;
			}
		}

		protected void Application_EndRequest(Object sender, EventArgs e)
		{
		}

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
		{
			//THIS IS USED BY PASSTHROUGH LOGIN 
				//if QueryString contains userID and userOrgID
				if(Request.QueryString["userID"] != null &&
					Request.Path.ToString().IndexOf("ReportPassThroughLogin.aspx") == -1
					
					)
				{
					int userID = Convert.ToInt32(Request.QueryString["userID"]);
					int userOrgID = Convert.ToInt32(Request.QueryString["userOrgID"]);
					int reportID = Convert.ToInt32(Request.QueryString["reportID"]);

                    string sessionID = Request.QueryString["sid"];
                    string userName = String.Empty;
					string userDisplayName = String.Empty;
					string userOrganizationName = String.Empty;

					//if Authenticated SetTicket
					bool authenticated = false;
					try
					{
						authenticated = SecurityHelper.Authenticate(
							userID, 
							userOrgID, 
							out userName,
							out userDisplayName,
							out userOrganizationName);
					}
					catch
					{
						authenticated = false;
					}
					if (authenticated)
					{
						try
						{
                             
							TicketManager.SetTicket(userName, true);
						}
						catch 
						{
							//user is not authorized
							QueryStringManager.RedirectToLogin();
						}
							Response.Redirect(
                                "~/ReportPassThroughLogin.aspx?userID="+userID+
							    "&userOrgID="+userOrgID+
                                "&reportID="+reportID+
                                "&userDisplayName="+userDisplayName+
                                "&userOrganizationName="+userOrganizationName+
                                "&userName="+userName +
                                "&sid=" + sessionID);
					}		
					else
					{
						QueryStringManager.RedirectToLogin();
					}
				}

			try
			{
				TicketManager.SetPrincipal();
			}
			catch
			{
				//user is not authorized
				QueryStringManager.RedirectToLogin();				
			}
		}

		protected void Application_Error(Object sender, EventArgs e)
		{

			Exception exception = Server.GetLastError().GetBaseException();

			if( exception != null )
			{				

				ErrorManager.MostRecentException = exception;
				
				if( exception != null )
				{

                    BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]).Write(exception);

					if( exception.GetType() == typeof( ApplicationException ) )
					{
						DisplayMessages.Add( MessageType.ErrorMessage, exception.Message );
					}
					else if( exception.GetType() == typeof( SecurityException ) )
					{
						DisplayMessages.Add( MessageType.ErrorMessage, "Access denied." );
					}
					else
					{
                        BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]).Write(exception);
                        DisplayMessages.Add( MessageType.ErrorMessage, "A system error has occurred.  Please try again later." );
					}
				}
				else
				{
					byte[] rawData = ErrorManager.CreateMessageListBytes();
                    BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]).Write(exception);
                    DisplayMessages.Add( MessageType.ErrorMessage, "A system error has occurred.  Please try again later." );
				}
			}

			SendErrorMessage( ErrorManager.CreateMessageList() );

#if RELEASE
			Server.ClearError();
			MasterPages.Region.UnRegisterRegions();
			Server.Transfer( "~/GeneralError.aspx" );
#endif

		}

		private static void SendErrorMessage(
			string body
			)
		{

			try
			{
				SmtpMail.SmtpServer = ApplicationSettings.GetSetting( SettingName.MailServer );
				MailMessage message = new MailMessage();
				string from = ApplicationSettings.GetSetting( SettingName.TestRecipient );
				string to = ApplicationSettings.GetSetting( SettingName.DeveloperEmails );
				string subject = string.Format( "{0} Error", 
					ApplicationSettings.GetSetting( SettingName.ApplicationName ) );

				message.From = from;
				message.To = to;
				message.Subject = subject;
				message.BodyFormat = MailFormat.Html;
				message.Body = body;

				SmtpMail.Send( message );
			}
			catch( Exception ex )
			{
                BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]).Write(ex);
			}

		}

		protected void Session_End(Object sender, EventArgs e)
		{
		}

		protected void Application_End(Object sender, EventArgs e)
		{
            Logger.Write("Web application ending.");
		}
    }
}
