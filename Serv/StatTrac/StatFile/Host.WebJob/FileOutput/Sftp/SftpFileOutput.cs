using Renci.SshNet;
using Renci.SshNet.Common;
using System;
using System.IO;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile.Host.WebJob.FileOutput.Sftp
{
    internal class SftpFileOutput : IFileOutput, IDisposable
    {
        private readonly SftpClient sftpClient;
        private readonly string sftpRootFolder; 

        public SftpFileOutput(SftpFileOutputOptions options)
        {
            if (options == null)
            {
                throw new ArgumentNullException(nameof(options));
            }

            // TODO: Add more validation
            var serverUri = options.SftpServer.ServerUri;
            var credentials = options.SftpServer.Credentials;

            sftpClient = new SftpClient(
                host: serverUri.Host,
                port: serverUri.Port,
                username: credentials.UserName,
                password: credentials.Password);

            sftpRootFolder = options.RootFolder;
        }

        public void Dispose()
        {
            sftpClient?.Dispose();
        }

        public async Task<bool> PathExistsAsync(string path)
        {
            await EnsureConnectedAsync().ConfigureAwait(false);
            path = MapPath(path);
            return await sftpClient.ExistsAsync(path).ConfigureAwait(false);
        }

        public async Task WriteToFileAsync(
            string filePath, 
            Func<Stream, Task> writerCallback)
        {
            await EnsureConnectedAsync().ConfigureAwait(false);

            filePath = MapPath(filePath);

            try
            {
                await WriteToFileCore(filePath, writerCallback).ConfigureAwait(false);
            }
            // Unfortunately we don't always get error-specific exception.
            // I filed a bug here https://github.com/sshnet/SSH.NET/issues/566,
            // but it's sooner that particular server implementation sends incorrect
            // status code for the case when path doesn't exist. As an ugly and bad workaround
            // we have to catch more generic exception. At least we don't swallow it on a 
            // second try after creating needed directory.
            //catch (SftpPathNotFoundException)
            catch (SshException)
            {
                // Lazily create directories.
                await EnsurePath(filePath).ConfigureAwait(false);
                await WriteToFileCore(filePath, writerCallback).ConfigureAwait(false);
            }
        }

        private async Task EnsurePath(string filePath)
        {
            // This client library (or maybe even the server) is not able
            // to create whole directories chain at once, so need to
            // create all directories one by one.
            await EnsurePathRecursively(Path.GetDirectoryName(filePath));
        }

        private async Task EnsurePathRecursively(string directoryPath)
        {
            if (string.Equals(
                Path.GetPathRoot(directoryPath),
                directoryPath, StringComparison.OrdinalIgnoreCase))
            {
                return;
            }

            var parentPath = Path.GetDirectoryName(directoryPath);

            // If we try to create directories which already exist we'll
            // an exception. So we check each time before going deeper. 
            if (!await sftpClient.ExistsAsync(parentPath).ConfigureAwait(false))
            {
                await EnsurePathRecursively(parentPath).ConfigureAwait(false);
            }

            await sftpClient.CreateDirectoryAsync(directoryPath).ConfigureAwait(false);
        }

        private async Task WriteToFileCore(string filePath, Func<Stream, Task> writerCallback)
        {
            using (var sftpStream = await sftpClient.CreateAsync(filePath).ConfigureAwait(false))
            {
                await writerCallback(sftpStream).ConfigureAwait(false);
            }
        }

        private async Task EnsureConnectedAsync()
        {
            if(!sftpClient.IsConnected)
            {
                await sftpClient.ConnectAsync().ConfigureAwait(false);
            }
        }

        private string MapPath(string path)
        {
            if(Path.IsPathRooted(path))
            {
                var root = Path.GetPathRoot(path);
                path = path.Substring(root.Length);
            }

            return Path.Combine(sftpRootFolder, path);
        }
    }
}