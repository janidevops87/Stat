using System;
using System.Collections;
using System.Configuration;

namespace Statline.StatTrac.AutoImport.Configuration
{
	#region enum
	/// <summary>
	/// Provides a list of settings available to the application and set in the configuration file. 
	/// </summary>
	public enum SettingName 
	{
		ApplicationName,
		ProcessFolderName,
		ErrorFolderName,
		ProfileName,
		ProfilePassword,
		TimerSetting,
		ImportCoordinatorEmployeeID,
		ImportCoordinatorPersonID,
        EmailUserName,
        EmailPassword,
        WebServiceURL,
        ParseSenderNameAllowedEmailDomains
	};
	#endregion

	/// <summary>
	/// Provides the application access to the configuration file data.
	/// </summary>
	/// <remarks>
	/// <P>Name: Application Settings</P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: provide configuration data for application</P>
	/// </remarks>	
	public class ApplicationSettings
	{
		#region class objects
		private static Hashtable settingNames = new Hashtable();
		#endregion
		
		#region class constructors
		private ApplicationSettings(){}

		static ApplicationSettings()
		{
			
			ApplicationSettings.SetKey( SettingName.ProfilePassword, "Profile.Password" );			
			ApplicationSettings.SetKey( SettingName.ImportCoordinatorPersonID, "ImportCoordinator.PersonID" );
			ApplicationSettings.SetKey( SettingName.ImportCoordinatorEmployeeID, "ImportCoordinator.EmployeeID" );
			ApplicationSettings.SetKey( SettingName.TimerSetting, "Timer.Setting" );
			ApplicationSettings.SetKey( SettingName.ApplicationName, "Application.Name" );
			ApplicationSettings.SetKey( SettingName.ErrorFolderName, "ErrorFolder.Name" );
			ApplicationSettings.SetKey( SettingName.ProcessFolderName, "ProcessFolder.Name" );
			ApplicationSettings.SetKey( SettingName.ProfileName, "Profile.Name" );
            ApplicationSettings.SetKey(SettingName.EmailUserName, "Email.UserName");
            ApplicationSettings.SetKey(SettingName.EmailPassword, "Email.Password");
            ApplicationSettings.SetKey(SettingName.WebServiceURL, "WebService.URL");
            ApplicationSettings.SetKey(SettingName.ParseSenderNameAllowedEmailDomains, "ParseSenderName.AllowedEmailDomains");

		}
		#endregion

		#region class Methods
		public static void SetKey( 
			Enum settingName, 
			string settingKey )
		{
			ApplicationSettings.SetKey( settingName.ToString(), settingKey );
		}

		public static void SetKey( 
			string settingName, 
			string settingKey )
		{
			settingNames[ settingName ] = settingKey;
		}

		public static string GetSetting( 
			SettingName settingName ) 
		{
			return ApplicationSettings.GetSetting( settingName.ToString() );
		}

		public static string GetSetting( 
			Enum settingName ) 
		{
			return ApplicationSettings.GetSetting( settingName.ToString() );
		}

		private static string GetSettingKey( 
			string settingName )
		{
			string settingKey = settingNames[ settingName ].ToString();
			return settingKey;
		}

		public static string GetSetting( 
			string settingName ) 
		{

			string settingKey = GetSettingKey( settingName );
			string setting = 
				GetSettingRaw( settingKey );

			return setting;

		}

		public static string GetSettingRaw( 
			string settingName ) 
		{

			object setting =
                ConfigurationManager.AppSettings[ settingName ];
            
            if ( setting != null )
			{
				return setting.ToString();
			}
			else
			{
				throw new ArgumentOutOfRangeException( 
					"settingName", settingName, "Setting not found." );
			}

		}

		public static bool GetSettingBool( 
			Enum settingName
			)
		{
			return ApplicationSettings.GetSettingBool( settingName.ToString() );
		}

		public static bool GetSettingBool( 
			string settingName
			)
		{
			string settingValue = ApplicationSettings.GetSetting( settingName );
			try
			{
				return bool.Parse( settingValue );
			}
			catch
			{
				throw new ApplicationException( 
					string.Format( "Unable to convert {0} of "
					+ "value {1} to Bool", settingName, settingValue ) );
			}
		}

		public static byte GetSettingByte( 
			Enum settingName
			)
		{
			return ApplicationSettings.GetSettingByte( settingName.ToString() );
		}

		public static byte GetSettingByte( 
			string settingName
			)
		{
			string settingValue = ApplicationSettings.GetSetting( settingName );
			try
			{
				return Convert.ToByte( settingValue );
			}
			catch
			{
				throw new ApplicationException( 
					string.Format( "Unable to convert {0} of "
					+ "value {1} to Byte", settingName, settingValue ) );
			}
		}

		public static short GetSettingShort(
			Enum settingName
			)
		{
			return ApplicationSettings.GetSettingShort( settingName.ToString() );
		}

		public static short GetSettingShort(
			string settingName
			)
		{
			string settingValue = ApplicationSettings.GetSetting( settingName );
			try
			{
				return Convert.ToInt16( settingValue );
			}
			catch
			{
				throw new ApplicationException( 
					string.Format( "Unable to convert {0} of "
					+ "value {1} to Short.", settingName, settingValue ) );
			}
		}

		public static int GetSettingInt( 
			Enum settingName
			)
		{
			return ApplicationSettings.GetSettingInt( settingName.ToString() );
		}
		
		public static int GetSettingInt( 
			string settingName
			)
		{
			string settingValue = ApplicationSettings.GetSetting( settingName );
			try
			{
				return Convert.ToInt32( settingValue );
			}
			catch
			{
				throw new ApplicationException( 
					string.Format( "Unable to convert {0} of "
					+ "value {1} to Int.", settingName, settingValue ) );
			}
		}

		public static long GetSettingLong( 
			Enum settingName
			)
		{
			return ApplicationSettings.GetSettingLong( settingName.ToString() );
		}

		public static long GetSettingLong( 
			string settingName
			)
		{
			string settingValue = ApplicationSettings.GetSetting( settingName );
			try
			{
				return Convert.ToInt64( settingValue );
			}
			catch
			{
				throw new ApplicationException( 
					string.Format( "Unable to convert {0} of "
					+ "value {1} to Long", settingName, settingValue ) );
			}
		}
		#endregion
	}
}
