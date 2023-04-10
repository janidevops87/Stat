using System;
using System.Net;

namespace Statline.StatTrac.StatFile.Host.WebJob.FileOutput.Sftp
{
    internal class SftpServerOptions
    {
        public Uri ServerUri { get; set; }
        public NetworkCredential Credentials { get; set; }
    }
}