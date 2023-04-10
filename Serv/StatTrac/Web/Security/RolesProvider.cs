using System;
using System.Data;
using System.Security.Principal;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Security;
using Microsoft.Practices.EnterpriseLibrary.Security.Cryptography;
using Microsoft.Practices.EnterpriseLibrary.Security.Database;
using Microsoft.Practices.EnterpriseLibrary.Security.Database.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Security.Instrumentation;

namespace Statline.StatTrac.Web.Security
{
	/// <summary>
	/// Summary description for RolesProvider.
	/// </summary>
	public abstract class RolesProvider : ConfigurationProvider, IRolesProvider
	{
		/// <summary>
		/// Contains the configuration settings for this instance.
		/// </summary>
		private string configurationName;
		
		/// <summary>
		/// Verifies the <see cref="IIdentity"/> object and wraps it inside 
		/// a new <see cref="GenericPrincipal"/> object along with any security
		/// roles the user is a member of.
		/// </summary>
		/// <param name="userIdentity">An <see cref="IIdentity"/> object 
		/// representing an authenticated user.
		/// </param>
		/// <returns>
		/// If successfull, returns the populated <see cref="IPrincipal"/> object.
		/// </returns>
		public IPrincipal GetRoles(IIdentity userIdentity)
		{
			ValidateParameters(userIdentity);

			string[] userRoles = CollectAllUserRoles(userIdentity);

			CustomPrincipal userPrincipal = new CustomPrincipal((CustomIdentity)userIdentity, userRoles);

			SecurityRoleLoadEvent.Fire(userIdentity.Name);

			return userPrincipal;
		}

		/// <summary>
		/// Subclasses must override this method to retrieve the associated list of
		/// user roes for the given identity. 
		/// </summary>
		/// <param name="userIdentity">Identity of user used for retrieval</param>
		/// <returns>String array of roles for the given user identity</returns>
		protected abstract string[] CollectAllUserRoles(IIdentity userIdentity);
		
		/// <summary>
		/// Validates the identity.
		/// </summary>
		/// <param name="userIdentity">The identity to validate.</param>
		protected void ValidateParameters(IIdentity userIdentity)
		{
			if (userIdentity == null)
			{
				throw new ArgumentNullException();
			}
			if (userIdentity.Name.Length == 0)
			{
				throw new ArgumentException();
			}
		}	
//		#region IConfigurationProvider Members
//
//		public string ConfigurationName
//		{
//			get { return configurationName; }
//			set { configurationName = value; }
//		
//		}
//
//		public void Initialize(ConfigurationView configurationView)
//		{
//			ArgumentValidation.CheckForNullReference(configurationView, "configurationView");
//			ArgumentValidation.CheckExpectedType(configurationView, typeof(CryptographyConfigurationView));
//
//			this.configurationName = configurationView.ToString();			
//		}
//
//		#endregion
	}
}
