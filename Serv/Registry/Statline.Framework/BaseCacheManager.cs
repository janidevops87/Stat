using System;
using Microsoft.Practices.EnterpriseLibrary.Caching;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;

namespace Statline.Framework
{
	public class BaseCacheManager
	{
		#region Fields
		private ICacheManager cache;
		#endregion

		#region Constructor
		protected BaseCacheManager()
		{
		//	cache = EnterpriseLibraryContainer.Current.GetInstance<ICacheManager>();
		}
		#endregion

		#region Methods
		protected void Add(string key, object value)
		{
			cache.Add(key, value);
		}

		protected object this[string key]
		{
			get { return cache[key]; }
		}
		#endregion

	}
}
