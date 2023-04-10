using System;
using System.Collections.Generic;
using System.Configuration;
using System.Security.Principal;
using System.Threading;

namespace Statline.Framework
{
	[Serializable]
	public abstract class BaseIdentity : IIdentity
	{
        public static Dictionary<string, string> ApplicationSecrets { get; set; }

        #region Constructor
        /// <summary>
        /// Make this private in compliance with best design pattern practices
        /// </summary>
        /// <param name="authenticationType"></param>
        /// <param name="isAuthenticated"></param>
        /// <param name="name"></param>
        /// <param name="databaseInstance"></param>
        protected BaseIdentity(string authenticationType, bool isAuthenticated, string name, string databaseInstance)
		{
			this.AuthenticationType = authenticationType;
			this.IsAuthenticated = isAuthenticated;
			this.Name = name;
			if (!string.IsNullOrEmpty(databaseInstance))
			{
                if (ApplicationSecrets != null)
                    this.ConnectionString = ConfigurationManager.ConnectionStrings[databaseInstance].ConnectionString.Replace("@keyvault@", ApplicationSecrets.ContainsKey(databaseInstance) ? (ApplicationSecrets[databaseInstance] ?? String.Empty) : String.Empty);
                else //Document Manager
                    this.ConnectionString = ConfigurationManager.ConnectionStrings[databaseInstance].ConnectionString;
            }
        }

		/// <summary>
		/// Gets teh Identity of teh user
		/// </summary>
		public static BaseIdentity CurrentIdentity
		{
			get
			{
				if (Thread.CurrentPrincipal.Identity is BaseIdentity)
				{
					return Thread.CurrentPrincipal.Identity as BaseIdentity;
				}
				else
				{
					throw new Exception("BaseIdentity has not been set");
				}
			}
		}
		#endregion

		#region IIdentity Members
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
		internal abstract protected void AddLogProperties(BaseLogger baseLogger);
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
