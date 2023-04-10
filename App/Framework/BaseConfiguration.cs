using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Collections;

namespace Statline.Stattrac.Framework
{
    public enum SettingName
    {
        CommandTimeout,
        QueryRetryIntervalInSeconds,
        QueryAttemptLimit,
        DatabaseError,
        ApplicationName,
        DonorTracURLDefault,
        CriteriaProcessorDefaultOrganizationType,
        CriteriaCallTypeGroup,
        MailServer,
        MailServerPort,
        MailServerUsername,
        MailServerPassword,
        MailServerFrom,
        MailServerTo,
        LoadGridsMaxAttempts
    }
    public class BaseConfiguration
    {
        private static Hashtable settingNames = new Hashtable();

        private BaseConfiguration(){}

        static BaseConfiguration()
        {
            BaseConfiguration.SetKey(SettingName.CommandTimeout, "Command.Timeout");
            BaseConfiguration.SetKey(SettingName.QueryRetryIntervalInSeconds, "QueryRetryIntervalInSeconds");
            BaseConfiguration.SetKey(SettingName.QueryAttemptLimit, "QueryAttemptLimit");
            BaseConfiguration.SetKey(SettingName.DatabaseError, "Database.Error");
            BaseConfiguration.SetKey(SettingName.ApplicationName, "ApplicationName");
            BaseConfiguration.SetKey(SettingName.DonorTracURLDefault, "DonorTracURLDefault");
            BaseConfiguration.SetKey(SettingName.CriteriaProcessorDefaultOrganizationType, "CriteriaProcessorDefaultOrganizationType");
            BaseConfiguration.SetKey(SettingName.CriteriaCallTypeGroup, "CriteriaCallTypeGroup");
            BaseConfiguration.SetKey(SettingName.MailServer, "MailServer");
            BaseConfiguration.SetKey(SettingName.MailServerPort, "MailServerPort");
            BaseConfiguration.SetKey(SettingName.MailServerUsername, "MailServerUsername");
            BaseConfiguration.SetKey(SettingName.MailServerPassword, "MailServerPassword");
            BaseConfiguration.SetKey(SettingName.MailServerFrom, "MailServerFrom");
            BaseConfiguration.SetKey(SettingName.MailServerTo, "MailServerTo");
            BaseConfiguration.SetKey(SettingName.LoadGridsMaxAttempts, "LoadGridsMaxAttempts");

        }
        public static void SetKey(
            Enum settingName,
            string settingKey)
        {
            BaseConfiguration.SetKey(settingName.ToString(), settingKey);
        }

        public static void SetKey(
            string settingName,
            string settingKey)
        {
            settingNames[settingName] = settingKey;
        }

        public static string GetSetting(
            SettingName settingName)
        {
            return BaseConfiguration.GetSetting(settingName.ToString());
        }

        public static string GetSetting(
            Enum settingName)
        {
            return BaseConfiguration.GetSetting(settingName.ToString());
        }

        private static string GetSettingKey(
            string settingName)
        {
            string settingKey = settingNames[settingName].ToString();
            return settingKey;
        }

        public static string GetSetting(
            string settingName)
        {

            string settingKey = GetSettingKey(settingName);
            string setting =
                GetSettingRaw(settingKey);

            return setting;

        }

        public static string GetSettingRaw(
            string settingName)
        {

            object setting = ConfigurationManager.AppSettings[settingName];

            if (setting != null)
            {
                return setting.ToString();
            }
            else
            {
                throw new ArgumentOutOfRangeException(
                    "settingName", settingName, "Setting not found.");
            }

        }

        public static bool GetSettingBool(
            Enum settingName
            )
        {
            return BaseConfiguration.GetSettingBool(settingName.ToString());
        }

        public static bool GetSettingBool(
            string settingName
            )
        {
            string settingValue = BaseConfiguration.GetSetting(settingName);
            try
            {
                return bool.Parse(settingValue);
            }
            catch
            {
                throw new ApplicationException(
                    string.Format("Unable to convert {0} of "
                    + "value {1} to Bool", settingName, settingValue));
            }
        }

        public static byte GetSettingByte(
            Enum settingName
            )
        {
            return BaseConfiguration.GetSettingByte(settingName.ToString());
        }

        public static byte GetSettingByte(
            string settingName
            )
        {
            string settingValue = BaseConfiguration.GetSetting(settingName);
            try
            {
                return Convert.ToByte(settingValue);
            }
            catch
            {
                throw new ApplicationException(
                    string.Format("Unable to convert {0} of "
                    + "value {1} to Byte", settingName, settingValue));
            }
        }

        public static short GetSettingShort(
            Enum settingName
            )
        {
            return BaseConfiguration.GetSettingShort(settingName.ToString());
        }

        public static short GetSettingShort(
            string settingName
            )
        {
            string settingValue = BaseConfiguration.GetSetting(settingName);
            try
            {
                return Convert.ToInt16(settingValue);
            }
            catch
            {
                throw new ApplicationException(
                    string.Format("Unable to convert {0} of "
                    + "value {1} to Short.", settingName, settingValue));
            }
        }

        public static int GetSettingInt(
            Enum settingName
            )
        {
            return BaseConfiguration.GetSettingInt(settingName.ToString());
        }

        public static int GetSettingInt(
            string settingName
            )
        {
            string settingValue = BaseConfiguration.GetSetting(settingName);
            try
            {
                return Convert.ToInt32(settingValue);
            }
            catch
            {
                throw new ApplicationException(
                    string.Format("Unable to convert {0} of "
                    + "value {1} to Int.", settingName, settingValue));
            }
        }

        public static long GetSettingLong(
            Enum settingName
            )
        {
            return BaseConfiguration.GetSettingLong(settingName.ToString());
        }

        public static long GetSettingLong(
            string settingName
            )
        {
            string settingValue = BaseConfiguration.GetSetting(settingName);
            try
            {
                return Convert.ToInt64(settingValue);
            }
            catch
            {
                throw new ApplicationException(
                    string.Format("Unable to convert {0} of "
                    + "value {1} to Long", settingName, settingValue));
            }
        }

    }
}
