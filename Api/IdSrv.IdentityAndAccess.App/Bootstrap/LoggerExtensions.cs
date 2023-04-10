using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Extensions.Logging;

namespace Statline.IdentityServer.IdentityAndAccess.App.Bootstrap
{
    internal static class LoggerExtensions
    {
        public static void LogAppBootstrappedCheck(this ILogger logger)
        {
            logger.LogInformation("Checking if application is already bootstrapped...");
        }

        public static void LogAppAlreadyBootstrapped(this ILogger logger)
        {
            logger.LogInformation("Application is already bootstrapped, exiting.");
        }

        public static void LogAppBootstrapFinished(this ILogger logger)
        {
            logger.LogInformation("Application bootstrapped successfully!");
        }

        public static void LogCreatingTenant(this ILogger logger, string organizationName)
        {
            logger.LogInformation("Creating tenant for organization '{OrgName}'...", 
                organizationName);
        }

        public static void LogCreatingUser(this ILogger logger, string userName)
        {
            logger.LogInformation("Creating user '{UserName}'...",
                userName);
        }

        public static void LogCreatingRole(this ILogger logger, string roleName)
        {
            logger.LogInformation("Creating user '{RoleName}'...",
                roleName);
        }

        public static void LogAddingUserToRole(
            this ILogger logger, 
            string userName,
            string roleName)
        {
            logger.LogInformation("Adding user '{UserName}' to role '{RoleName}'...",
                userName,
                roleName);
        }
    }
}
