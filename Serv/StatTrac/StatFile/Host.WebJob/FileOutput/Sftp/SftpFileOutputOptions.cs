namespace Statline.StatTrac.StatFile.Host.WebJob.FileOutput.Sftp
{
    internal class SftpFileOutputOptions
    {
        public SftpServerOptions SftpServer { get; set; }
        public string RootFolder { get; set; }
    }
}
