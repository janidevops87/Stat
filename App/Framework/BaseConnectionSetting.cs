using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using System.Collections;
using Microsoft.Practices.EnterpriseLibrary.Data.Configuration.Manageability;
using System.Configuration;

namespace Statline.Stattrac.Framework
{
    public class BaseConnectionSetting
    {        
        public string DefaultDatabase
        {
            get { 
                //Database db = EnterpriseLibraryContainer.Current.GetInstance<Database>(); 
                //this hard coded for now need to change this to get the default instance.                 
                 return "Production";
                }
            
        }
        public ArrayList ConnectionStrings
        {
            get 
            {
                ArrayList connectionStringList = new ArrayList();
                ConnectionStringSettingsCollection connectionStrings = ConfigurationManager.ConnectionStrings;
                foreach (ConnectionStringSettings css in connectionStrings)
                    connectionStringList.Add(css.Name);

                return connectionStringList;
            }
        }

        public static object GetMaskedConnectionString(string connectionString)
        {
            object GetMaskedConnectionStringRet = default(object);

            // Make sure we got a valid connection string to mask
            if (string.IsNullOrEmpty(connectionString))
            {
                GetMaskedConnectionStringRet = string.Empty;
            }
            else
            {
                var passwordPositionStart = connectionString.IndexOf(";Password=") + 10;

                // Make sure we found a password in connectionString
                if (passwordPositionStart > 0)
                {
                    var passwordPositionEnd = connectionString.IndexOf(";", passwordPositionStart);
                    var passwordLength = passwordPositionEnd - passwordPositionStart;
                    string password = connectionString.Substring(passwordPositionStart, passwordLength);
                    GetMaskedConnectionStringRet = connectionString.Replace(password, "MaskedForSecurityPurposes");
                }
                else
                {
                    GetMaskedConnectionStringRet = connectionString;
                }
            }

            return GetMaskedConnectionStringRet;
        }

    }
}
