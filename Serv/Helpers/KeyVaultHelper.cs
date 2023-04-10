using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Azure.KeyVault;
using Microsoft.Azure.KeyVault.Models;
using Microsoft.Azure.Services.AppAuthentication;
using Statline.Common;
using Statline.Extensions;
using static Microsoft.Azure.KeyVault.KeyVaultClient;

namespace Statline.Helpers
{
	public static class KeyVaultHelper
	{
        /// <summary>
        /// This method allows different kinds of implicit authentication,
        /// such as using Visual Studio account, Managed Service Identity, 
        /// a certificate specified in an environment variable etc.
        /// More on that: https://docs.microsoft.com/en-us/azure/key-vault/service-to-service-authentication#running-the-application-using-a-service-principal. 
        /// </summary>
        public static async Task<IDictionary<string, string>> GetDbPasswordsWithImplicitAuth()
        {
            var azureServiceTokenProvider = new AzureServiceTokenProvider();
            return await GetDbPasswords(
                new AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback)).ConfigureAwait(false);
        }

        /// <summary>
        /// This method uses a certificate specified in the configuration to authenticate. 
        /// </summary>
        public static async Task<IDictionary<string, string>> GetDbPasswords()
        {
            return await GetDbPasswords(CertificateHelper.GetKeyVaultAccessToken).ConfigureAwait(false);
        }

        private static async Task<IDictionary<string, string>> GetDbPasswords(
            AuthenticationCallback authenticationCallback)
        {
				var retryCount = int.Parse(ConfigurationManager.AppSettings.Get("keyVaultRetryCount"));
				var retryDelay = int.Parse(ConfigurationManager.AppSettings.Get("keyVaultRetryDelay"));
				var vaultBaseUrl = ConfigurationManager.AppSettings.Get("keyVaultBaseUrl");
				var keyVaultClient = new KeyVaultClient(authenticationCallback);
				IList<Task<SecretBundle>> tasks = (
					from ConnectionStringSettings connString in ConfigurationManager.ConnectionStrings
					let secretName = Constants.GetSecretKey(connString.Name)
					where secretName != ""
					select keyVaultClient.GetSecretAsync(vaultBaseUrl, secretName).Retry(retryCount, retryDelay)
				).ToList();
				IDictionary<string, string> result = new Dictionary<string, string>();
				while (tasks.Count > 0)
				{
						var task = await Task.WhenAny(tasks);
						tasks.Remove(task);
						result.Add(task.Result.SecretIdentifier.Name, task.Result.Value);
				}
				return result;
		}
	}
}
