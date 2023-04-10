using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Common;
using Statline.Framework;
using Statline.StatTrac.StatFile.Host.WebJob.FileOutput.Sftp;
using System;
using System.Configuration;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile.Host.WebJob
{
    class Program
    {
        private static readonly TelemetryClient tc = StatFileTelemetryClient.Initialize();

        static async Task Main(string[] args)
        {
            try
            {
                BaseIdentity.ApplicationSecrets =
                    ConfigurationManager.AppSettings.GetDbPasswords();
            }
            catch (Exception ex)
            {
                tc.TrackExceptionWithFlush(ex, "StatFile Error: KeyVault Access Error, Cannot proceed without config data.");
                Logger.Write($"StatFile Error: KeyVault Access Error\n{ex.Message}\n{ex.StackTrace}\nCannot proceed without config data.", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
                throw;
            }

            if (!CanStart())
            {
                return;
            }

            var fileOutputOptions =
                    ConfigurationManager.AppSettings.GetSftpFileOutputOptions();

            using (var fileOutput = new SftpFileOutput(fileOutputOptions))
            {
                StatFile statFileService = new StatFile(fileOutput);
                await statFileService.RunProcessAsync();
            }
        }

        private static bool CanStart()
        {
            bool result = (BaseIdentity.ApplicationSecrets.ContainsKey(Constants.LoggingPassword) &&
                BaseIdentity.ApplicationSecrets.ContainsKey(Constants.TransactionPassword)
            );
            if (!result)
            {
                tc.TrackExceptionWithFlush("StatFile Error: Cannot proceed without logging DB and transactional DB passwords.");
                Logger.Write("StatFile Error: Cannot proceed without logging DB and transactional DB passwords.", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
            }
            else
            {
                tc.TrackTraceWithFlush("StatFile Started");
            }
            return result;
        }
    }
}
