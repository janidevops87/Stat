using System;
using System.Security.Cryptography;
using System.Web.Security;

namespace Statline.Stattrac.Framework.Security
{
    public class PasswordEncryptor
    {
        public static string CreatePasswordHash(string password, string saltValue)
        {
            string saltAndPwd = string.Concat(password, saltValue);
            return FormsAuthentication.HashPasswordForStoringInConfigFile(saltAndPwd, "SHA1");
        }

        public static string GenerateSaltValue(string password)
        {
            var salt = new byte[password.Length];
            using (var random = new RNGCryptoServiceProvider())
            {
                random.GetNonZeroBytes(salt);
            }

            return Convert.ToBase64String(salt);
        }
    }
}
