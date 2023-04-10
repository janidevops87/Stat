using System;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Security.Cryptography;
using Microsoft.Practices.EnterpriseLibrary.Validation;
using Microsoft.Practices.EnterpriseLibrary.Validation.Validators;

namespace Statline.StatTrac.Security 
{
	/// <summary>
	/// Summary description for HaspProviderHelper.
	/// </summary>
	public class FakeHashProviderHelper : IHashProvider
	{
		
		/// <summary>
		/// Contains the configuration settings for this instance.
		/// </summary>
		private string configurationName;

		public FakeHashProviderHelper() : base()
		{
			//
			// TODO: Add constructor logic here
			//
		}
		#region IHashProvider Members

		public byte[] CreateHash(byte[] plaintext)
		{
			// TODO:  Add HaspProviderHelper.CreateHash implementation
			return plaintext;
		}

		public bool CompareHash(byte[] plaintext, byte[] hashedtext)
		{
			bool result = false;
			
			// Decode the hashedString and rencode it
			ASCIIEncoding enc = new ASCIIEncoding();
			String hashedString = enc.GetString(hashedtext);
			byte[] newhashedtext = Encoding.ASCII.GetBytes(hashedString);
			result = CryptographyUtility.CompareBytes(newhashedtext, plaintext);
			
			return result;
		}

		#endregion

		/// <summary>
		/// <para>Gets or sets the name of the provider.</para>
		/// </summary>
		/// <value>
		/// <para>The name of the provider.</para>
		/// </value>
		public string ConfigurationName
		{
			get { return configurationName; }
			set { configurationName = value; }
		}

		/// <summary>
		/// <para>Initializes the provider with a <see cref="ConfigurationView"/>.</para>
		/// </summary>
		/// <param name="configurationView">
		/// <para>A <see cref="ConfigurationView"/> object.</para>
		/// </param>
		public void Initialize()
		{
            //Validator viewIsNotNullValidator = new NotNullValidator();
            //Validator viewIsCorrectTypeValidator = new ObjectValidator();
            //viewIsNotNullValidator.Validate(configurationView);
			//ArgumentValidation.CheckExpectedType(configurationView, typeof(CryptographyConfigurationView));

            this.configurationName = "test";//configurationView.ToString();
		}
	}
}
