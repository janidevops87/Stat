using System;
using System.Configuration;
using System.Security.Principal;
using System.Threading;

namespace Statline.Stattrac.Framework
{
	[Serializable]
	public abstract class StatTracIdentity : IIdentity
	{
		#region Constructor
		/// <summary>
		/// Make this private in complience with best design pattern practices
		/// </summary>
		/// <param name="authenticationType"></param>
		/// <param name="isAuthenticated"></param>
		/// <param name="name"></param>
		/// <param name="databaseInstance"></param>
		protected StatTracIdentity(string authenticationType, bool isAuthenticated, string name, string databaseInstance)
		{
			this.AuthenticationType = authenticationType;
			this.IsAuthenticated = isAuthenticated;
			this.Name = name;
			if (!string.IsNullOrEmpty(databaseInstance))
			{
				this.ConnectionString = ConfigurationManager.ConnectionStrings[databaseInstance].ConnectionString;
			}
		}

		/// <summary>
		/// Gets the Identity of the user
		/// </summary>
		public static StatTracIdentity CurrentIdentity
		{
			get
			{
				if (Thread.CurrentPrincipal.Identity is StatTracIdentity)
				{
					return Thread.CurrentPrincipal.Identity as StatTracIdentity;
				}
				else
				{
					throw new Exception("Identity has not been set");
				}
			}
		}
		#endregion

		#region Identity Members
		/// <summary>
		/// The type of authentication
		/// </summary>
		public string AuthenticationType { get; set;}

		/// <summary>
		/// Checks if teh use has been authenticated
		/// </summary>
		public bool IsAuthenticated { get; set;}

		/// <summary>
		/// The name of the user
		/// </summary>
		public string Name { get; set;}

		/// <summary>
		/// The connection string to the database
		/// </summary>
		internal protected string ConnectionString { get; set;}
		#endregion

		#region Abstract
		internal abstract protected string Title { get; }
		internal abstract protected string AppDomainName { get; }
		internal abstract protected string ProcessName { get; }
		internal abstract protected string Win32ThreadId { get; }
		internal abstract protected void AddLogProperties(StatTracLogger logger);
		#endregion

		#region private Methods
		private string GetValueOfConnectionString(string connString, string id)
		{
			int idStart = connString.IndexOf(id) + id.Length;
			int idEnd = connString.IndexOf(";", idStart);
			return connString.Substring(idStart, idEnd - idStart);
		}
		#endregion
	}
}
