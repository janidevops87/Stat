using System;
using System.Security.Principal;
using System.Text;

namespace Statline.StatTrac.Web.Security
{

	/// <summary>
	/// Defines the special groups used throughout the web application.
	/// </summary>
	public enum SpecialGroups 
	{ 
	
		Administrator,
		Anonymous,
		Everyone,
		User
      	
	};

	public enum MasterPrivileges
	{
		Administrator
	};

	/// <summary>
	/// Provides a principal for the framework.
	/// </summary>
	[Serializable()]
	public class CustomPrincipal : GenericPrincipal, ICloneable
	{


		private CustomIdentity identity;
		private string[] roles;
		
		/// <summary>
		/// Allows creation of the principal
		/// </summary>
		/// <param name="identity">The identity to initialize the
		/// principal.</param>
		/// <param name="roles">The roles/privileges for this principal.</param>
		public CustomPrincipal( CustomIdentity identity, string[] roles )  :base(identity, roles)
		{
			this.identity = identity;
			this.roles = roles;
		}

		/// <summary>
		/// IIdentity implmentation.
		/// </summary>
//		public IIdentity Identity
//		{
//			get { return this.identity; }
//		}

		/// <summary>
		/// IIdentity implmentation.
		/// </summary>
		/// <param name="role">A role to check to see if this principal has.</param>
		/// <returns>True, principal is a member of role, otherwise false.</returns>
//		public bool IsInRole( string role )
//		{
//			foreach( string memberRole in this.roles )
//				if( memberRole == role )
//					return true;
//			return false;
//		}

		public bool IsInRole( MasterPrivileges role )
		{
			return this.IsInRole( role.ToString() );
		}

		/// <summary>
		/// A string array of roles that the principal is a member of.
		/// </summary>
//		public string[] Roles
//		{
//			get { return this.roles; }
//		}

		/// <summary>
		/// The user name of this identity.
		/// </summary>
		public string Username
		{
			get { return identity.Name; }
		}
	
		public string DomainName
		{
			get
			{
				return this.identity.DomainName;
			}
		}


		public bool IsAdministrator
		{
			get { return this.IsInRole( MasterPrivileges.Administrator.ToString() ); }
		}

		public string GetInfoString()
		{
			string lineTerminator = "<br>";

			StringBuilder sb = new StringBuilder();
			sb.AppendFormat( "Username={0}{1}", this.Username, lineTerminator );
			sb.AppendFormat( "DomainName={0}{1}", this.DomainName, lineTerminator );
			sb.AppendFormat( "IsAdministrator={0}{1}", this.IsAdministrator, lineTerminator );
			return sb.ToString();
		}

		public string[] Roles
		{
			get { return roles; }
		}
		public object Clone()
		{
			// Call base class impl.
			CustomPrincipal clone = (CustomPrincipal) base.MemberwiseClone();

			// Perform any additional deep-copying needed, then return.
			//...

			return clone;
			
		}
	}
}
