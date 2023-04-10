using System;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;
using Statline.Configuration;

namespace Statline.Security
{
	/// <summary>
	/// Provides methods that encrypt and decrypt strings using 
	/// Rijndael encryption algorythims.
	/// </summary>
	public sealed class EncryptionManager
	{

		/// <summary>
		/// Do not allow other classes to create instances fo this class.
		/// </summary>
		private EncryptionManager() {}

		public static string PrivateKeyName
		{
			get
			{
				return SettingName.PK.ToString();
			}
		}

		public static string PrivateKeyString
		{
			get
			{
				string privateKey = ApplicationSettings.GetSetting( SettingName.PK );
				return privateKey;
			}
		}

		private static byte[] PrivateKey
		{
			get
			{
				string privateKey = EncryptionManager.PrivateKeyString;
				byte[] IV = Convert.FromBase64String( privateKey );
				return IV;
			}
		}

		public const string Separator = "//////";

        /// <summary>
		/// Encrypts a clear text string
		/// </summary>
		/// <param name="clearText">The clear text representation of the string to encrypt.</param>
		/// <returns>The encrypted string.</returns>
		public static string EncryptWithSalt( string clearText )
		{
			byte[] IV;
			string encrypted = EncryptionManager.Encrypt( clearText, EncryptionManager.PrivateKey, out IV );
			string salt = Convert.ToBase64String( IV );
			return encrypted + Separator + salt;
		}

		/// <summary>
		/// Decrypts the encrypted string to clear text.
		/// </summary>
		/// <param name="encrypted">The encrypted string.</param>
		/// <param name="salt">Used as the initialization vector for the decryption algorhythm.</param>
		/// <returns>A clear text representation of the encryptted string.</returns>
		public static string DecryptWithSalt( string encryptedWithSalt )
		{
            
			int position = encryptedWithSalt.IndexOf( Separator );

			string encrypted = encryptedWithSalt.Substring( 0, position );
			string salt = encryptedWithSalt.Substring( position + Separator.Length );

			byte[] IV = Convert.FromBase64String( salt );
			string decrypted = EncryptionManager.Decrypt( encrypted, EncryptionManager.PrivateKey, IV );
			return decrypted;
		}

		/// <summary>
		/// Encrypts a clear text string
		/// </summary>
		/// <param name="clearText">The clear text representation of the string to encrypt.</param>
		/// <param name="salt">Used as the initialization vector for the encryption algorhythm.</param>
		/// <returns>The encrypted string.</returns>
		public static string Encrypt( string clearText, out string salt )
		{
			byte[] IV;
			string encrypted = EncryptionManager.Encrypt( clearText, EncryptionManager.PrivateKey, out IV );
			salt = Convert.ToBase64String( IV );
			return encrypted;
		}

		/// <summary>
		/// Decrypts the encrypted string to clear text.
		/// </summary>
		/// <param name="encrypted">The encrypted string.</param>
		/// <param name="salt">Used as the initialization vector for the decryption algorhythm.</param>
		/// <returns>A clear text representation of the encryptted string.</returns>
		public static string Decrypt( string encrypted, string salt )
		{
			byte[] IV = Convert.FromBase64String( salt );
			string decrypted = EncryptionManager.Decrypt( encrypted, EncryptionManager.PrivateKey, IV );
			return decrypted;
		}

		/// <summary>
		/// Encrypts a clear text string
		/// </summary>
		/// <param name="clearText">The clear text representation of the string to encrypt.</param>
		/// <param name="privateKey">The private key defined and used to encrypt the string.</param>
		/// <param name="salt">Used as the initialization vector for the encryption algorhythm.</param>
		/// <returns>The encrypted string.</returns>
		public static string Encrypt( string clearText, byte[] privateKey, out string salt )
		{
			byte[] IV;
			string encrypted = EncryptionManager.Encrypt( clearText, privateKey, out IV );

			salt = Convert.ToBase64String( IV );

			return encrypted;
		}

