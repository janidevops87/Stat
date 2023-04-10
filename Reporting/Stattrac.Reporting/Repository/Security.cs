using System;
using System.Security.Cryptography;
using System.Text;

namespace Stattrac.Reporting.Repository
{
    public class Security
    {
        public static string CreatePasswordHash(string value)
        {
            SHA1 algorithm = SHA1.Create();
            byte[] data = algorithm.ComputeHash(Encoding.UTF8.GetBytes(value));
            string sh1 = "";
            for (int i = 0; i < data.Length; i++)
            {
                sh1 += data[i].ToString("x2").ToUpperInvariant();
            }
            return sh1;
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
