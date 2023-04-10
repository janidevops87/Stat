using System;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using Statline.Common;
using Statline.Framework;
using Statline.Helpers;

namespace Statline.StatTrac.StatFax.Windows.Service
{
	internal static class Program
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		private static void Main()
		{
			try
			{
				BaseIdentity.ApplicationSecrets = KeyVaultHelper.GetDbPasswords().GetAwaiter().GetResult().ToDictionary(kvp => kvp.Key, kvp => kvp.Value);
			}
			catch (Exception ex)
			{
				EventLog.WriteEntry("StatFax Error", $"KeyVault Access Error\n{ex.Message}\n{ex.StackTrace}\nCannot proceed without config data.");
				return;
			}
			if (!CanStart())
			{
				return;
			}
			/* uncomment for debug
						if (!Environment.UserInteractive)
						{
			 uncomment for debug */
			// Startup as service.
			ServiceBase[] ServicesToRun;

			// More than one user Service may run within the same process. To add
			// another service to this process, change the following line to
			// create a second service object. For example,
			//
			//   ServicesToRun = new ServiceBase[] {new Service1(), new MySecondUserService()};
			//
			ServicesToRun = new ServiceBase[] { new StatFax() };

			ServiceBase.Run(ServicesToRun);
			/* uncomment for debug
						}
						else
						{
							// Startup as application
							new StatFax().RunProcess();
						}
			 uncomment for debug */
		}

		private static bool CanStart()
		{
			bool result = (BaseIdentity.ApplicationSecrets.ContainsKey(Constants.LoggingPassword) &&
				BaseIdentity.ApplicationSecrets.ContainsKey(Constants.TransactionPassword)
			);
			if (!result)
			{
				EventLog.WriteEntry("StatFax Error", $"Cannot proceed without logging DB and transactional DB passwords.");
			}
			return result;
		}
	}
}
