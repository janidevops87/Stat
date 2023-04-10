using System;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Statline.Data;
using Statline.Framework;

namespace Statline.Configuration
{

    public enum SettingName
    {
        ApplicationName,
        ApplicationCookieName,
        ApplicationCookieDomain,
        ApplicationEnabled,
        ApplicationTitle,
        CompanyName,
        DatabaseConnectionString,
        MasterPagesPolicy,
        NavigationMenuFileName,
        PK,
        NotificationFrom,
        MailServer,
        AllowOnlineReviewPendingEvents,
        MailDoNotReplyAddress,
        DeveloperEmails,
        LiveMode,
        TestRecipient,
        StatusRecipient,
        ServiceIntervalMinutes,
        MaintenanceFlag,
        MaintenanceMessage,
        ReportingServicesUrl,
        ReportingServicesUserDomain,
        ReportingServicesUsername,
        ReportingServicesPassword,
        ErrorDBConnectionString,
        StatlineAllReferrals,
        ServiceEmployeeID,
        ServiceTimer,
        ExportFileIDList,
        BlockEventReports,
        MenuNameHomeMenu,
        DataBaseCommandTimeOut,
        ProcessFolderName,
        ErrorFolderName,
        ParseStringStart,
        EmailAutoResponseText, EmailUserName,
        EmailPassword,
        QAModuleVersion,        
        IDologyUsername,
        IDologyPassword,
        IDologyWebServiceRequestURL,
        IDologyWebServiceQuestionsURL,
        IDologyWebServiceChallengeURL,
        IDologyWebServiceChallengeAnswersURL,
        IDologyRequestTypeNew,
        IDologyRequestTypeQuestion,
        IDologyRequestTypeChallenge,
        IDologyRequestTypeChallengeQuestion,
        RegistryDynamicRouteMatrix,
        WebServiceURL,
        RoutesEnrollment,
        IDologyCustomerServicePhoneNumber,
        EmailPort,
        ServiceDelayMilliseconds,
        
    };

	public class ApplicationSettings
	{

		private static Hashtable settingNames = new Hashtable();

		private ApplicationSettings(){}

		static ApplicationSettings()
		{

            ApplicationSettings.SetKey(SettingName.ServiceEmployeeID, "Service.EmployeeID");
            ApplicationSettings.SetKey(SettingName.ServiceTimer, "Service.Timer");
            ApplicationSettings.SetKey( SettingName.ApplicationName, "Application.Name" );
			ApplicationSettings.SetKey( SettingName.ApplicationCookieName, "Application.CookieName" );
			ApplicationSettings.SetKey( SettingName.ApplicationCookieDomain, "Application.CookieDomain" );
			ApplicationSettings.SetKey( SettingName.ApplicationEnabled, "Application.Enabled" );
			ApplicationSettings.SetKey( SettingName.ApplicationTitle, "Application.Title" );
			ApplicationSettings.SetKey( SettingName.CompanyName, "Company.Name" );
			ApplicationSettings.SetKey( SettingName.DatabaseConnectionString, "Database.ConnectionString" );
			ApplicationSettings.SetKey( SettingName.MasterPagesPolicy, "MasterPages.Policy" );
			ApplicationSettings.SetKey( SettingName.NavigationMenuFileName, "Navigation.MenuFileName" );
			ApplicationSettings.SetKey( SettingName.PK, "PK" );
			ApplicationSettings.SetKey( SettingName.NotificationFrom, "Notification.From" );
			ApplicationSettings.SetKey( SettingName.MailServer, "Mail.Server" );
            ApplicationSettings.SetKey( SettingName.AllowOnlineReviewPendingEvents, "Allow.OnlineReviewPendingEvents" );
			ApplicationSettings.SetKey( SettingName.MailDoNotReplyAddress, "Mail.DoNotReplyAddress" );
			ApplicationSettings.SetKey( SettingName.DeveloperEmails, "Developer.Emails" );
			ApplicationSettings.SetKey( SettingName.LiveMode, "Live.Mode" );
			ApplicationSettings.SetKey( SettingName.TestRecipient, "Test.Recipient" );
			ApplicationSettings.SetKey( SettingName.StatusRecipient, "Status.Recipient" );
			ApplicationSettings.SetKey( SettingName.ServiceIntervalMinutes, "Service.IntervalMinutes" );
			ApplicationSettings.SetKey( SettingName.MaintenanceFlag, "Maintenance.Flag" );
			ApplicationSettings.SetKey( SettingName.MaintenanceMessage, "Maintenance.Message" );
			ApplicationSettings.SetKey( SettingName.ReportingServicesUrl, "ReportingServices.Url" );
			ApplicationSettings.SetKey( SettingName.ReportingServicesUserDomain, "ReportingServices.UserDomain" );
			ApplicationSettings.SetKey( SettingName.ReportingServicesUsername, "ReportingServices.Username" );
			ApplicationSettings.SetKey( SettingName.ReportingServicesPassword, "ReportingServices.Password" );
			ApplicationSettings.SetKey( SettingName.ErrorDBConnectionString, "ErrorDBConnectionString" );
            ApplicationSettings.SetKey( SettingName.StatlineAllReferrals, "StatlineAllReferrals");
            ApplicationSettings.SetKey(SettingName.QAModuleVersion, "QAModule.Version");
            ApplicationSettings.SetKey(SettingName.ExportFileIDList, "ExportFileID.List");
            ApplicationSettings.SetKey(SettingName.BlockEventReports, "BlockEvent.Reports");
            ApplicationSettings.SetKey(SettingName.MenuNameHomeMenu, "MenuName.HomeMenu");
            ApplicationSettings.SetKey(SettingName.DataBaseCommandTimeOut, "DataBase.CommandTimeOut");
            ApplicationSettings.SetKey(SettingName.ErrorFolderName, "ErrorFolder.Name");
            ApplicationSettings.SetKey(SettingName.ProcessFolderName, "ProcessFolder.Name");
            ApplicationSettings.SetKey(SettingName.ParseStringStart, "Parse.StringStart");
            ApplicationSettings.SetKey(SettingName.EmailAutoResponseText, "Email.AutoResponseText");
            ApplicationSettings.SetKey(SettingName.EmailUserName, "Email.UserName");
            ApplicationSettings.SetKey(SettingName.EmailPassword, "Email.Password");
            ApplicationSettings.SetKey(SettingName.EmailPort, "Email.Port");
            ApplicationSettings.SetKey(SettingName.IDologyUsername, "IDology.Username");
            ApplicationSettings.SetKey(SettingName.IDologyPassword, "IDology.Password");
            ApplicationSettings.SetKey(SettingName.IDologyWebServiceRequestURL, "IDology.WebServiceRequestURL");
            ApplicationSettings.SetKey(SettingName.IDologyWebServiceQuestionsURL, "IDology.WebServiceQuestionsURL");
            ApplicationSettings.SetKey(SettingName.IDologyWebServiceChallengeURL, "IDology.WebServiceChallengeURL");
            ApplicationSettings.SetKey(SettingName.IDologyWebServiceChallengeAnswersURL, "IDology.WebServiceChallengeAnswersURL");
            ApplicationSettings.SetKey(SettingName.IDologyRequestTypeNew, "IDology.RequestTypeNew");
            ApplicationSettings.SetKey(SettingName.IDologyRequestTypeQuestion, "IDology.RequestTypeQuestion");
            ApplicationSettings.SetKey(SettingName.IDologyRequestTypeChallenge, "IDology.RequestTypeChallenge");
            ApplicationSettings.SetKey(SettingName.IDologyRequestTypeChallengeQuestion, "IDology.RequestTypeChallengeQuestion");
            ApplicationSettings.SetKey(SettingName.IDologyCustomerServicePhoneNumber, "IDology.CustomerServicePhoneNumber");
            ApplicationSettings.SetKey(SettingName.WebServiceURL, "WebService.URL");
            ApplicationSettings.SetKey(SettingName.RoutesEnrollment, "Routes.Enrollment");
            ApplicationSettings.SetKey(SettingName.ServiceDelayMilliseconds, "Service.DelayMilliseconds");
        }

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

