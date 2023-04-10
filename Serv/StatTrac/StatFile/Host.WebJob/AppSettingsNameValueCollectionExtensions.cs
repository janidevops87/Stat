using Statline.StatTrac.StatFile.Host.WebJob.FileOutput.Sftp;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Net;

namespace Statline.StatTrac.StatFile.Host.WebJob
{
    internal static class AppSettingsNameValueCollectionExtensions
    {
        public static SftpFileOutputOptions GetSftpFileOutputOptions(
            this NameValueCollection appSettings)
        {
            // TODO: Add validation
            return new SftpFileOutputOptions
            {
                SftpServer = new SftpServerOptions
                {
                    ServerUri = new Uri(appSettings["SftpServer.ServerUri"]),
                    Credentials = new NetworkCredential
                    {
                        UserName = appSettings["SftpServer.Credentials.UserName"],
                        Password = appSettings["SftpServer--Credentials--Password"]
                    }
                },
                RootFolder = appSettings["SftpFileOutput.RootFolder"]
            };
        }
    }
}
