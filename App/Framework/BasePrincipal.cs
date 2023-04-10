using System.Security.Principal;
using System.Threading;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Base principal for the user
	/// </summary>
	public class BasePrincipal : IPrincipal
	{
		#region Private Fields
		private BaseIdentity identity;
		private string[] roles;
		#endregion

		#region Constructor
		public BasePrincipal(BaseIdentity identity, string[] roles) 
		{
			this.identity = identity;
			this.roles = roles;
			Thread.CurrentPrincipal = this;
		}
		#endregion

		#region IPrincipal Members
		/// <summary>
		/// Identity of the user
		/// </summary>
		public IIdentity Identity
		{
			get { return identity; }
		}

		/// <summary>
		/// Is the user in the specified role
		/// </summary>
		/// <param name="role"></param>
		/// <returns></returns>
		public bool IsInRole(string role)
		{
			for (int index = 0; index < roles.Length; index++)
			{
				if (roles[index] == role)
				{
					return true;
				}
			}
			return false;
		}
		#endregion
	}
}
