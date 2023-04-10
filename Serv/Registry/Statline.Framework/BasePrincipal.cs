using System.Security.Principal;
using System.Threading;

namespace Statline.Framework
{
	public class BasePrincipal : IPrincipal
	{
		#region Private Fields
		public IIdentity Identity { get; protected set; }
		public string[] Roles { get; protected set; }
		#endregion

		#region Constructor
		protected BasePrincipal(BaseIdentity identity, string[] roles)
		{
			Identity = identity;
			Roles = roles;
			Thread.CurrentPrincipal = this;
		}
		#endregion

		#region IPrincipal Members
		/// <summary>
		/// Is the user in the specified role
		/// </summary>
		/// <param name="role"></param>
		/// <returns></returns>
		public bool IsInRole(string role)
		{
			for (int index = 0; index < Roles.Length; index++)
			{
				if (Roles[index] == role)
				{
					return true;
				}
			}
			return false;
		}
		#endregion
	}
}