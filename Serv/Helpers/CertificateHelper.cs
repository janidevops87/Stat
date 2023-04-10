using System;
using System.Configuration;
using System.Diagnostics;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Clients.ActiveDirectory;

namespace Statline.Helpers
{
	public static class CertificateHelper
	{
		public static async Task<string> GetKeyVaultAccessToken(string authority, string resource, string scope)
		{
			X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
			try
			{
				store.Open(OpenFlags.ReadOnly);
				var certThumb = ConfigurationManager.AppSettings["keyVaultCertThumbprint"];
				var cert = store.Certificates.Find(X509FindType.FindByThumbprint, certThumb, false)?[0];
				if (cert == null)
				{
					throw new Exception($"No certificate with thumbprint {certThumb} found.");
				}
				ClientAssertionCertificate assertionCert = new ClientAssertionCertificate(ConfigurationManager.AppSettings["keyVaultClientId"], cert);
				var context = new AuthenticationContext(authority, TokenCache.DefaultShared);
				var result = await context.AcquireTokenAsync(resource, assertionCert);
				return result.AccessToken;
			}
			catch (Exception ex)
			{
				throw;
			}
			finally
			{
				store.Close();
			}
		}
	}
}
