using System;
using System.Configuration;

using Statline.Configuration;
using Statline.Security;

namespace Statline.Data
{
	/// <summary>
	/// Helper class that provides static only methods and connection string 
	/// information to all CampaignAdvantage DB access objects.
	/// </summary>
	public sealed class DatabaseHelper
	{
		/// <summary>
		/// Private constructor prevents creating an instance of this class.
		/// </summary>
		private DatabaseHelper(){}

		public static string ConnectionString
		{
			get
			{

				string connectionString;
				
                //connectionString = ApplicationSettings.GetSetting( SettingName.DatabaseConnectionString );
                //connectionString = EncryptionManager.DecryptWithSalt( connectionString );
                connectionString = ConfigurationManager.ConnectionStrings["Transaction"].ToString();

				return connectionString;

			}
		}

        public static string NamedConnectionString(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                return ConfigurationManager.ConnectionStrings["Transaction"].ToString();
            }
            else
            {
                return ConfigurationManager.ConnectionStrings[name].ToString();
            }
        }

	}
}