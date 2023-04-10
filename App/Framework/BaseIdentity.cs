using System;
using System.Security.Principal;
using System.Threading;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Base Identity Object
	/// </summary>
	public class BaseIdentity : IIdentity
	{
		#region Private Fields
		/// <summary>
		/// Name of the user
		/// </summary>
		private string name;

		/// <summary>
		/// Is the user Authenticated
		/// </summary>
		private bool isAuthenticated;

		/// <summary>
		/// The database instance to use
		/// </summary>
		private string databaseInstance;

		/// <summary>
		/// Reference to the constant data
		/// </summary>
		private Statline.Stattrac.Constant.FrameworkConstant framework;
		#endregion

		#region Constructor
		/// <summary>
		/// Initilizes the variables
		/// </summary>
		/// <param name="name"></param>
		/// <param name="isAuthenticated"></param>
		/// <param name="databaseInstance"></param>
		public BaseIdentity(string name, bool isAuthenticated, string databaseInstance)
		{
			this.name = name;
			this.isAuthenticated = isAuthenticated;
			this.databaseInstance = databaseInstance;
			framework = Statline.Stattrac.Constant.FrameworkConstant.CreateInstance();
		}
		#endregion

		#region Public Properties
		/// <summary>
		/// The database instance associated with the current user
		/// </summary>
		public string DatabaseInstance
		{
			get { return databaseInstance; }
			set { databaseInstance = value; }
		}

		/// <summary>
		/// The Identity of the current user
		/// </summary>
		public static BaseIdentity CurrentIdentity
		{
			get { return Thread.CurrentPrincipal.Identity as BaseIdentity; }
		}
		#endregion

		#region IIdentity Members
		/// <summary>
		/// The type of authentication
		/// </summary>
		public string AuthenticationType
		{
			get { return framework.AuthenticationType; }
		}

		/// <summary>
		/// Is the user Authenticated
		/// </summary>
		public bool IsAuthenticated
		{
			get { return isAuthenticated; }
		}

		/// <summary>
		/// Name of the user
		/// </summary>
		public string Name
		{
			get { return name; }
		}
		#endregion
	}
}
