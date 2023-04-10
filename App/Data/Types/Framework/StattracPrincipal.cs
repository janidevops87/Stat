using System;
using Statline.Stattrac.Framework;
using System.Threading;

namespace Statline.Stattrac.Constant
{
	public sealed class StattracPrincipal: BasePrincipal
	{
		#region Static Methods
		/// <summary>
		/// Get the current Principal
		/// </summary>
		public static StattracPrincipal Principal
		{
			get
			{
				return Thread.CurrentPrincipal as StattracPrincipal;
			}
		} 
		#endregion

		#region Constructor
		private StattracPrincipal(StattracIdentity identity, string[] roles)
			: base(identity, roles){}

		public static void CreatePrincipal(StattracIdentity identity, string[] roles)
		{
			Thread.CurrentPrincipal = new StattracPrincipal(identity, roles);
		}
		#endregion

	}
}
