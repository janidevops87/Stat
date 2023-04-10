using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Statline.Common
{
    public class Constants
    {
        public static string LoggingPassword = "StatTracWeb--connectionStrings--Logging--password";
        public static string ReportingPassword = "StatTracWeb--connectionStrings--Reporting--password";
        public static string TransactionPassword = "StatTracWeb--connectionStrings--Transaction--password";
        public static string TestPassword = "StatTracWeb--connectionStrings--Test--password";
        public static string DataWarehousePassword = "StatTracWeb--connectionStrings--DataWarehouse--password";
        public static string COPassword = "StatTracWeb--connectionStrings--CO--password";
        public static string WYPassword = "StatTracWeb--connectionStrings--WY--password";
        public static string CTPassword = "StatTracWeb--connectionStrings--CT--password";
        public static string MAPassword = "StatTracWeb--connectionStrings--MA--password";
        public static string MEPassword = "StatTracWeb--connectionStrings--ME--password";
        public static string NHPassword = "StatTracWeb--connectionStrings--NH--password";
        public static string RIPassword = "StatTracWeb--connectionStrings--RI--password";
        public static string VTPassword = "StatTracWeb--connectionStrings--VT--password";
        public static string NVPassword = "StatTracWeb--connectionStrings--NV--password";
        public static string NEPassword = "StatTracWeb--connectionStrings--NE--password";
        public static string HIPassword = "StatTracWeb--connectionStrings--HI--password";
        public static string DMVCommonPassword = "StatTracWeb--connectionStrings--DMVCommon--password";
        public static string ReportingServicesPassword = "StatTracWeb--connectionStrings--ReportingServices--password";

        public static string GetSecretKey(string key)
        {

            switch (key)
            {
                case "Logging":
                    return LoggingPassword;
                case "Reporting":
                    return ReportingPassword;
                case "Transaction":
                    return TransactionPassword;
                case "Test":
                    return TestPassword;
                case "DataWarehouse":
                    return DataWarehousePassword;
                case "CO":
                    return COPassword;
                case "WY":
                    return WYPassword;
                case "CT":
                    return CTPassword;
                case "MA":
                    return MAPassword;
                case "ME":
                    return MEPassword;
                case "NH":
                    return NHPassword;
                case "RI":
                    return RIPassword;
                case "VT":
                    return VTPassword;
                case "NV":
                    return NVPassword;
                case "NE":
                    return NEPassword;
                case "HI":
                    return HIPassword;
                case "DMV_Common":
                    return DMVCommonPassword;
                case "ReportingServicesConnection":
                    return ReportingServicesPassword;
                default:
                    return string.Empty;

            }
        }
    }
}
