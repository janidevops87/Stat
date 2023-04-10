using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Common;
using Statline.Framework;
using Statline.Helpers;
using System;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;

namespace Statline.StatTrac.StatFile.Windows.Service
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main(string[] args)
        {
            try
            {
                BaseIdentity.ApplicationSecrets = KeyVaultHelper.GetDbPasswordsWithImplicitAuth().GetAwaiter().GetResult().ToDictionary(kvp => kvp.Key, kvp => kvp.Value);
            }
            catch (Exception ex)
            {
                EventLog.WriteEntry("StatFile Error", $"KeyVault Access Error\n{ex.Message}\n{ex.StackTrace}\nCannot proceed without config data.");
                Logger.Write("StatFile Error: KeyVault Access Error\n{ex.Message}\n{ex.StackTrace}\nCannot proceed without config data.", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
                return;
            }
            if (!CanStart())
            {
                return;
            }

            // Startup as service.
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] { new StatFile() };

            //Check to see if we're running from within VisualStudio or as a Windows Service
            if (Environment.UserInteractive)
            {
                //Run from within VisualStudio
                StatFile statFileService = new StatFile();
                statFileService.Start(args);
                Console.ReadLine();
                statFileService.RunProcess();
                Console.ReadLine();
                statFileService.Stop();
            }
            else
            {
                //Run as an installed Windows Service
                EventLog.WriteEntry("StatFile", "StatFile Service: started on " + Environment.MachineName);
                Logger.Write("StatFile Service: started on " + Environment.MachineName, Category.Information.ToString(), Convert.ToInt32(Priority.Default));
                ServiceBase.Run(ServicesToRun);
            }
        }

        private static bool CanStart()
        {
            bool result = (BaseIdentity.ApplicationSecrets.ContainsKey(Constants.LoggingPassword) &&
                BaseIdentity.ApplicationSecrets.ContainsKey(Constants.TransactionPassword)
            );
            if (!result)
            {
                EventLog.WriteEntry("StatFile Error", $"Cannot proceed without logging DB and transactional DB passwords.");
                Logger.Write("StatFile Error: Cannot proceed without logging DB and transactional DB passwords.", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
            }
            return result;
        }
    }
}