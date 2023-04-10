using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Registry.Common.Util
{
	public sealed class EncryptionManager
	{
		private const string Separator = "//////";
		private static byte[] PrivateKey { get { return Convert.FromBase64String("AQIDBAUGBwgJEBESExQVFg=="); } }

		public static string Decrypt(string encryptedWithSalt)
		{
			int position = encryptedWithSalt.IndexOf(Separator);
			string encrypted = encryptedWithSalt.Substring(0, position);
			string salt = encryptedWithSalt.Substring(position + Separator.Length);
			byte[] IV = Convert.FromBase64String(salt);
			return EncryptionManager.Decrypt(encrypted, EncryptionManager.PrivateKey, IV);
		}

		private static string Decrypt(string encrypted, byte[] privateKey, byte[] IV)
		{
			ASCIIEncoding textConverter = new ASCIIEncoding();
			RijndaelManaged myRijndael = new RijndaelManaged();

			//Get a decryptor that uses the same key and IV as the encryptor.
			ICryptoTransform decryptor = myRijndael.CreateDecryptor(privateKey, IV);
			byte[] toDecrypt = Convert.FromBase64String(encrypted);

			//Now decrypt the previously encrypted message using the decryptor
			// obtained in the above step.
			MemoryStream msDecrypt = new MemoryStream(toDecrypt);
			CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read);
			byte[] fromEncrypt = new byte[toDecrypt.Length];

			//Read the data out of the crypto stream.
			csDecrypt.Read(fromEncrypt, 0, fromEncrypt.Length);

			//Convert the byte array back into a string.
			return textConverter.GetString(fromEncrypt).TrimEnd((char)0x00);
		}
	}
}