			object setting = System.Configuration.ConfigurationManager.AppSettings[ settingName ];

			if( setting != null )
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

        //private static ApplicationSettings defaultConfig;
        //class defaultConfig;
       
		public void ConfigUtil()
		{
            //object defaultConfig = Microsoft.Practices.EnterpriseLibrary.Configuration.ConfigurationManager.GetConfiguration("dataConfiguration");
            //System.Configuration.ConfigurationManager
            
		}
        //public static string ClientOrganizations
        //{
        //    get
        //    {
        //        return defaultConfig.ClientOrganizations;
        //    }
        //}
        public static string RS_UserName
        {
            get
            {
                const string instanceName = "ReportingServicesConnection";
                SqlDatabase database = (SqlDatabase)DBCommands.GetDataBase(instanceName);
                string connString = DatabaseHelper.NamedConnectionString(instanceName);
                return GetValueOfConnectionString(connString, "User ID=");
            }
        }
        public static string RS_Password
        {
            get
            {
                const string instanceName = "ReportingServicesConnection";
                string rs_Password = BaseIdentity.ApplicationSecrets[Common.Constants.GetSecretKey(instanceName)];
                // at first read keyVault value
                if (!string.IsNullOrEmpty(rs_Password))
                {
                    return rs_Password;
                }

                SqlDatabase database = (SqlDatabase)DatabaseFactory.CreateDatabase(instanceName);
                string connString = DatabaseHelper.NamedConnectionString(instanceName);
                return GetValueOfConnectionString(connString, "Password=");
            }
        }
        public static string RS_Domain
        {
            get
            {
                string instanceName = "ReportingServicesConnection";

                SqlDatabase database = (SqlDatabase)DatabaseFactory.CreateDatabase(instanceName);
                string connString = DatabaseHelper.NamedConnectionString(instanceName);
                return GetValueOfConnectionString(connString, "Data Source=");
            }
        }
        private static string GetValueOfConnectionString(string connString, string id)
        {
            int idStart = connString.IndexOf(id) + id.Length;
            int idEnd = connString.IndexOf(";", idStart);
            return connString.Substring(idStart, idEnd - idStart);
        }

	}
}