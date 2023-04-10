using System;
using System.Data;
using System.Web;

using Statline.StatTrac.Data.Types;
//using Statline.StatTrac.Caching;

namespace Statline.StatTrac.Web.UI
{

	public enum SessionNames { NotificationData, CustomerOptionsData, NotificationPolicyData };

	public sealed class SessionManager
	{
		
		/// <summary>
		/// Since all methods of this class are static, don't allow instances of the class to be created.
		/// </summary>
		private SessionManager() {}


		private static void SetValue( SessionNames key, object value )
		{
			HttpContext.Current.Session[ key.ToString() ] = value;
		}

		private static object GetValue( SessionNames key )
		{

			object o = HttpContext.Current.Session[ key.ToString() ] as object;
			
			if( o == null )
			{
				throw new ApplicationException( "Session value not found with key: " + key );
			}

			return o;
		}

	}
}