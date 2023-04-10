using System;
using System.Web.Security;
using System.Security.Principal;

using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.Security
{

	/// <summary>
	/// Provides custom properties and methods for the frameworks.
	/// </summary>
	[Serializable()]
	public class CustomIdentity : IIdentity
	{

		private string domainName = string.Empty;
		private string name = string.Empty;
		private bool authenticated = false;

		/// <summary>
		/// Allows creation of Custom identity
		/// </summary>
		/// <param name="ticket">The forms authentication ticket.</param>
		/// <param name="userId">The unique identifier of the user.
		/// This will be 0 if the user has not successfully authenticated 
		/// or is the anonymous user.</param>
		/// <param name="organizationId">The unique identifier of the organization
		/// to which this user is related. This will be 0 if the user has 
		/// not successfully authenticated or is the anonymous user.</param>
		/// <param name="givenName">The given name of the users contact data.</param>
		/// <param name="surName">The surname of the users contact data.</param>
		/// <param name="authenticated">Denote whether this identity is authenticated.</param>
		public CustomIdentity( 
			string name,
			string domainName,
			bool authenticated )
		{
			this.domainName = domainName;
			this.authenticated = authenticated;
			this.name = name;
		}

		#region IIdentity Members

		/// <summary>
		/// Denotes whether this identity has been authenticated.
		/// </summary>
		public bool IsAuthenticated
		{
			get { return this.authenticated; }
			//get { return this.ticket != null && this.ticket.Name != null && this.ticket.Name.Trim() != ""; }
		}
		/// <summary>
		/// The user name of this identity
		/// </summary>
		public string Name
		{
			get
			{ 
				if( this.authenticated )
				{
					return this.name;
				}
				else
				{
					return "";
				}
			}
		}
		
		public string DomainName
		{
			get
			{
				return this.domainName;
			}
		}


		/// <summary>
		/// Provides the AuthenticationType of which is "Forms"
		/// </summary>
		public string AuthenticationType
		{
			get { return "Forms"; }
		}

		#endregion

		#region Identity Members

		/// <summary>
		/// The user name of this identity.
		/// </summary>
		public string Username
		{
			get { return this.name; }
		}

		#endregion 

	}
}