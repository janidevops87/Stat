namespace Statline.Stattrac.Constant
{
	/// <summary>
	/// Constants used by the Framework module
	/// </summary>
	public class FrameworkConstant
	{
		#region Private Fields
		private readonly string authenticationType;
		private readonly string selectFailed;
		private readonly string saveFailed; 
		#endregion

		#region Singleton Implementation
		private static FrameworkConstant framework;
		protected FrameworkConstant()
		{
			//KeyValueConfigurationCollection keyValueCollection = 
			//   ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None).AppSettings.Settings;

			//if (keyValueCollection["Statline.Stattrac.Constant.FrameworkCnst.AuthenticationType"] == null)
			//   authenticationType = "BaseAuthentication";
			//else
			//   authenticationType = keyValueCollection["Statline.Stattrac.Constant.FrameworkCnst.AuthenticationType"].Value;

			authenticationType = "BaseAuthentication";
			selectFailed = "Select Failed";
			saveFailed = "Save Failed";
		}

		public static FrameworkConstant CreateInstance()
		{
			if (framework == null)
			{
				framework = new FrameworkConstant();
			}
			return framework;
		} 
		#endregion

		#region Public Properties
		/// <summary>
		/// The Type of autehntication used
		/// </summary>
		public string AuthenticationType
		{
			get { return authenticationType; }
		}

		/// <summary>
		/// Message when select fails
		/// </summary>
		public string SelectFailed
		{
			get { return selectFailed; }
		}

		/// <summary>
		/// Message when save fails
		/// </summary>
		public string SaveFailed
		{
			get { return saveFailed; }
		}
		#endregion
	}
}
