using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Security.Principal;
using Microsoft.Practices.EnterpriseLibrary.Security.Cryptography;
using Statline.StatTrac.Data.Security;
using Statline.StatTrac.Security;
using Microsoft.Practices.EnterpriseLibrary.Security;
using System.Data;
using System.Web.Security;

namespace Statline.StatTrac.Web.Security
{
    public class DBAuthenticationProvider : IAuthorizationProvider
    {
        //Based on: http://stackoverflow.com/questions/472906/converting-a-string-to-byte-array-without-using-an-encoding-byte-by-byte

        public DBAuthenticationProvider()
        {
        }

        public bool Authenticate(object credentials, out IIdentity userIdentity)
        {
            bool result = false;
            userIdentity = null;

            NetworkCredential namePasswordNetCredentials = credentials as NetworkCredential;
            if (namePasswordNetCredentials != null && namePasswordNetCredentials.UserName.Length > 0)
            {
                userIdentity = new GenericIdentity(namePasswordNetCredentials.UserName, "DBAuthenticationProvider");
                result = true;
            }

            return result;
        }

        private bool PasswordsMatch(byte[] password, string userName)
        {
            var dsPasswordData = RolesDB.GetPassword(userName);
            string passwordValue = System.Text.Encoding.UTF8.GetString(password);
            string saltValue = string.Empty;
            string hashedPassword = string.Empty;

            if (dsPasswordData.Tables.Count > 0 && dsPasswordData.Tables[0].Rows.Count > 0)
            {
                DataRow row = dsPasswordData.Tables[0].Rows[0];
                saltValue = row["SaltValue"] != DBNull.Value ? (string)row["SaltValue"] : string.Empty;
                hashedPassword = row["HashedPassword"] != DBNull.Value ? (string)row["HashedPassword"] : string.Empty;
            }

            if (hashedPassword != null)
            {
                string targetPassword = SecurityHelper.CreatePasswordHash(passwordValue, saltValue);
                //check if the password matches current
                return hashedPassword.Equals(targetPassword);
            }

            return false;
        }

        #region IAuthorizationProvider Members

        public bool Authorize(IPrincipal principal, string context)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
