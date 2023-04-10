using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Framework;
using System;
using System.Configuration;

namespace Statline.StatTrac.StatRespond.Host.WebJob
{
    class Program
    {
        private static readonly TelemetryClient tc = StatRespondTelemetryClient.Initialize();

        static void Main()
        {
            try
            {
                BaseIdentity.ApplicationSecrets =
                  ConfigurationManager.AppSettings.GetDbPasswords();
            }
            catch (Exception ex)
            {
                var message = $"StatRespond Error: KeyVault Access Error\n{ex.Message}\n{ex.StackTrace}\nCannot proceed without config data.";
                tc.TrackExceptionWithFlush(ex, message);
                Logger.Write(message, Category.Error.ToString(), Convert.ToInt32(Priority.Default));
                throw;
            }
            
            var respondService = new StatRespond();
            respondService.RunProcess();
        }
    }
}
