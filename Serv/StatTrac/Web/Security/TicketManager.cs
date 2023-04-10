using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Web;
using System.Web.Security;
using Statline.Configuration;
using Statline.StatTrac.Web.UI;

namespace Statline.StatTrac.Web.Security
{
	/// <summary>
	/// Summary description for TicketManager.
	/// </summary>
	public class TicketManager
	{
		
		private TicketManager() {}

		private const byte TicketTimeOutDurationHours = 1;
        
		#region Ticket Methods

		private static string TicketName
		{
			get
			{
				return ApplicationSettings.GetSetting( SettingName.ApplicationCookieName );
			}
		}

		/// <summary>
		/// Creates a forms authentication ticket in the form of a cookie.
		/// </summary>
		/// <param name="userId">The unique identifier of the user.</param>
		/// <param name="persistCookie">If true, persist cookie in the client
		/// browser until a specified timeout period.</param>
		/// <returns>A cookie representation of a Forms authentication ticket.</returns>
		public static HttpCookie CreateTicket( 
			string userName, 
			bool persistCookie 
			)
		{

			CustomPrincipal cPrincipal;
			CustomIdentity cIdentity;

			cIdentity = 
				new CustomIdentity(
					userName,
					CookieDomain, 
					true);
			
			cPrincipal = SecurityHelper.GetPrincipal(cIdentity);
			
			
			string userData = EncodeUserData(cPrincipal.Roles, userName);
					
			int version = 1;
			DateTime issueDate = DateTime.Now;
			DateTime expiration =
				issueDate.AddHours( 
				TicketTimeOutDurationHours );

			FormsAuthenticationTicket authTicket =
				new FormsAuthenticationTicket(
					version,
					userName,
					issueDate,
					expiration, 
					persistCookie,
					userData
				);

			string encryptedTicket = 
				FormsAuthentication.Encrypt( authTicket );

			HttpCookie authCookie = new HttpCookie(
				TicketName , encryptedTicket );

			authCookie.Domain = TicketManager.CookieDomain;
			
			return authCookie;
		}

		private static string CookieDomain
		{
			get
			{
				return ApplicationSettings.GetSetting( SettingName.ApplicationCookieDomain );
			}
		}

		/// <summary>
		/// Sets the Forms authentication ticket or cookie for a user.
		/// </summary>
		/// <param name="userId">The unique identifier of the user.</param>
		/// <param name="persistCookie">If true, persist cookie in the client
		/// browser until a specified timeout period.</param>
		public static void SetTicket( 
			string userName, 
			bool persistCookie )
		{

			HttpCookie authCookie = 
				CreateTicket( userName, persistCookie );

			HttpContext.Current.Response.Cookies.Add( authCookie );

		}

		public static void DestroyTicket()
		{
			HttpContext context = HttpContext.Current;
			HttpCookie cookie = new HttpCookie( TicketName );
			cookie.Expires = DateTime.Now.AddDays( -2 );
			cookie.Domain = CookieDomain;
			context.Response.Cookies.Add( cookie );
 		}

		#endregion

		#region Principal Methods

		/// <summary>
		/// Creates an  principal for the current authenticated or anonymous
		/// user for use within the framwork.
		/// </summary>
		/// <returns>The newly created Principal.</returns>
		public static CustomPrincipal CreatePrincipal()
		{

			//use to kill a cookie 
			//DestroyTicket();	
			
			HttpCookie authCookie = 
				HttpContext.Current.Request.Cookies[TicketName];
			
			string domain = "";
			string userName = "";
			bool authenticated = false;
			string[] roles;
			CustomPrincipal cPrincipal;
			CustomIdentity cIdentity;

			FormsAuthenticationTicket ticket = null;

			if( authCookie != null )
			{
				try
				{
					ticket = FormsAuthentication.Decrypt( authCookie.Value );
				}
				catch( Exception ex )
				{
					string s = ex.Message;
					FormsAuthentication.SignOut();
					DestroyTicket();
					//QueryStringManager.RedirectToHomePage();
				}
				DecodeUserData(ticket.UserData, out userName, out roles);
				

				cIdentity = 
					new CustomIdentity(
					userName,
					CookieDomain, 
					true);
				cPrincipal = new CustomPrincipal(cIdentity, roles);
			}
			else
			{
				// create a unauthenticated CustomPrincipal
				ticket = new FormsAuthenticationTicket( "", false, 60 );
				roles = new string[] { AuthRule.Anonymous.ToString() };
				authenticated = false;
				domain = "";
				
				CustomIdentity identity = 
				new CustomIdentity( 
				"", 
				domain,
				authenticated
				);
				
				cPrincipal = new CustomPrincipal(identity, roles);
			}

			return cPrincipal;

		}

