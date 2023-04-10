using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Framework;
using System;
using System.Configuration;

namespace Statline.StatTrac.AutoImport.Host.WebJob
{
    class Program
    {
        private static readonly TelemetryClient tc = AutoImportTelemetryClient.Initialize();

        static void Main()
        {
            try
            {
                BaseIdentity.ApplicationSecrets = 
                    ConfigurationManager.AppSettings.GetDbPasswords();
            }
            catch (Exception ex)
            {
                var message = $"AutoImport Error: KeyVault Access Error\n{ex.Message}\n{ex.StackTrace}\nCannot proceed without config data.";
                tc.TrackExceptionWithFlush(ex, message);
                Logger.Write(message, Category.Error.ToString(), Convert.ToInt32(Priority.Default));
                throw;
            }

            var respondService = new AutoImport();
            respondService.RunProcess();
        }
    }
}