		/// <summary>
		/// Decrypts the encrypted string to clear text.
		/// </summary>
		/// <param name="encrypted">The encrypted string.</param>
		/// <param name="privateKey">The private key defined and used to encrypt the string.</param>
		/// <param name="salt">Used as the initialization vector for the decryption algorhythm.</param>
		/// <returns>A clear text representation of the encryptted string.</returns>
		public static string Decrypt( string encrypted, byte[] privateKey, string salt )
		{
			byte[] IV = Convert.FromBase64String( salt );

			string decrypted = EncryptionManager.Decrypt( encrypted, privateKey, IV );

			return decrypted;

		}



		/// <summary>
		/// Encrypts a clear text string
		/// </summary>
		/// <param name="clearText">The clear text representation of the string to encrypt.</param>
		/// <param name="privateKey">The private key defined and used to encrypt the string.</param>
		/// <param name="IV">Used as the initialization vector for the encryption algorhythm.</param>
		/// <returns>The encrypted string.</returns>
		public static string Encrypt( string clearText, byte[] privateKey, out byte[] IV )
		{

			ASCIIEncoding textConverter = new ASCIIEncoding();
			RijndaelManaged myRijndael = new RijndaelManaged();

			myRijndael.GenerateIV();

			myRijndael.Key = privateKey;
			IV = myRijndael.IV;

			ICryptoTransform encryptor = myRijndael.CreateEncryptor( privateKey, IV);
            
			MemoryStream msEncrypt = new MemoryStream();
			CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write);

			//Convert the data to a byte array.
			byte[] toEncrypt = textConverter.GetBytes( clearText );

			//Write all data to the crypto stream and flush it.
			csEncrypt.Write(toEncrypt, 0, toEncrypt.Length);
			csEncrypt.FlushFinalBlock();

			//Get encrypted array of bytes.
			string encrypted = Convert.ToBase64String( msEncrypt.ToArray() );

			return encrypted;

		}

		/// <summary>
		/// Decrypts the encrypted string to clear text.
		/// </summary>
		/// <param name="encrypted">The encrypted string.</param>
		/// <param name="privateKey">The private key defined and used to encrypt the string.</param>
		/// <param name="IV">Used as the initialization vector for the decryption algorhythm.</param>
		/// <returns>A clear text representation of the encryptted string.</returns>
		public static string Decrypt( string encrypted, byte[] privateKey, byte[] IV )
		{

			ASCIIEncoding textConverter = new ASCIIEncoding();
			RijndaelManaged myRijndael = new RijndaelManaged();

			myRijndael.Key = privateKey;
			myRijndael.IV = IV;
            
			//Get a decryptor that uses the same key and IV as the encryptor.
			ICryptoTransform decryptor = myRijndael.CreateDecryptor( privateKey, IV );

			byte[] toDecrypt = Convert.FromBase64String( encrypted );

			//Now decrypt the previously encrypted message using the decryptor
			// obtained in the above step.
			MemoryStream msDecrypt = new MemoryStream( toDecrypt );
			CryptoStream csDecrypt = new CryptoStream( msDecrypt, decryptor, CryptoStreamMode.Read);

			byte[] fromEncrypt = new byte[ toDecrypt.Length ];

			//Read the data out of the crypto stream.
			csDecrypt.Read( fromEncrypt, 0, fromEncrypt.Length);

			//Convert the byte array back into a string.
			string decrypted = textConverter.GetString( fromEncrypt ).TrimEnd( (char)0x00 );

			return decrypted;
		}
		/// <summary>
		/// Creates a hashed password from the user's text password and salt values.
		/// </summary>
		/// <param name="password">The user's text password.</param>
		/// <param name="salt">The user's salt value.</param>
		/// <returns>The hashed password created from the password and salt values.</returns>
		/// <remarks>
		/// <P>Name: CreatePasswordHash </P>
		/// <P>Date Created: 5/12/07</P>
		/// <P>Created By: Bret Knoll</P>
		/// <P>Version: 1.0</P>
		/// <P>Task: Encrypt DonorTrac password to a hash code. 
		/// This method was obtained from the DonorTracCode
		/// </P>
		/// </remarks>
		public static string CreatePasswordHash(string password, string salt)
		{
			string saltAndPwd = string.Concat(password, salt);
			string hashedPwd =
				FormsAuthentication.HashPasswordForStoringInConfigFile(
				saltAndPwd, "SHA1");
			return hashedPwd;
		}

	}

}