		/// <summary>
		/// Provides access the current  principal.
		/// </summary>
		public static CustomPrincipal CurrentPrincipal
		{

			get
			{

				HttpContext context = HttpContext.Current;
				if( context != null )
				{
					CustomPrincipal principal = 
						context.User as CustomPrincipal;

					if( principal != null )
					{
						return principal;
					}
					else
					{
						throw new InvalidOperationException( "Invalid principal" );
					}
				}
				else
				{
						throw new InvalidOperationException( "HttpContext is null" );
				}

			}

		}

		/// <summary>
		/// Sets the current Http context thread principal to the 
		///  principal.
		/// </summary>
		public static void SetPrincipal()
		{
			CustomPrincipal principal = 
				CreatePrincipal();

			HttpContext.Current.User = principal;

		}

		#endregion

		#region Encode/Decode

		/// <summary>
		/// Encodes the Identity and Principal user data.
		/// </summary>
		/// <param name="userId">The unique identifier of the user.</param>
		/// <param name="contactId">The unique identifier for 
		/// the contact record related to this user.</param>
		/// <param name="organizationId">The unique identifier of the organization to
		/// which this user is related.</param>
		/// <param name="firstName">The given name for the contact record related to this user.</param>
		/// <param name="lastName">The surname for the contact record related to this user.</param>
		/// <param name="emailAddress">The email address for the contact record related to this user.</param>
		/// <param name="roles">A string array of roles that the principal is a member of.</param>
		/// <returns>The encoded data.</returns>
		private static string EncodeUserData(
			string[] roles,
			string userName
			)
		{

			string roleString = string.Join( "|", roles );
			string[] values = 
				new string[]
						{
							roleString,
							userName
						};

			return string.Join( "\r", values );

		}

		/// <summary>
		/// Decodes the Identity and Principal user data.
		/// </summary>
		/// <param name="userData">The encoded user data.</param>
		/// <param name="userId">The unique identifier of the user.</param>
		/// <param name="organizationId">The unique identifier of the organization to
		/// which this user is related.</param>
		/// <param name="firstName">The given name for the contact record related to this user.</param>
		/// <param name="lastName">The surname for the contact record related to this user.</param>
		/// <param name="emailAddress">The email address for the contact record related to this user.</param>
		/// <param name="roles">A string array of roles that the principal is a member of.</param>
		/// <returns>The decoded data.</returns>
		private static void DecodeUserData( 
			string userData,
			out string userName,
			out string[] roles
			)
		{

			string[] values = userData.Split( '\r' );
			string roleString = values[0];
			userName = values[1];
			roles = roleString.Split( '|' );

		}
		
		private static string EncodeCustomPrincipal (
			CustomPrincipal cPrincipal
			)
		{
			
			BinaryFormatter bf = new BinaryFormatter();
			byte[] serializedObject;
			string cPrincipalString;
			StringBuilder sp = new StringBuilder();
			UnicodeEncoding enc = new UnicodeEncoding(); 
			using(MemoryStream ms = new MemoryStream() )
			{
				bf.Serialize(ms, cPrincipal);
				ms.Seek(0, 0);
				serializedObject = ms.ToArray();
				
			}
			
			for(int forLoopCounter = 0; forLoopCounter<serializedObject.Length;forLoopCounter++ )
			{
				
				sp.Append(serializedObject[forLoopCounter].ToString());
				sp.Append("|");
				
			}
			//remove the last |
			sp.Remove(sp.Length-1, 1);
			
			cPrincipalString = sp.ToString();
			
			return cPrincipalString;
		}
		
		private static CustomPrincipal DecodeCustomPrincipal (
			string cPrincipalString
			)
		{
			
			//if string is empty return an emptyp unathenticated CustomPrincipal
			if (cPrincipalString == String.Empty)
				return new CustomPrincipal(new CustomIdentity("","",false), new string[1]{AuthRule.Anonymous.ToString()});
			//convert the | string into a string array
			string[] byteString = cPrincipalString.Split('|');
			
			//set the byte array and loop throught the string array converting the string to bytes.
			byte[] serializedObject = new byte[byteString.Length];
			for (int forLoopCounter=0;forLoopCounter<byteString.Length;forLoopCounter++)
			{
				serializedObject[forLoopCounter] = byte.Parse(byteString[forLoopCounter].ToString());
			}
			
			CustomPrincipal cPrincipal;
			BinaryFormatter bf = new BinaryFormatter();
		
			using(MemoryStream ms = new MemoryStream(serializedObject) )
			{
				
				cPrincipal = (CustomPrincipal)bf.Deserialize(ms);
			}
			return cPrincipal;
		}
		#endregion

	}
}